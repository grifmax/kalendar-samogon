import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/batch_repository.dart';
import '../../utils/format.dart';
import '../../widgets/event_tile.dart';
import '../../widgets/form_fields.dart';
import '../aging/aging_tab.dart';
import '../maceration/maceration_tab.dart';
import '../runs/runs_tab.dart';
import '../tastings/tastings_tab.dart';

/// Карточка партии: таймлайн событий, замеры с графиком, статус.
class BatchDetailScreen extends StatelessWidget {
  const BatchDetailScreen({super.key, required this.batchId});

  final String batchId;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return StreamBuilder<Batch?>(
      stream: scope.batches.watchBatch(batchId),
      builder: (context, snapshot) {
        final batch = snapshot.data;
        if (batch == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        // Вкладка «Настаивание» нужна только настойкам и ликёрам: у браги
        // и перегонок мацерации нет, лишняя вкладка там только мешает.
        return StreamBuilder<Recipe?>(
          stream: scope.recipes.watchById(batch.recipeId),
          builder: (context, recipeSnapshot) {
            final kind = recipeSnapshot.data?.kind ?? '';
            final showMaceration = kind == 'tincture' || kind == 'liqueur';

            return DefaultTabController(
              length: showMaceration ? 6 : 5,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    batch.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  actions: [
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        switch (value) {
                          case 'fermenting':
                          case 'distilling':
                          case 'aging':
                          case 'ready':
                          case 'bottled':
                          case 'done':
                            await scope.batches.setStatus(batch.id, value);
                          case 'delete':
                            final ok = await _confirmDelete(context);
                            if (ok) {
                              await scope.batches.deleteBatch(batch.id);
                              if (context.mounted) Navigator.of(context).pop();
                            }
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'fermenting',
                          child: Text('Бродит'),
                        ),
                        PopupMenuItem(
                          value: 'distilling',
                          child: Text('Перегонка'),
                        ),
                        PopupMenuItem(
                          value: 'aging',
                          child: Text('Настаивается'),
                        ),
                        PopupMenuItem(value: 'ready', child: Text('Готова')),
                        PopupMenuItem(
                          value: 'bottled',
                          child: Text('В бутылках'),
                        ),
                        PopupMenuItem(value: 'done', child: Text('Завершить')),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Удалить партию'),
                        ),
                      ],
                    ),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: [
                      const Tab(text: 'Таймлайн'),
                      const Tab(text: 'Замеры'),
                      const Tab(text: 'Перегонки'),
                      const Tab(text: 'Выдержка'),
                      if (showMaceration) const Tab(text: 'Настаивание'),
                      const Tab(text: 'Дегустации'),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    _BatchHeader(batch: batch),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _TimelineTab(batch: batch),
                          _MeasurementsTab(batch: batch),
                          RunsTab(batchId: batch.id),
                          AgingTab(batchId: batch.id),
                          if (showMaceration) MacerationTab(batchId: batch.id),
                          TastingsTab(batchId: batch.id),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить партию?'),
        content: const Text(
          'Вместе с партией удалятся все её события и замеры. '
          'Отменить это будет нельзя.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _BatchHeader extends StatelessWidget {
  const _BatchHeader({required this.batch});

  final Batch batch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = daysSince(batch.startedAt);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _Chip(icon: Icons.event, label: formatFullDate(batch.startedAt)),
          _Chip(
            icon: Icons.timelapse,
            label: '$days ${plural(days, 'день', 'дня', 'дней')}',
          ),
          _Chip(
            icon: Icons.water_drop_outlined,
            label: formatVolume(batch.volumeL),
          ),
          _Chip(
            icon: Icons.circle,
            label: kBatchStatusLabels[batch.status] ?? batch.status,
            color: theme.colorScheme.primary,
          ),
          if (batch.code.isNotEmpty) _Chip(icon: Icons.tag, label: batch.code),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color ?? theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(label, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

class _TimelineTab extends StatelessWidget {
  const _TimelineTab({required this.batch});

  final Batch batch;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return StreamBuilder<List<BatchEvent>>(
      stream: scope.batches.watchEventsForBatch(batch.id),
      builder: (context, snapshot) {
        final events = snapshot.data ?? const <BatchEvent>[];
        if (events.isEmpty) {
          return const Center(child: Text('Событий нет'));
        }
        final now = DateTime.now();
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
          itemCount: events.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return _BatchIngredientsCard(batchId: batch.id);
            final i = index - 1;
            final event = events[i];
            final isNext =
                event.status == 'planned' &&
                events.take(i).where((e) => e.status == 'planned').isEmpty &&
                event.plannedAt.isAfter(now.subtract(const Duration(days: 1)));
            return EventTile(
              event: event,
              batchTitle: isNext ? 'следующий шаг' : null,
              onDone: () => scope.batches.markEvent(event, 'done'),
              onSkip: () => scope.batches.markEvent(event, 'skipped'),
              onSnooze: () => scope.batches.snooze(event, 1),
              onTap: () => _showEvent(context, event),
            );
          },
        );
      },
    );
  }

  void _showEvent(BuildContext context, BatchEvent event) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                '${formatFullDate(event.plannedAt)} · ${formatTime(event.plannedAt)}',
                style: theme.textTheme.bodySmall,
              ),
              if (event.description.isNotEmpty) ...[
                const SizedBox(height: FormSpacing.field),
                Text(event.description, style: theme.textTheme.bodyMedium),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _MeasurementsTab extends StatelessWidget {
  const _MeasurementsTab({required this.batch});

  final Batch batch;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);

    return StreamBuilder<List<Measurement>>(
      stream: scope.batches.watchMeasurements(batch.id),
      builder: (context, snapshot) {
        final measurements = snapshot.data ?? const <Measurement>[];
        final density = measurements
            .where((m) => m.kind == 'sg')
            .toList(growable: false);
        final prediction = BatchRepository.predictFinish(measurements);

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (density.length >= 2) ...[
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 16, 8),
                  child: SizedBox(
                    height: 180,
                    child: _DensityChart(measurements: density),
                  ),
                ),
              ),
              const SizedBox(height: FormSpacing.field),
            ],
            if (prediction != null)
              Card(
                margin: EdgeInsets.zero,
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                child: ListTile(
                  leading: Icon(
                    Icons.auto_graph,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Прогноз готовности'),
                  subtitle: Text(
                    'При текущей скорости плотность дойдёт до 1.000 '
                    'около ${formatDayMonth(prediction)}',
                  ),
                ),
              ),
            if (measurements.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Замеров пока нет. Плотность и температура показывают, '
                  'идёт ли брожение и когда снимать с осадка.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            for (final m in measurements.reversed)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(_kindIcon(m.kind)),
                title: Text('${_kindLabel(m.kind)}: ${_formatValue(m)}'),
                subtitle: Text(
                  '${formatNumeric(m.at)} ${formatTime(m.at)}'
                  '${m.note.isNotEmpty ? ' · ${m.note}' : ''}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => scope.batches.deleteMeasurement(m.id),
                ),
              ),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: () => _addMeasurement(context, batch),
              icon: const Icon(Icons.add),
              label: const Text('Добавить замер'),
            ),
          ],
        );
      },
    );
  }

  static IconData _kindIcon(String kind) => switch (kind) {
    'sg' => Icons.straighten,
    'abv' => Icons.percent,
    'temp' => Icons.thermostat,
    'brix' => Icons.science,
    _ => Icons.numbers,
  };

  static String _kindLabel(String kind) => switch (kind) {
    'sg' => 'Плотность',
    'abv' => 'Крепость',
    'temp' => 'Температура',
    'brix' => 'Brix',
    _ => kind,
  };

  static String _formatValue(Measurement m) => switch (m.kind) {
    'sg' => m.value.toStringAsFixed(3),
    'abv' => '${formatNumber(m.value, decimals: 1)}%',
    'temp' => '${formatNumber(m.value, decimals: 1)} °C',
    _ => formatNumber(m.value),
  };

  Future<void> _addMeasurement(BuildContext context, Batch batch) async {
    final scope = AppScope.of(context);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AddMeasurementSheet(
        onAdd: (kind, value, note) => scope.batches.addMeasurement(
          batchId: batch.id,
          kind: kind,
          value: value,
          note: note,
        ),
      ),
    );
  }
}

class _DensityChart extends StatelessWidget {
  const _DensityChart({required this.measurements});

  final List<Measurement> measurements;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final first = measurements.first.at;
    final spots = [
      for (final m in measurements)
        FlSpot(m.at.difference(first).inHours / 24.0, m.value),
    ];
    final maxY = measurements
        .map((m) => m.value)
        .reduce((a, b) => a > b ? a : b);
    final minY = measurements
        .map((m) => m.value)
        .reduce((a, b) => a < b ? a : b);

    return LineChart(
      LineChartData(
        minY: (minY - 0.01).clamp(0.9, 2),
        maxY: maxY + 0.01,
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(2),
                style: theme.textTheme.labelSmall,
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) => Text(
                '${value.round()} дн',
                style: theme.textTheme.labelSmall,
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false,
            color: theme.colorScheme.primary,
            barWidth: 2.5,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddMeasurementSheet extends StatefulWidget {
  const _AddMeasurementSheet({required this.onAdd});

  final Future<void> Function(String kind, double value, String note) onAdd;

  @override
  State<_AddMeasurementSheet> createState() => _AddMeasurementSheetState();
}

class _AddMeasurementSheetState extends State<_AddMeasurementSheet> {
  String _kind = 'sg';
  final _valueController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = double.tryParse(_valueController.text.replaceAll(',', '.'));

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Новый замер', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              for (final entry in const {
                'sg': 'Плотность',
                'abv': 'Крепость',
                'temp': 'Температура',
                'brix': 'Brix',
              }.entries)
                ChoiceChip(
                  label: Text(entry.value),
                  selected: _kind == entry.key,
                  onSelected: (_) => setState(() => _kind = entry.key),
                ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: switch (_kind) {
                'sg' => 'Плотность, например 1.040',
                'abv' => 'Крепость, %',
                'temp' => 'Температура, °C',
                _ => 'Значение',
              },
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: FormSpacing.field),
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              labelText: 'Заметка (необязательно)',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: value == null
                  ? null
                  : () async {
                      await widget.onAdd(
                        _kind,
                        value,
                        _noteController.text.trim(),
                      );
                      if (context.mounted) Navigator.of(context).pop();
                    },
              child: const Text('Сохранить'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Состав, сохранённый в партии: то, что реально заложено с учётом правок.
class _BatchIngredientsCard extends StatelessWidget {
  const _BatchIngredientsCard({required this.batchId});

  final String batchId;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);

    return StreamBuilder<List<BatchIngredient>>(
      stream: scope.batches.watchIngredients(batchId),
      builder: (context, snapshot) {
        final items = snapshot.data ?? const <BatchIngredient>[];
        if (items.isEmpty) return const SizedBox.shrink();
        return Card(
          margin: const EdgeInsets.fromLTRB(8, 0, 8, 12),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Заложено', style: theme.textTheme.titleSmall),
                const SizedBox(height: 6),
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(item.name)),
                        Text(
                          '${formatNumber(item.amount, decimals: 3)} ${item.unit}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
