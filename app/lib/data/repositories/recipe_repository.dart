import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

/// Рецепты и их состав.
class RecipeRepository {
  RecipeRepository(this.db);

  final AppDatabase db;
  static const _uuid = Uuid();

  Stream<List<Recipe>> watchAll({String? kind}) {
    final q = db.select(db.recipes)
      ..orderBy([(t) => OrderingTerm(expression: t.title)]);
    if (kind != null) {
      q.where((t) => t.kind.equals(kind));
    }
    return q.watch();
  }

  Future<List<Recipe>> all() =>
      (db.select(db.recipes)..orderBy([(t) => OrderingTerm(expression: t.title)]))
          .get();

  Future<Recipe?> byId(String id) =>
      (db.select(db.recipes)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<Recipe?> watchById(String id) =>
      (db.select(db.recipes)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<List<RecipeIngredient>> ingredients(String recipeId) =>
      (db.select(db.recipeIngredients)
            ..where((t) => t.recipeId.equals(recipeId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();

  Future<List<RecipeStep>> steps(String recipeId) =>
      (db.select(db.recipeSteps)
            ..where((t) => t.recipeId.equals(recipeId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();

  /// Создать свой рецепт. Возвращает id.
  Future<String> createRecipe({
    required String title,
    required String kind,
    String summary = '',
    double baseVolumeL = 0,
    double expectedYieldL = 0,
    double expectedAbv = 0,
    List<({String name, double amount, String unit, String note})> ingredients =
        const [],
    List<
            ({
              String title,
              String description,
              int offsetDays,
              int? durationMin,
              double? tempC,
              String eventKind
            })>
        steps = const [],
  }) async {
    final id = _uuid.v4();
    await db.transaction(() async {
      await db.into(db.recipes).insert(
            RecipesCompanion.insert(
              id: id,
              title: title,
              kind: kind,
              summary: Value(summary),
              baseVolumeL: Value(baseVolumeL),
              expectedYieldL: Value(expectedYieldL),
              expectedAbv: Value(expectedAbv),
              isBuiltIn: const Value(false),
            ),
          );
      await _writeChildren(id, ingredients, steps);
    });
    return id;
  }

  /// Заменить состав и шаги своего рецепта.
  Future<void> updateRecipe({
    required String id,
    String? title,
    String? kind,
    String? summary,
    double? baseVolumeL,
    double? expectedYieldL,
    double? expectedAbv,
    List<({String name, double amount, String unit, String note})>? ingredients,
    List<
            ({
              String title,
              String description,
              int offsetDays,
              int? durationMin,
              double? tempC,
              String eventKind
            })>?
        steps,
  }) async {
    await db.transaction(() async {
      await (db.update(db.recipes)..where((t) => t.id.equals(id))).write(
        RecipesCompanion(
          title: title == null ? const Value.absent() : Value(title),
          kind: kind == null ? const Value.absent() : Value(kind),
          summary: summary == null ? const Value.absent() : Value(summary),
          baseVolumeL:
              baseVolumeL == null ? const Value.absent() : Value(baseVolumeL),
          expectedYieldL: expectedYieldL == null
              ? const Value.absent()
              : Value(expectedYieldL),
          expectedAbv:
              expectedAbv == null ? const Value.absent() : Value(expectedAbv),
          updatedAt: Value(DateTime.now()),
        ),
      );
      if (ingredients != null) {
        await (db.delete(db.recipeIngredients)
              ..where((t) => t.recipeId.equals(id)))
            .go();
      }
      if (steps != null) {
        await (db.delete(db.recipeSteps)..where((t) => t.recipeId.equals(id)))
            .go();
      }
      await _writeChildren(id, ingredients ?? const [], steps ?? const []);
    });
  }

  Future<void> _writeChildren(
    String recipeId,
    List<({String name, double amount, String unit, String note})> ingredients,
    List<
            ({
              String title,
              String description,
              int offsetDays,
              int? durationMin,
              double? tempC,
              String eventKind
            })>
        steps,
  ) async {
    for (var i = 0; i < ingredients.length; i++) {
      final ing = ingredients[i];
      await db.into(db.recipeIngredients).insert(
            RecipeIngredientsCompanion.insert(
              recipeId: recipeId,
              sortOrder: Value(i),
              name: ing.name,
              amount: ing.amount,
              unit: ing.unit,
              note: Value(ing.note),
            ),
          );
    }
    for (var i = 0; i < steps.length; i++) {
      final s = steps[i];
      await db.into(db.recipeSteps).insert(
            RecipeStepsCompanion.insert(
              recipeId: recipeId,
              sortOrder: Value(i),
              title: s.title,
              description: Value(s.description),
              offsetDays: Value(s.offsetDays),
              durationMin: Value(s.durationMin),
              tempC: Value(s.tempC),
              eventKind: Value(s.eventKind),
            ),
          );
    }
  }

  /// Удалить рецепт. Встроенные не удаляются — только свои.
  Future<bool> deleteOwnRecipe(String id) async {
    final recipe = await byId(id);
    if (recipe == null || recipe.isBuiltIn) return false;
    await (db.delete(db.recipes)..where((t) => t.id.equals(id))).go();
    return true;
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    await (db.update(db.recipes)..where((t) => t.id.equals(recipe.id))).write(
      RecipesCompanion(
        isFavorite: Value(!recipe.isFavorite),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Поиск по названию и тегам.
  Stream<List<Recipe>> search(String query, {String? kind}) {
    final q = db.select(db.recipes)
      ..orderBy([(t) => OrderingTerm(expression: t.title)]);
    if (query.trim().isNotEmpty) {
      final like = '%${query.trim().toLowerCase()}%';
      q.where((t) =>
          t.title.lower().like(like) | t.styleTags.lower().like(like));
    }
    if (kind != null) q.where((t) => t.kind.equals(kind));
    return q.watch();
  }
}
