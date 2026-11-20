import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/data/db/app_database.dart';
import 'package:kalendar_samogon/data/seed/recipe_seeder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  test('сид заливает каталог и не дублирует при повторном запуске', () async {
    final seeder = RecipeSeeder(db);
    final first = await seeder.seedIfNeeded();
    expect(first, greaterThan(100));

    final second = await seeder.seedIfNeeded();
    expect(second, 0);

    final recipes = await db.select(db.recipes).get();
    expect(recipes.length, first);
  });

  test('правка встроенного рецепта в ассетах доходит при смене версии', () async {
    final seeder = RecipeSeeder(db);
    await seeder.seedIfNeeded();

    // Имитируем «старую» установку: у встроенного рецепта другой объём и
    // устаревший состав, версия сида — предыдущая.
    final recipe = await (db.select(db.recipes)
          ..where((t) => t.id.equals('tinct-vishnevka')))
        .getSingle();
    await (db.update(db.recipes)..where((t) => t.id.equals(recipe.id))).write(
      const RecipesCompanion(baseVolumeL: Value(99)),
    );
    await db.into(db.recipeIngredients).insert(
          RecipeIngredientsCompanion.insert(
            recipeId: recipe.id,
            name: 'Устаревшая строка',
            amount: 1,
            unit: 'г',
          ),
        );
    await (db.update(db.appMeta)
          ..where((t) => t.key.equals('recipesSeedVersion')))
        .write(const AppMetaCompanion(value: Value('1')));

    await seeder.seedIfNeeded();

    final updated = await (db.select(db.recipes)
          ..where((t) => t.id.equals(recipe.id)))
        .getSingle();
    expect(updated.baseVolumeL, isNot(99));
    expect(updated.baseVolumeL, greaterThan(0));

    final ingredients = await (db.select(db.recipeIngredients)
          ..where((t) => t.recipeId.equals(recipe.id)))
        .get();
    expect(
      ingredients.map((i) => i.name),
      isNot(contains('Устаревшая строка')),
    );
    expect(ingredients, isNotEmpty);
  });

  test('свой рецепт не перезаписывается при обновлении каталога', () async {
    final seeder = RecipeSeeder(db);
    await seeder.seedIfNeeded();

    await db.into(db.recipes).insert(
          RecipesCompanion.insert(
            id: 'my-own',
            title: 'Моя вишнёвка',
            kind: 'tincture',
            isBuiltIn: const Value(false),
            baseVolumeL: const Value(2),
          ),
        );

    await (db.update(db.appMeta)
          ..where((t) => t.key.equals('recipesSeedVersion')))
        .write(const AppMetaCompanion(value: Value('1')));
    await seeder.seedIfNeeded();

    final mine = await (db.select(db.recipes)
          ..where((t) => t.id.equals('my-own')))
        .getSingleOrNull();
    expect(mine, isNotNull);
    expect(mine!.title, 'Моя вишнёвка');
    expect(mine.baseVolumeL, 2);
  });

  test('в ассетах нет рецептов с пустым составом', () async {
    final raw = await rootBundle.loadString('assets/recipes.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final recipes = (data['recipes'] as List).cast<Map<String, dynamic>>();

    expect(recipes.length, greaterThan(100));
    for (final recipe in recipes) {
      final id = recipe['id'];
      expect((recipe['ingredients'] as List), isNotEmpty, reason: '$id: состав');
      expect((recipe['steps'] as List), isNotEmpty, reason: '$id: шаги');
      expect((recipe['baseVolumeL'] as num), greaterThan(0), reason: '$id: объём');
    }
  });
}
