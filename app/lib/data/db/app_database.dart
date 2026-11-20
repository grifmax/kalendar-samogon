import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Локальная база приложения.
///
/// Оффлайн-первый: всё хранится на устройстве, аккаунта и сети нет.
/// Версия схемы растёт при изменении структуры, миграции — пошаговые.
@DriftDatabase(
  tables: [
    Recipes,
    RecipeIngredients,
    RecipeSteps,
    Batches,
    BatchEvents,
    Measurements,
    AppMeta,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'kalendar_samogon'));

  /// Конструктор для тестов: база в памяти.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Миграции добавляются здесь по мере роста схемы (M2 и далее).
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

/// Открыть базу в памяти — для тестов и проверок.
QueryExecutor openInMemory() => NativeDatabase.memory();
