import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/production_repository.dart';
import '../../domain/calculators.dart';
import '../../utils/format.dart';

/// Вкладка «Перегонки»: прогоны куба и фракции по банкам.
class RunsTab extends StatelessWidget {
  const RunsTab({super.key, required this.batchId});

  final String batchId;

  static const _kinds = {
    'strip': 'Первый перегон (сырец)',
    'spirit': 'Второй, дробный',
    'rectification': 'Ректификация',
    'gin': 'Джин',
    'steam': 'С паром',
  };

  static const _fractionKinds = {
    'foreshots': 'Первач',
    'heads': 'Головы',
    'hearts': 'Тело',
    'tails': 'Хвосты',
    'feints': 'Обрезки',
  };

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return StreamBuilder<List<Run>>(
      stream: scope.production.watchRuns(batchId),
      builder: (context, snapshot) {
        final runs = snapshot.data ?? const <Run>[];
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (runs.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Перегонок пока нет. Заведите прогон и вносите банки: '
                  'приложение посчитает головы, тело и хвосты.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            for (final run in runs) _RunCard(run: run),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: () => _addRun(context, batchId),
              icon: const Icon(Icons.add),
              label: const Text('Добавить прогон'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _addRun(BuildContext context, String batchId) async {
    final scope = AppScope.of(context);
    var kind = 'strip';
    final volume = TextEditingController();
    final abv = TextEditingController();
    final notes = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('Новый прогон'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: kind,
                  decoration: const InputDecoration(
                    labelText: 'Тип',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    for (final entry in _kinds.entries)
                      DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                  ],
                  onChanged: (value) => setLocal(() => kind = value ?? 'strip'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: volume,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Залито в куб',
                    suffixText: 'л',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: abv,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Крепость залитого',
                    suffixText: '%',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notes,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Заметка',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () async {
                await scope.production.createRun(
                  batchId: batchId,
                  kind: kind,
                  chargeVolumeL: double.tryParse(
                        volume.text.replaceAll(',', '.'),
                      ) ??
                      0,
                  chargeAbv:
                      double.tryParse(abv.text.replaceAll(',', '.')) ?? 0,
                  notes: notes.text.trim(),
                );
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RunCard extends StatelessWidget {
  const _RunCard({required this.run});

  final Run run;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scope = AppScope.of(context);

    return StreamBuilder<List<RunFraction>>(
      stream: scope.production.watchFractions(run.id),
      builder: (context, snapshot) {
        final fractions = snapshot.data ?? const <RunFraction>[];
        final summary = ProductionRepository.summarize(fractions);
        final totalVolume = summary.values
            .fold<double>(0, (sum, item) => sum + item.volumeL);
        final totalAlcohol = summary.values
            .fold<double>(0, (sum, item) => sum + item.alcoholL);
        final charge = absoluteAlcohol(
          volumeL: run.chargeVolumeL,
          abv: run.chargeAbv,
        );

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        RunsTab._kinds[run.kind] ?? run.kind,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Удалить прогон',
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: () => scope.production.deleteRun(run.id),
                    ),
                  ],
                ),
                Text(
                  '${formatNumeric(run.startedAt)} · в куб '
                  '${formatVolume(run.chargeVolumeL)} '
                  '${formatNumber(run.chargeAbv, decimals: 0)}% '
                  '(${formatVolume(charge)} АС)',
                  style: theme.textTheme.bodySmall,
                ),
                if (fractions.isNotEmpty) ...[
                  const Divider(height: 18),
                  for (final entry in summary.entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(RunsTab._fractionKinds[entry.key] ?? entry.key),
                          Text(
                            '${formatVolume(entry.value.volumeL)} · '
                            '${formatVolume(entry.value.alcoholL)} АС',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  const Divider(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Всего', style: theme.textTheme.titleSmall),
                      Text(
                        '${formatVolume(totalVolume)} · '
                        '${formatVolume(totalAlcohol)} АС',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  if (charge > 0)
                    Text(
                      'Выход от залитого: '
                      '${formatNumber(totalAlcohol / charge * 100, decimals: 0)}%',
                      style: theme.textTheme.bodySmall,
                    ),
                  const SizedBox(height: 8),
                  for (final f in fractions)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 28,
                            child: Text(
                              '№${f.jarNo}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${RunsTab._fractionKinds[f.kind] ?? f.kind} · '
                              '${formatNumber(f.volumeMl, decimals: 0)} мл · '
                              '${formatNumber(f.abv, decimals: 0)}%',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.close, size: 16),
                            onPressed: () =>
                                scope.production.deleteFraction(f.id),
                          ),
                        ],
                      ),
                    ),
                ],
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => _addFraction(context, run.id, fractions),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Добавить банку'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _addFraction(
    BuildContext context,
    String runId,
    List<RunFraction> existing,
  ) async {
    final scope = AppScope.of(context);
    var kind = 'heads';
    final jar = TextEditingController(
      text: '${existing.length + 1}',
    );
    final volume = TextEditingController();
    final abv = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('Банка'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: kind,
                  decoration: const InputDecoration(
                    labelText: 'Фракция',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    for (final entry in RunsTab._fractionKinds.entries)
                      DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                  ],
                  onChanged: (value) => setLocal(() => kind = value ?? 'heads'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: jar,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Номер банки',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: volume,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Объём',
                    suffixText: 'мл',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: abv,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Крепость',
                    suffixText: '%',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () async {
                final v = double.tryParse(volume.text.replaceAll(',', '.')) ?? 0;
                if (v <= 0) return;
                await scope.production.addFraction(
                  runId: runId,
                  kind: kind,
                  jarNo: int.tryParse(jar.text) ?? existing.length + 1,
                  volumeMl: v,
                  abv: double.tryParse(abv.text.replaceAll(',', '.')) ?? 0,
                );
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
