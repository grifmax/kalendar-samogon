import 'package:drift/drift.dart' hide Batch;
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

/// Партии, события календаря и замеры.
class BatchRepository {
  BatchRepository(this.db);

  final AppDatabase db;
  static const _uuid = Uuid();

  // ---------- партии ----------

  Stream<List<Batch>> watchAll() => (db.select(db.batches)
        ..orderBy([(t) => OrderingTerm(expression: t.startedAt, mode: OrderingMode.desc)]))
      .watch();

  Stream<List<Batch>> watchActive() => (db.select(db.batches)
        ..where((t) => t.status.isIn(const [
              'fermenting',
              'distilling',
              'aging',
              'ready',
            ]))
        ..orderBy([(t) => OrderingTerm(expression: t.startedAt, mode: OrderingMode.desc)]))
      .watch();

  Stream<Batch?> watchBatch(String id) =>
      (db.select(db.batches)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<Batch?> batchById(String id) =>
      (db.select(db.batches)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Создать партию из рецепта и разложить шаги в события календаря.
  ///
  /// Возвращает id созданной партии. События генерируются по `offsetDays`
  /// каждого шага; шаги с `repeatEveryDays` разворачиваются в серию.
  Future<String> createFromRecipe({
    required Recipe recipe,
    required List<RecipeStep> steps,
    required DateTime startedAt,
    required double volumeL,
    String notes = '',
  }) async {
    final id = _uuid.v4();
    final count = await _nextCodeIndex();

    await db.transaction(() async {
      await db.into(db.batches).insert(
            BatchesCompanion.insert(
              id: id,
              recipeId: recipe.id,
              code: Value('Б-${count.toString().padLeft(2, '0')}'),
              title: recipe.title,
              startedAt: startedAt,
              volumeL: Value(volumeL),
              status: Value(_initialStatus(recipe.kind)),
              notes: Value(notes),
            ),
          );

      for (final step in steps) {
        for (final at in _eventDates(step, startedAt)) {
          await db.into(db.batchEvents).insert(
                BatchEventsCompanion.insert(
                  id: _uuid.v4(),
                  batchId: id,
                  kind: step.eventKind,
                  title: step.title,
                  description: Value(step.description),
                  plannedAt: at,
                ),
              );
        }
      }
    });
    return id;
  }

  /// Даты события для шага: одиночная или серия повторов.
  static List<DateTime> _eventDates(RecipeStep step, DateTime startedAt) {
    DateTime atDay(int days) {
      final base = DateTime(startedAt.year, startedAt.month, startedAt.day)
          .add(Duration(days: days));
      // Напоминания по умолчанию на 10:00 — не будить в 4 утра.
      return DateTime(base.year, base.month, base.day, 10);
    }

    final repeat = step.repeatEveryDays;
    final until = step.repeatUntilDay;
    if (repeat == null || repeat <= 0 || until == null || until < step.offsetDays) {
      return [atDay(step.offsetDays)];
    }
    final dates = <DateTime>[];
    var day = step.offsetDays;
    while (day <= until) {
      dates.add(atDay(day));
      day += repeat;
    }
    return dates;
  }

  Future<int> _nextCodeIndex() async {
    final row = await db.customSelect('SELECT COUNT(*) AS c FROM batches').getSingle();
    return (row.data['c'] as int) + 1;
  }

  static String _initialStatus(String kind) => switch (kind) {
        'mash' => 'fermenting',
        'distillate' || 'rectification' => 'distilling',
        'tincture' || 'liqueur' || 'aging' || 'gin' => 'aging',
        _ => 'fermenting',
      };

  Future<void> setStatus(String batchId, String status) async {
    await (db.update(db.batches)..where((t) => t.id.equals(batchId))).write(
      BatchesCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
        finishedAt: status == 'done' ? Value(DateTime.now()) : const Value.absent(),
      ),
    );
  }

  Future<void> updateNotes(String batchId, String notes) async {
    await (db.update(db.batches)..where((t) => t.id.equals(batchId))).write(
      BatchesCompanion(notes: Value(notes), updatedAt: Value(DateTime.now())),
    );
  }

  Future<void> deleteBatch(String id) async {
    await (db.delete(db.batches)..where((t) => t.id.equals(id))).go();
  }

  // ---------- события ----------

  Stream<List<BatchEvent>> watchEventsForDay(DateTime day) {
    final from = DateTime(day.year, day.month, day.day);
    final to = from.add(const Duration(days: 1));
    return (db.select(db.batchEvents)
          ..where((t) => t.plannedAt.isBiggerOrEqualValue(from) & t.plannedAt.isSmallerThanValue(to))
          ..orderBy([(t) => OrderingTerm(expression: t.plannedAt)]))
        .watch();
  }

  Stream<List<BatchEvent>> watchEventsInRange(DateTime from, DateTime to) =>
      (db.select(db.batchEvents)
            ..where((t) => t.plannedAt.isBiggerOrEqualValue(from) & t.plannedAt.isSmallerThanValue(to))
            ..orderBy([(t) => OrderingTerm(expression: t.plannedAt)]))
          .watch();

  /// Просроченные: плановые события до сегодняшнего дня.
  Stream<List<BatchEvent>> watchOverdue() {
    final today = DateTime.now();
    final from = DateTime(today.year, today.month, today.day);
    return (db.select(db.batchEvents)
          ..where((t) => t.status.equals('planned') & t.plannedAt.isSmallerThanValue(from))
          ..orderBy([(t) => OrderingTerm(expression: t.plannedAt)]))
        .watch();
  }

  Stream<List<BatchEvent>> watchEventsForBatch(String batchId) =>
      (db.select(db.batchEvents)
            ..where((t) => t.batchId.equals(batchId))
            ..orderBy([(t) => OrderingTerm(expression: t.plannedAt)]))
          .watch();

  Future<List<BatchEvent>> eventsForBatch(String batchId) =>
      (db.select(db.batchEvents)
            ..where((t) => t.batchId.equals(batchId))
            ..orderBy([(t) => OrderingTerm(expression: t.plannedAt)]))
          .get();

  Future<void> markEvent(BatchEvent event, String status) async {
    await (db.update(db.batchEvents)..where((t) => t.id.equals(event.id))).write(
      BatchEventsCompanion(
        status: Value(status),
        actualAt: Value(status == 'done' ? DateTime.now() : null),
      ),
    );
  }

  /// Перенести событие на [days] дней вперёд.
  Future<void> snooze(BatchEvent event, int days) async {
    await (db.update(db.batchEvents)..where((t) => t.id.equals(event.id))).write(
      BatchEventsCompanion(
        plannedAt: Value(event.plannedAt.add(Duration(days: days))),
        status: const Value('planned'),
      ),
    );
  }

  // ---------- замеры ----------

  Stream<List<Measurement>> watchMeasurements(String batchId) =>
      (db.select(db.measurements)
            ..where((t) => t.batchId.equals(batchId))
            ..orderBy([(t) => OrderingTerm(expression: t.at)]))
          .watch();

  Future<void> addMeasurement({
    required String batchId,
    required String kind,
    required double value,
    String note = '',
    DateTime? at,
  }) async {
    await db.into(db.measurements).insert(
          MeasurementsCompanion.insert(
            id: _uuid.v4(),
            batchId: batchId,
            at: at ?? DateTime.now(),
            kind: kind,
            value: value,
            note: Value(note),
          ),
        );
  }

  Future<void> deleteMeasurement(String id) async {
    await (db.delete(db.measurements)..where((t) => t.id.equals(id))).go();
  }

  /// Прогноз готовности браги: линейная экстраполяция последних замеров
  /// плотности до 1.000. null — данных мало или брожение встало.
  static DateTime? predictFinish(List<Measurement> measurements) {
    final points = measurements.where((m) => m.kind == 'sg').toList()
      ..sort((a, b) => a.at.compareTo(b.at));
    if (points.length < 2) return null;
    final last = points.last;
    final prev = points[points.length - 2];
    final days = last.at.difference(prev.at).inHours / 24.0;
    if (days <= 0) return null;
    final rate = (last.value - prev.value) / days; // падение в день
    if (rate >= -0.0005) return null; // не падает — прогноза нет
    final remaining = last.value - 1.000;
    final daysLeft = remaining / -rate;
    if (daysLeft > 60) return null;
    return last.at.add(Duration(hours: (daysLeft * 24).round()));
  }
}
