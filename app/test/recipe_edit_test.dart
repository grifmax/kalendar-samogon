import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/app/app_scope.dart';
import 'package:kalendar_samogon/app/app_theme.dart';
import 'package:kalendar_samogon/data/db/app_database.dart';
import 'package:kalendar_samogon/data/repositories/batch_repository.dart';
import 'package:kalendar_samogon/data/repositories/production_repository.dart';
import 'package:kalendar_samogon/data/repositories/recipe_repository.dart';
import 'package:kalendar_samogon/features/recipes/recipe_edit_screen.dart';
import 'package:kalendar_samogon/services/backup_service.dart';
import 'package:kalendar_samogon/services/notification_service.dart';

/// Поле «Объём по рецепту» — это FormNumberField, внутри обычный TextField.
Finder volumeField() => find.descendant(
  of: find.ancestor(
    of: find.text('Объём по рецепту'),
    matching: find.byType(TextField),
  ),
  matching: find.byType(EditableText),
);

/// Тексты во всех полях ввода на экране.
List<String> fieldTexts(WidgetTester tester) => tester
    .widgetList<TextField>(find.byType(TextField))
    .map((f) => f.controller?.text ?? '')
    .toList();

void main() {
  late AppDatabase db;
  late RecipeRepository recipes;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    recipes = RecipeRepository(db);
  });

  /// Высокий экран: состав рецепта внизу, иначе ListView его не построит.
  void tallSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(420, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  Widget wrap(Widget child) => AppScope(
    db: db,
    recipes: recipes,
    batches: BatchRepository(db),
    production: ProductionRepository(db),
    notifications: NotificationService(),
    backup: BackupService(db),
    child: MaterialApp(theme: AppTheme.dark, home: child),
  );

  testWidgets('смена объёма рецепта пересчитывает состав', (tester) async {
    final id = await recipes.createRecipe(
      title: 'Вишнёвка',
      kind: 'tincture',
      baseVolumeL: 3,
      ingredients: const [
        (name: 'Вишня', amount: 800, unit: 'г', note: ''),
        (name: 'Спирт 45%', amount: 2, unit: 'л', note: ''),
        (name: 'Сахар', amount: 200, unit: 'г', note: ''),
      ],
    );

    tallSurface(tester);
    await tester.pumpWidget(wrap(RecipeEditScreen(recipeId: id)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.enterText(volumeField(), '5');
    await tester.pump();

    // 3 л → 5 л: количества растут в 5/3 раза.
    final texts = fieldTexts(tester);
    expect(texts, contains('1333,33')); // вишня 800 → 1333,33
    expect(texts, contains('3,33')); // спирт 2 → 3,33
    expect(texts, contains('333,33')); // сахар 200 → 333,33

    // Подсказка говорит, на какой объём посчитан состав.
    expect(find.textContaining('Состав пересчитан на 5 л'), findsOneWidget);
  });

  testWidgets('уменьшение объёма уменьшает состав', (tester) async {
    final id = await recipes.createRecipe(
      title: 'Наливка',
      kind: 'liqueur',
      baseVolumeL: 3,
      ingredients: const [
        (name: 'Сахар', amount: 300, unit: 'г', note: ''),
      ],
    );

    tallSurface(tester);
    await tester.pumpWidget(wrap(RecipeEditScreen(recipeId: id)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.enterText(volumeField(), '1.5');
    await tester.pump();

    expect(fieldTexts(tester), contains('150'));
  });

  testWidgets('пустой объём не ломает состав', (tester) async {
    final id = await recipes.createRecipe(
      title: 'Настойка',
      kind: 'tincture',
      baseVolumeL: 3,
      ingredients: const [
        (name: 'Сахар', amount: 300, unit: 'г', note: ''),
      ],
    );

    tallSurface(tester);
    await tester.pumpWidget(wrap(RecipeEditScreen(recipeId: id)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.enterText(volumeField(), '');
    await tester.pump();

    // Значение осталось прежним: делить на ноль нельзя.
    expect(fieldTexts(tester), contains('300'));
  });
}
