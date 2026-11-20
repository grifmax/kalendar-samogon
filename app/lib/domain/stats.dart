import '../data/db/app_database.dart';

/// Период, за который считается статистика.
enum StatsPeriod {
  all('Всё время'),
  year('Год'),
  quarter('90 дней');

  const StatsPeriod(this.label);

  final String label;

  /// Начало периода. Для [all] — заведомо прошлая дата.
  DateTime from(DateTime now) => switch (this) {
        StatsPeriod.all => DateTime(2000),
        StatsPeriod.year => DateTime(now.year - 1, now.month, now.day),
        StatsPeriod.quarter => now.subtract(const Duration(days: 90)),
      };
}

/// Итог по одному рецепту.
class RecipeStat {
  const RecipeStat({
    required this.title,
    required this.batches,
    required this.volumeL,
  });

  final String title;
  final int batches;
  final double volumeL;
}

/// Итог по типу напитка.
class KindStat {
  const KindStat({
    required this.kind,
    required this.batches,
    required this.volumeL,
  });

  final String kind;
  final int batches;
  final double volumeL;
}

/// Сводка для экрана статистики.
class StatsSummary {
  const StatsSummary({
    this.batchesTotal = 0,
    this.batchesActive = 0,
    this.batchesFinished = 0,
    this.washVolumeL = 0,
    this.distillateVolumeL = 0,
    this.absoluteAlcoholL = 0,
    this.yieldPct = 0,
    this.runs = 0,
    this.stillHours = 0,
    this.tastings = 0,
    this.averageRating = 0,
    this.agedBatches = 0,
    this.agedVolumeL = 0,
    this.averageAgingDays = 0,
    this.topRecipes = const [],
    this.byKind = const [],
  });

  /// Партий за период.
  final int batchesTotal;

  /// Из них незакрытых.
  final int batchesActive;

  /// Из них доведённых до конца.
  final int batchesFinished;

  /// Суммарный объём закладок, л.
  final double washVolumeL;

  /// Отобрано тела за все перегонки, л.
  final double distillateVolumeL;

  /// Чистый спирт в отобранном теле, л АС.
  final double absoluteAlcoholL;

  /// Выход тела от спирта в залитом, %.
  final double yieldPct;

  /// Прогонов куба.
  final int runs;

  /// Часов у куба (по закрытым прогонам).
  final double stillHours;

  /// Дегустаций за период.
  final int tastings;

  /// Средняя оценка, 0 — оценок не было.
  final double averageRating;

  /// Партий в выдержке.
  final int agedBatches;

  /// Объём тары под выдержкой, л.
  final double agedVolumeL;

  /// Средний срок выдержки, дней.
  final double averageAgingDays;

  /// Любимые рецепты по числу партий.
  final List<RecipeStat> topRecipes;

  /// Разбивка по типам напитков.
  final List<KindStat> byKind;

  bool get isEmpty => batchesTotal == 0 && tastings == 0;
}

/// Статусы, при которых партия считается незакрытой.
const _activeStatuses = {
  'planned',
  'fermenting',
  'distilling',
  'aging',
  'ready',
};

const _finishedStatuses = {'done', 'bottled'};

/// Посчитать сводку по уже загруженным строкам.
///
/// Чистая функция: ни базы, ни времени внутри — [now] передаётся снаружи,
/// поэтому результат проверяется в тестах без подмены часов.
StatsSummary computeStats({
  required List<Batch> batches,
  required List<Run> runs,
  required List<RunFraction> fractions,
  required List<Tasting> tastings,
  required List<AgingEntry> aging,
  required List<Vessel> vessels,
  required Map<String, String> recipeTitles,
  required Map<String, String> recipeKinds,
  required DateTime from,
  required DateTime now,
  int topCount = 5,
}) {
  final periodBatches = batches
      .where((b) => !b.startedAt.isBefore(from))
      .toList(growable: false);
  final batchIds = {for (final b in periodBatches) b.id};

  final periodRuns =
      runs.where((r) => batchIds.contains(r.batchId)).toList(growable: false);
  final runIds = {for (final r in periodRuns) r.id};

  final hearts = fractions
      .where((f) => runIds.contains(f.runId) && f.kind == 'hearts')
      .toList(growable: false);

  final distillateL =
      hearts.fold<double>(0, (sum, f) => sum + f.volumeMl / 1000);
  final absoluteAlcoholL =
      hearts.fold<double>(0, (sum, f) => sum + f.volumeMl / 1000 * f.abv / 100);

  final chargeAlcoholL = periodRuns.fold<double>(
    0,
    (sum, r) => sum + r.chargeVolumeL * r.chargeAbv / 100,
  );
  final yieldPct =
      chargeAlcoholL > 0 ? absoluteAlcoholL / chargeAlcoholL * 100 : 0.0;

  final stillHours = periodRuns
      .where((r) => r.endedAt != null)
      .fold<double>(
        0,
        (sum, r) => sum + r.endedAt!.difference(r.startedAt).inMinutes / 60,
      );

  final periodTastings =
      tastings.where((t) => !t.at.isBefore(from)).toList(growable: false);
  final rated = periodTastings.where((t) => t.rating > 0).toList();
  final averageRating = rated.isEmpty
      ? 0.0
      : rated.fold<int>(0, (sum, t) => sum + t.rating) / rated.length;

  final periodAging = aging
      .where((a) => batchIds.contains(a.batchId))
      .toList(growable: false);
  final vesselById = {for (final v in vessels) v.id: v};
  final agedVolumeL = periodAging.fold<double>(
    0,
    (sum, a) => sum + (vesselById[a.vesselId]?.volumeL ?? 0),
  );
  final averageAgingDays = periodAging.isEmpty
      ? 0.0
      : periodAging.fold<double>(
            0,
            (sum, a) => sum + now.difference(a.startedAt).inDays,
          ) /
          periodAging.length;

  // Любимые рецепты: сначала по числу партий, потом по объёму.
  final byRecipe = <String, ({int count, double volume})>{};
  for (final b in periodBatches) {
    final prev = byRecipe[b.recipeId] ?? (count: 0, volume: 0.0);
    byRecipe[b.recipeId] =
        (count: prev.count + 1, volume: prev.volume + b.volumeL);
  }
  final topRecipes = byRecipe.entries
      .map(
        (e) => RecipeStat(
          title: recipeTitles[e.key] ?? 'Рецепт',
          batches: e.value.count,
          volumeL: e.value.volume,
        ),
      )
      .toList()
    ..sort((a, b) {
      final byCount = b.batches.compareTo(a.batches);
      return byCount != 0 ? byCount : b.volumeL.compareTo(a.volumeL);
    });

  final byKindMap = <String, ({int count, double volume})>{};
  for (final b in periodBatches) {
    final kind = recipeKinds[b.recipeId] ?? 'other';
    final prev = byKindMap[kind] ?? (count: 0, volume: 0.0);
    byKindMap[kind] =
        (count: prev.count + 1, volume: prev.volume + b.volumeL);
  }
  final byKind = byKindMap.entries
      .map(
        (e) => KindStat(
          kind: e.key,
          batches: e.value.count,
          volumeL: e.value.volume,
        ),
      )
      .toList()
    ..sort((a, b) => b.volumeL.compareTo(a.volumeL));

  return StatsSummary(
    batchesTotal: periodBatches.length,
    batchesActive:
        periodBatches.where((b) => _activeStatuses.contains(b.status)).length,
    batchesFinished:
        periodBatches.where((b) => _finishedStatuses.contains(b.status)).length,
    washVolumeL:
        periodBatches.fold<double>(0, (sum, b) => sum + b.volumeL),
    distillateVolumeL: distillateL,
    absoluteAlcoholL: absoluteAlcoholL,
    yieldPct: yieldPct,
    runs: periodRuns.length,
    stillHours: stillHours,
    tastings: periodTastings.length,
    averageRating: averageRating,
    agedBatches: periodAging.length,
    agedVolumeL: agedVolumeL,
    averageAgingDays: averageAgingDays,
    topRecipes: topRecipes.take(topCount).toList(growable: false),
    byKind: byKind,
  );
}
