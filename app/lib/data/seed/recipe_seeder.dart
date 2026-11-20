import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

/// Загрузка встроенных рецептов из assets/recipes.json.
///
/// Сид выполняется один раз: признак хранится в app_meta. При обновлении
/// приложения встроенные рецепты не перезаписываются, чтобы не потерять
/// пользовательские правки (свои рецепты — отдельные записи с isBuiltIn=false).
class RecipeSeeder {
  RecipeSeeder(this.db);

  final AppDatabase db;
  static const _uuid = Uuid();

  static const _seededKey = 'recipesSeededAt';
  static const _versionKey = 'recipesSeedVersion';

  /// Актуальная версия набора рецептов — поднимать при изменении assets.
  ///
  /// 2 — каталог расширен до 105 рецептов;
  /// 3 — выверены цифры: объёмы, спирт, вода и сахар приведены к арифметике
  ///     приложения. Встроенные рецепты при смене версии перезаписываются,
  ///     свои рецепты и партии не затрагиваются.
  static const seedVersion = '3';

  Future<int> seedIfNeeded() async {
    final meta = await db.select(db.appMeta).get();
    final map = {for (final m in meta) m.key: m.value};
    if (map[_seededKey] != null && map[_versionKey] == seedVersion) {
      return 0;
    }

    final raw = await rootBundle.loadString('assets/recipes.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['recipes'] as List).cast<Map<String, dynamic>>();

    var inserted = 0;
    await db.transaction(() async {
      for (final r in list) {
        final id = r['id'] as String;
        final exists = await (db.select(db.recipes)
              ..where((t) => t.id.equals(id)))
            .getSingleOrNull();

        if (exists != null) {
          // Встроенный рецепт обновляем вместе с составом: правки цифр должны
          // доходить до тех, у кого приложение уже стоит. Свои рецепты
          // (isBuiltIn = false) не трогаем никогда.
          if (!exists.isBuiltIn) continue;
          await (db.delete(db.recipeIngredients)
                ..where((t) => t.recipeId.equals(id)))
              .go();
          await (db.delete(db.recipeSteps)..where((t) => t.recipeId.equals(id)))
              .go();
          await (db.update(db.recipes)..where((t) => t.id.equals(id))).write(
            RecipesCompanion(
              title: Value(r['title'] as String),
              kind: Value(r['kind'] as String),
              styleTags: Value(jsonEncode(r['styleTags'] ?? const [])),
              baseVolumeL: Value((r['baseVolumeL'] as num?)?.toDouble() ?? 0),
              expectedYieldL:
                  Value((r['expectedYieldL'] as num?)?.toDouble() ?? 0),
              expectedAbv: Value((r['expectedAbv'] as num?)?.toDouble() ?? 0),
              summary: Value(r['summary'] as String? ?? ''),
              source: Value(r['source'] as String? ?? ''),
              updatedAt: Value(DateTime.now()),
            ),
          );
          // Ниже состав и шаги вставляются заново — пропускаем insert рецепта.
          inserted += 0;
        } else {

        await db.into(db.recipes).insert(
              RecipesCompanion.insert(
                id: id,
                title: r['title'] as String,
                kind: r['kind'] as String,
                styleTags: Value(jsonEncode(r['styleTags'] ?? const [])),
                baseVolumeL: Value((r['baseVolumeL'] as num?)?.toDouble() ?? 0),
                expectedYieldL:
                    Value((r['expectedYieldL'] as num?)?.toDouble() ?? 0),
                expectedAbv: Value((r['expectedAbv'] as num?)?.toDouble() ?? 0),
                summary: Value(r['summary'] as String? ?? ''),
                source: Value(r['source'] as String? ?? ''),
                isBuiltIn: const Value(true),
              ),
            );
        }

        final ingredients =
            (r['ingredients'] as List? ?? const []).cast<Map<String, dynamic>>();
        for (var i = 0; i < ingredients.length; i++) {
          final ing = ingredients[i];
          await db.into(db.recipeIngredients).insert(
                RecipeIngredientsCompanion.insert(
                  recipeId: id,
                  sortOrder: Value(i),
                  name: ing['name'] as String,
                  amount: (ing['amount'] as num).toDouble(),
                  unit: ing['unit'] as String,
                  note: Value(ing['note'] as String? ?? ''),
                ),
              );
        }

        final steps = (r['steps'] as List? ?? const []).cast<Map<String, dynamic>>();
        for (var i = 0; i < steps.length; i++) {
          final s = steps[i];
          await db.into(db.recipeSteps).insert(
                RecipeStepsCompanion.insert(
                  recipeId: id,
                  sortOrder: Value(i),
                  title: s['title'] as String,
                  description: Value(s['description'] as String? ?? ''),
                  offsetDays: Value((s['offsetDays'] as num?)?.toInt() ?? 0),
                  durationMin: Value((s['durationMin'] as num?)?.toInt()),
                  tempC: Value((s['tempC'] as num?)?.toDouble()),
                  eventKind: Value(s['eventKind'] as String? ?? 'check'),
                  repeatEveryDays: Value((s['repeatEveryDays'] as num?)?.toInt()),
                  repeatUntilDay: Value((s['repeatUntilDay'] as num?)?.toInt()),
                ),
              );
        }
        inserted++;
      }

      await db.into(db.appMeta).insertOnConflictUpdate(
            AppMetaCompanion.insert(
              key: _seededKey,
              value: DateTime.now().toIso8601String(),
            ),
          );
      await db.into(db.appMeta).insertOnConflictUpdate(
            AppMetaCompanion.insert(key: _versionKey, value: seedVersion),
          );
    });
    return inserted;
  }

  /// Служебное: гарантировать уникальность id (для будущих импортов).
  static String newId() => _uuid.v4();
}
