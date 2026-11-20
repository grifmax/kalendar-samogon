import 'package:drift/drift.dart';

import '../../domain/stats.dart';
import '../db/app_database.dart';

/// Считает статистику по локальной базе.
///
/// Отдельный репозиторий, а не метод в [BatchRepository]: экран статистики
/// читает почти все таблицы сразу, и держать это рядом с операциями над
/// партиями незачем.
class StatsRepository {
  StatsRepository(this.db);

  final AppDatabase db;

  /// Загрузить строки за период и свернуть их в [StatsSummary].
  Future<StatsSummary> load({
    StatsPeriod period = StatsPeriod.all,
    DateTime? now,
  }) async {
    final current = now ?? DateTime.now();
    final from = period.from(current);

    final batches = await (db.select(db.batches)
          ..where((t) => t.startedAt.isBiggerOrEqualValue(from)))
        .get();
    final batchIds = {for (final b in batches) b.id};

    final runs = await db.select(db.runs).get();
    final fractions = await db.select(db.runFractions).get();
    final tastings = await (db.select(db.tastings)
          ..where((t) => t.at.isBiggerOrEqualValue(from)))
        .get();
    final aging = await db.select(db.aging).get();
    final vessels = await db.select(db.vessels).get();
    final recipes = await db.select(db.recipes).get();

    return computeStats(
      batches: batches,
      runs: runs,
      fractions: fractions,
      tastings: tastings,
      aging: aging.where((a) => batchIds.contains(a.batchId)).toList(),
      vessels: vessels,
      recipeTitles: {for (final r in recipes) r.id: r.title},
      recipeKinds: {for (final r in recipes) r.id: r.kind},
      from: from,
      now: current,
    );
  }
}
