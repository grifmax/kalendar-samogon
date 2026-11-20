import 'package:drift/drift.dart';

import '../db/app_database.dart';

/// Рецепты и их состав.
class RecipeRepository {
  RecipeRepository(this.db);

  final AppDatabase db;

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
