import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Локальная база приложения.
///
/// Оффлайн-первый: всё хранится на устройстве, аккаунта и сети нет.
/// Версия схемы растёт при изменении структуры, миграции — пошаговые.
///
/// v1 — рецепты, партии, события, замеры.
/// v2 — состав партии, перегонки с фракциями, тара, выдержка, дегустации.
@DriftDatabase(
  tables: [
    Recipes,
    RecipeIngredients,
    RecipeSteps,
    Batches,
    BatchEvents,
    Measurements,
    AppMeta,
    BatchIngredients,
    Runs,
    RunFractions,
    Vessels,
    Aging,
    Tastings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'kalendar_samogon'));

  /// Конструктор для тестов: база в памяти.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // M2: состав партии, перегонки, тара, выдержка, дегустации.
            await m.createTable(batchIngredients);
            await m.createTable(runs);
            await m.createTable(runFractions);
            await m.createTable(vessels);
            await m.createTable(aging);
            await m.createTable(tastings);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

/// Открыть базу в памяти — для тестов и проверок.
QueryExecutor openInMemory() => NativeDatabase.memory();
