import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/data/db/app_database.dart';
import 'package:kalendar_samogon/data/repositories/batch_repository.dart';
import 'package:kalendar_samogon/data/repositories/production_repository.dart';
import 'package:kalendar_samogon/data/repositories/recipe_repository.dart';
import 'package:kalendar_samogon/services/backup_service.dart';

void main() {
  late AppDatabase db;
  late RecipeRepository recipes;
  late BatchRepository batches;
  late ProductionRepository production;
  late BackupService backup;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    recipes = RecipeRepository(db);
    batches = BatchRepository(db);
    production = ProductionRepository(db);
    backup = BackupService(db);
  });

  test('свой рецепт создаётся с составом и шагами', () async {
    final id = await recipes.createRecipe(
      title: 'Вишнёвка крепкая',
      kind: 'tincture',
      summary: 'Больше спирта, меньше сахара',
      baseVolumeL: 3,
      expectedAbv: 35,
      ingredients: const [
        (name: 'Вишня', amount: 800, unit: 'г', note: ''),
        (name: 'Спирт 96', amount: 1.2, unit: 'л', note: ''),
      ],
      steps: const [
        (
          title: 'Залить вишню спиртом',
          description: 'Размять ягоды',
          offsetDays: 0,
          durationMin: 20,
          tempC: null,
          eventKind: 'start',
          repeatEveryDays: null,
          repeatUntilDay: null,
          repeatTitle: '',
        ),
        (
          title: 'Слить и отфильтровать',
          description: '',
          offsetDays: 21,
          durationMin: null,
          tempC: null,
          eventKind: 'strain',
          repeatEveryDays: null,
          repeatUntilDay: null,
          repeatTitle: '',
        ),
      ],
    );

    final recipe = await recipes.byId(id);
    expect(recipe, isNotNull);
    expect(recipe!.title, 'Вишнёвка крепкая');
    expect(recipe.isBuiltIn, isFalse);
    expect(recipe.expectedAbv, 35);

    final ingredients = await recipes.ingredients(id);
    expect(ingredients.length, 2);
    expect(ingredients.first.name, 'Вишня');
    expect(ingredients.first.amount, 800);

    final steps = await recipes.steps(id);
    expect(steps.length, 2);
    expect(steps.last.offsetDays, 21);
    expect(steps.last.eventKind, 'strain');
  });

  test('правка рецепта заменяет состав, а не дописывает', () async {
    final id = await recipes.createRecipe(
      title: 'Наливка',
      kind: 'liqueur',
      ingredients: const [
        (name: 'Сахар', amount: 200, unit: 'г', note: ''),
      ],
    );

    await recipes.updateRecipe(
      id: id,
      title: 'Наливка сладкая',
      ingredients: const [
        (name: 'Сахар', amount: 300, unit: 'г', note: ''),
        (name: 'Вода', amount: 500, unit: 'мл', note: ''),
      ],
    );

    final recipe = await recipes.byId(id);
    expect(recipe!.title, 'Наливка сладкая');
    final ingredients = await recipes.ingredients(id);
    expect(ingredients.length, 2);
    expect(ingredients.first.amount, 300);
  });

  test('встроенный рецепт удалить нельзя, свой — можно', () async {
    await db.into(db.recipes).insert(
          RecipesCompanion.insert(
            id: 'builtin-1',
            title: 'Встроенный',
            kind: 'sugar_wash',
            isBuiltIn: const Value(true),
          ),
        );
    final ownId = await recipes.createRecipe(title: 'Свой', kind: 'tincture');

    expect(await recipes.deleteOwnRecipe('builtin-1'), isFalse);
    expect(await recipes.byId('builtin-1'), isNotNull);

    expect(await recipes.deleteOwnRecipe(ownId), isTrue);
    expect(await recipes.byId(ownId), isNull);
  });

  test('прогноз выдержки учитывает испарение', () {
    final started = DateTime(2025, 1, 1);
    final halfYear = ProductionRepository.projectedVolume(
      volumeL: 20,
      startedAt: started,
      at: DateTime(2025, 7, 1),
      angelSharePctYear: 3,
    );
    // Полгода при 3 %/год — теряется около половины годового процента.
    expect(halfYear, lessThan(20));
    expect(halfYear, greaterThan(19.5));

    final twoYears = ProductionRepository.projectedVolume(
      volumeL: 20,
      startedAt: started,
      at: DateTime(2027, 1, 1),
      angelSharePctYear: 3,
    );
    expect(twoYears, closeTo(18.82, 0.1));

    // Без потерь объём не меняется.
    final noLoss = ProductionRepository.projectedVolume(
      volumeL: 20,
      startedAt: started,
      at: DateTime(2027, 1, 1),
      angelSharePctYear: 0,
    );
    expect(noLoss, 20);
  });

  test('бэкап переносит таблицы M2 целиком', () async {
    await db.into(db.vessels).insert(
          VesselsCompanion.insert(
            id: 'v1',
            name: 'Бочка 10 л',
            kind: 'barrel',
            volumeL: 10,
            material: const Value('дуб'),
          ),
        );
    final recipeId =
        await recipes.createRecipe(title: 'Вишнёвка', kind: 'tincture');
    final recipe = await recipes.byId(recipeId);
    final batchId = await batches.createFromRecipe(
      recipe: recipe!,
      steps: await recipes.steps(recipeId),
      startedAt: DateTime(2026, 1, 10),
      volumeL: 3,
    );
    await production.startAging(
      batchId: batchId,
      vesselId: 'v1',
      startedAt: DateTime(2026, 2, 1),
      angelSharePctYear: 5,
    );
    await production.addTasting(
      batchId: batchId,
      rating: 4,
      aroma: 'вишня',
      taste: 'насыщенно',
      finish: 'долгое',
      verdict: 'меньше сахара',
      photoPath: '/tmp/photo.jpg',
    );

    final dump = await backup.exportToMap();
    expect(dump['backupVersion'], 4);
    expect((dump['vessels'] as List).length, 1);
    expect((dump['aging'] as List).length, 1);
    expect((dump['tastings'] as List).length, 1);

    final result = await backup.importFromString(jsonEncode(dump));
    expect(result.counts['тары'], 1);
    expect(result.counts['дегустаций'], 1);

    final aging = await production.watchAging(batchId).first;
    expect(aging, isNotNull);
    expect(aging!.angelSharePctYear, 5);
    final tastings = await production.watchTastings(batchId).first;
    expect(tastings.single.photoPath, '/tmp/photo.jpg');
  });
}
