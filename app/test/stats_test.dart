import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/data/db/app_database.dart';
import 'package:kalendar_samogon/data/repositories/stats_repository.dart';
import 'package:kalendar_samogon/domain/stats.dart';

/// Партия-заготовка: у drift-модели много полей, а тесту нужны не все.
Batch _batch({
  required String id,
  required String recipeId,
  required DateTime startedAt,
  String status = 'done',
  double volumeL = 20,
}) =>
    Batch(
      id: id,
      recipeId: recipeId,
      code: id,
      title: 'Партия $id',
      startedAt: startedAt,
      finishedAt: null,
      volumeL: volumeL,
      abv: 0,
      status: status,
      notes: '',
      createdAt: startedAt,
      updatedAt: startedAt,
    );

Run _run({
  required String id,
  required String batchId,
  double chargeVolumeL = 20,
  double chargeAbv = 10,
  DateTime? startedAt,
  DateTime? endedAt,
}) =>
    Run(
      id: id,
      batchId: batchId,
      kind: 'spirit',
      startedAt: startedAt ?? DateTime(2026, 1, 1, 10),
      endedAt: endedAt ?? DateTime(2026, 1, 1, 16),
      chargeVolumeL: chargeVolumeL,
      chargeAbv: chargeAbv,
      cubeTempStartC: null,
      cubeTempEndC: null,
      notes: '',
    );

RunFraction _fraction({
  required String runId,
  required String kind,
  required double volumeMl,
  required double abv,
}) =>
    RunFraction(
      id: runId.hashCode,
      runId: runId,
      jarNo: 1,
      kind: kind,
      volumeMl: volumeMl,
      abv: abv,
      tempC: null,
      note: '',
    );

Tasting _tasting({
  required String id,
  required String batchId,
  required int rating,
  required DateTime at,
}) =>
    Tasting(
      id: id,
      batchId: batchId,
      at: at,
      rating: rating,
      aroma: '',
      taste: '',
      finish: '',
      verdict: '',
      photoPath: '',
    );

void main() {
  final now = DateTime(2026, 11, 20);

  group('computeStats', () {
    test('считает объёмы, спирт и выход', () {
      final summary = computeStats(
        batches: [
          _batch(id: 'b1', recipeId: 'r1', startedAt: DateTime(2026, 1, 10)),
          _batch(id: 'b2', recipeId: 'r1', startedAt: DateTime(2026, 3, 10)),
        ],
        runs: [
          _run(id: 'run1', batchId: 'b1'),
          _run(id: 'run2', batchId: 'b2'),
        ],
        fractions: [
          // Залито 20 л × 10 % = 2 л АС в каждом кубе.
          _fraction(runId: 'run1', kind: 'heads', volumeMl: 300, abv: 80),
          _fraction(runId: 'run1', kind: 'hearts', volumeMl: 1500, abv: 90),
          _fraction(runId: 'run2', kind: 'hearts', volumeMl: 1400, abv: 88),
        ],
        tastings: const [],
        aging: const [],
        vessels: const [],
        recipeTitles: {'r1': 'Сахарная брага'},
        recipeKinds: {'r1': 'mash'},
        from: DateTime(2000),
        now: now,
      );

      expect(summary.batchesTotal, 2);
      expect(summary.batchesFinished, 2);
      expect(summary.washVolumeL, 40);
      // Тело: 1.5 + 1.4 = 2.9 л.
      expect(summary.distillateVolumeL, closeTo(2.9, 0.001));
      // АС: 1.5×0.9 + 1.4×0.88 = 1.35 + 1.232 = 2.582 л.
      expect(summary.absoluteAlcoholL, closeTo(2.582, 0.001));
      // Выход от залитого: 2.582 / 4 = 64.55 %.
      expect(summary.yieldPct, closeTo(64.55, 0.05));
      expect(summary.runs, 2);
      // Два прогона по 6 часов.
      expect(summary.stillHours, closeTo(12, 0.01));
    });

    test('головы и хвосты не идут в тело и в выход', () {
      final summary = computeStats(
        batches: [
          _batch(id: 'b1', recipeId: 'r1', startedAt: DateTime(2026, 5, 1)),
        ],
        runs: [_run(id: 'run1', batchId: 'b1')],
        fractions: [
          _fraction(runId: 'run1', kind: 'heads', volumeMl: 500, abv: 85),
          _fraction(runId: 'run1', kind: 'tails', volumeMl: 900, abv: 25),
        ],
        tastings: const [],
        aging: const [],
        vessels: const [],
        recipeTitles: {'r1': 'Чача'},
        recipeKinds: {'r1': 'mash'},
        from: DateTime(2000),
        now: now,
      );

      expect(summary.distillateVolumeL, 0);
      expect(summary.absoluteAlcoholL, 0);
      expect(summary.yieldPct, 0);
    });

    test('период отсекает старые партии', () {
      final summary = computeStats(
        batches: [
          _batch(id: 'old', recipeId: 'r1', startedAt: DateTime(2024, 5, 1)),
          _batch(id: 'fresh', recipeId: 'r2', startedAt: DateTime(2026, 10, 1)),
        ],
        runs: [
          _run(id: 'run1', batchId: 'old'),
          _run(id: 'run2', batchId: 'fresh'),
        ],
        fractions: [
          _fraction(runId: 'run1', kind: 'hearts', volumeMl: 2000, abv: 90),
          _fraction(runId: 'run2', kind: 'hearts', volumeMl: 1000, abv: 90),
        ],
        tastings: const [],
        aging: const [],
        vessels: const [],
        recipeTitles: {'r1': 'Старый', 'r2': 'Новый'},
        recipeKinds: {'r1': 'mash', 'r2': 'tincture'},
        from: StatsPeriod.year.from(now),
        now: now,
      );

      expect(summary.batchesTotal, 1);
      expect(summary.distillateVolumeL, closeTo(1, 0.001));
      expect(summary.topRecipes.single.title, 'Новый');
    });

    test('топ рецептов сортируется по числу партий', () {
      final summary = computeStats(
        batches: [
          _batch(id: 'b1', recipeId: 'r1', startedAt: DateTime(2026, 1, 1)),
          _batch(id: 'b2', recipeId: 'r1', startedAt: DateTime(2026, 2, 1)),
          _batch(id: 'b3', recipeId: 'r2', startedAt: DateTime(2026, 3, 1)),
        ],
        runs: const [],
        fractions: const [],
        tastings: const [],
        aging: const [],
        vessels: const [],
        recipeTitles: {'r1': 'Вишнёвка', 'r2': 'Чача'},
        recipeKinds: {'r1': 'tincture', 'r2': 'mash'},
        from: DateTime(2000),
        now: now,
      );

      expect(summary.topRecipes.first.title, 'Вишнёвка');
      expect(summary.topRecipes.first.batches, 2);
      expect(summary.byKind.length, 2);
    });

    test('дегустации: количество и средняя оценка', () {
      final summary = computeStats(
        batches: [
          _batch(id: 'b1', recipeId: 'r1', startedAt: DateTime(2026, 1, 1)),
        ],
        runs: const [],
        fractions: const [],
        tastings: [
          _tasting(id: 't1', batchId: 'b1', rating: 4, at: DateTime(2026, 2, 1)),
          _tasting(id: 't2', batchId: 'b1', rating: 5, at: DateTime(2026, 3, 1)),
          _tasting(id: 't3', batchId: 'b1', rating: 0, at: DateTime(2026, 4, 1)),
        ],
        aging: const [],
        vessels: const [],
        recipeTitles: {'r1': 'Вишнёвка'},
        recipeKinds: {'r1': 'tincture'},
        from: DateTime(2000),
        now: now,
      );

      expect(summary.tastings, 3);
      // Нулевые оценки (без оценки) в среднее не идут.
      expect(summary.averageRating, 4.5);
    });

    test('погреб считает объём тары и средний срок', () {
      final summary = computeStats(
        batches: [
          _batch(id: 'b1', recipeId: 'r1', startedAt: DateTime(2026, 1, 1)),
          _batch(id: 'b2', recipeId: 'r1', startedAt: DateTime(2026, 5, 1)),
        ],
        runs: const [],
        fractions: const [],
        tastings: const [],
        aging: [
          AgingEntry(
            id: 'a1',
            batchId: 'b1',
            vesselId: 'v1',
            startedAt: DateTime(2026, 9, 20),
            plannedEndAt: null,
            angelSharePctYear: 3,
            lastToppedAt: null,
            notes: '',
          ),
          AgingEntry(
            id: 'a2',
            batchId: 'b2',
            vesselId: 'v2',
            startedAt: DateTime(2026, 11, 10),
            plannedEndAt: null,
            angelSharePctYear: 3,
            lastToppedAt: null,
            notes: '',
          ),
        ],
        vessels: [
          Vessel(
            id: 'v1',
            name: 'Бочка 10',
            kind: 'barrel',
            volumeL: 10,
            material: 'дуб',
            charLevel: 2,
            location: '',
            isOccupied: true,
          ),
          Vessel(
            id: 'v2',
            name: 'Бутыль 20',
            kind: 'glass',
            volumeL: 20,
            material: 'стекло',
            charLevel: null,
            location: '',
            isOccupied: true,
          ),
        ],
        recipeTitles: {'r1': 'Чача'},
        recipeKinds: {'r1': 'mash'},
        from: DateTime(2000),
        now: now,
      );

      expect(summary.agedBatches, 2);
      expect(summary.agedVolumeL, 30);
      // 61 и 10 дней → среднее 35.5.
      expect(summary.averageAgingDays, closeTo(35.5, 0.01));
    });

    test('пустая база даёт пустую сводку без деления на ноль', () {
      final summary = computeStats(
        batches: const [],
        runs: const [],
        fractions: const [],
        tastings: const [],
        aging: const [],
        vessels: const [],
        recipeTitles: const {},
        recipeKinds: const {},
        from: DateTime(2000),
        now: now,
      );

      expect(summary.isEmpty, isTrue);
      expect(summary.yieldPct, 0);
      expect(summary.averageRating, 0);
      expect(summary.averageAgingDays, 0);
    });
  });

  group('StatsRepository', () {
    late AppDatabase db;
    late StatsRepository stats;

    setUp(() {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      stats = StatsRepository(db);
    });

    test('читает базу и сворачивает в сводку', () async {
      await db.into(db.recipes).insert(
            RecipesCompanion.insert(
              id: 'r1',
              title: 'Вишнёвка',
              kind: 'tincture',
            ),
          );
      await db.into(db.batches).insert(
            BatchesCompanion.insert(
              id: 'b1',
              recipeId: 'r1',
              title: 'Вишнёвка',
              startedAt: DateTime(2026, 6, 1),
              volumeL: const Value(3),
              status: const Value('done'),
            ),
          );
      await db.into(db.runs).insert(
            RunsCompanion.insert(
              id: 'run1',
              batchId: 'b1',
              kind: 'spirit',
              startedAt: DateTime(2026, 6, 10, 9),
              endedAt: Value(DateTime(2026, 6, 10, 13)),
              chargeVolumeL: const Value(3),
              chargeAbv: const Value(30),
            ),
          );
      await db.into(db.runFractions).insert(
            RunFractionsCompanion.insert(
              runId: 'run1',
              kind: 'hearts',
              volumeMl: 900,
              abv: 45,
            ),
          );

      final summary = await stats.load(now: now);

      expect(summary.batchesTotal, 1);
      expect(summary.distillateVolumeL, closeTo(0.9, 0.001));
      expect(summary.absoluteAlcoholL, closeTo(0.405, 0.001));
      expect(summary.topRecipes.single.title, 'Вишнёвка');
      expect(summary.stillHours, closeTo(4, 0.01));
    });
  });
}
