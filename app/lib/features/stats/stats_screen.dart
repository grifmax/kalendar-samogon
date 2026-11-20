import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/repositories/stats_repository.dart';
import '../../domain/stats.dart';
import '../../utils/format.dart';
import '../../widgets/form_fields.dart';

/// Экран «Статистика»: сколько сделано за период.
class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  StatsPeriod _period = StatsPeriod.all;
  late Future<StatsSummary> _future;
  StatsRepository? _repo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo ??= StatsRepository(AppScope.of(context).db);
    _future = _repo!.load(period: _period);
  }

  void _reload(StatsPeriod period) {
    setState(() {
      _period = period;
      _future = _repo!.load(period: period);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: FutureBuilder<StatsSummary>(
        future: _future,
        builder: (context, snapshot) {
          final data = snapshot.data;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final period in StatsPeriod.values)
                    ChoiceChip(
                      label: Text(period.label),
                      selected: _period == period,
                      onSelected: (_) => _reload(period),
                    ),
                ],
              ),
              const SizedBox(height: FormSpacing.chipsToField),
              if (snapshot.connectionState == ConnectionState.waiting)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (data == null || data.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.insights_outlined,
                        size: 40,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: FormSpacing.titleToField),
                      Text(
                        'Пока считать нечего. Заведите партию — здесь появятся '
                        'объёмы, выход спирта и любимые рецепты.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              else ...[
                _Tiles(summary: data),
                const SizedBox(height: FormSpacing.section),
                if (data.byKind.isNotEmpty) ...[
                  const FormSectionTitle(title: 'По типам напитков'),
                  _KindBars(summary: data),
                  const SizedBox(height: FormSpacing.section),
                ],
                if (data.topRecipes.isNotEmpty) ...[
                  const FormSectionTitle(
                    title: 'Чаще всего',
                    hint: 'По числу партий',
                  ),
                  _TopRecipes(summary: data),
                  const SizedBox(height: FormSpacing.section),
                ],
                _Cellar(summary: data),
                const SizedBox(height: FormSpacing.section),
                _TastingCard(summary: data),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// Плитки с ключевыми числами.
class _Tiles extends StatelessWidget {
  const _Tiles({required this.summary});

  final StatsSummary summary;

  @override
  Widget build(BuildContext context) {
    final tiles = <({IconData icon, String label, String value})>[
      (
        icon: Icons.science_outlined,
        label: 'Партий',
        value: '${summary.batchesTotal}',
      ),
      (
        icon: Icons.water_drop_outlined,
        label: 'Заложено',
        value: formatVolume(summary.washVolumeL),
      ),
      (
        icon: Icons.local_fire_department_outlined,
        label: 'Прогонов',
        value: '${summary.runs}',
      ),
      (
        icon: Icons.opacity,
        label: 'Отобрано тела',
        value: formatVolume(summary.distillateVolumeL),
      ),
      (
        icon: Icons.bolt_outlined,
        label: 'Чистого спирта',
        value: summary.absoluteAlcoholL > 0
            ? '${formatNumber(summary.absoluteAlcoholL, decimals: 2)} л АС'
            : '—',
      ),
      (
        icon: Icons.percent,
        label: 'Выход тела',
        value: summary.yieldPct > 0
            ? '${formatNumber(summary.yieldPct, decimals: 0)} %'
            : '—',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final tile in tiles)
              SizedBox(
                width: width,
                child: _Tile(icon: tile.icon, label: tile.label, value: tile.value),
              ),
          ],
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Полоски по типам напитков.
class _KindBars extends StatelessWidget {
  const _KindBars({required this.summary});

  final StatsSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxVolume = summary.byKind
        .map((k) => k.volumeL)
        .fold<double>(0, (a, b) => a > b ? a : b);

    return Column(
      children: [
        for (final kind in summary.byKind)
          Padding(
            padding: const EdgeInsets.only(bottom: FormSpacing.field),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        kRecipeKindLabels[kind.kind] ?? kind.kind,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '${formatVolume(kind.volumeL)} · ${kind.batches} '
                      '${plural(kind.batches, 'партия', 'партии', 'партий')}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: maxVolume > 0 ? kind.volumeL / maxVolume : 0,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Топ рецептов.
class _TopRecipes extends StatelessWidget {
  const _TopRecipes({required this.summary});

  final StatsSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < summary.topRecipes.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            ListTile(
              dense: true,
              leading: Text(
                '${i + 1}',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              title: Text(summary.topRecipes[i].title),
              trailing: Text(
                '${summary.topRecipes[i].batches} × '
                '${formatVolume(summary.topRecipes[i].volumeL)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Погреб: что стоит на выдержке.
class _Cellar extends StatelessWidget {
  const _Cellar({required this.summary});

  final StatsSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warehouse_outlined,
                    size: 16, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Text('Погреб', style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: FormSpacing.titleToField),
            if (summary.agedBatches == 0)
              Text(
                'Ничего не стоит на выдержке.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else ...[
              _row(
                theme,
                'Партий в выдержке',
                '${summary.agedBatches}',
              ),
              _row(
                theme,
                'Объём тары',
                formatVolume(summary.agedVolumeL),
              ),
              _row(
                theme,
                'Средний срок',
                '${summary.averageAgingDays.round()} '
                    '${plural(summary.averageAgingDays.round(), 'день', 'дня', 'дней')}',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(ThemeData theme, String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );
}

/// Дегустации и оценка.
class _TastingCard extends StatelessWidget {
  const _TastingCard({required this.summary});

  final StatsSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.wine_bar_outlined,
                size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                summary.tastings == 0
                    ? 'Дегустаций пока не было'
                    : 'Дегустаций: ${summary.tastings}',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            if (summary.averageRating > 0)
              Text(
                '${formatNumber(summary.averageRating, decimals: 1)} ★',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
