import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/production_repository.dart';
import '../../utils/format.dart';
import '../../widgets/form_fields.dart';

/// Вкладка «Выдержка»: заливка в тару, доливки, прогноз потерь.
class AgingTab extends StatelessWidget {
  const AgingTab({super.key, required this.batchId});

  final String batchId;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);

    return StreamBuilder<AgingEntry?>(
      stream: scope.production.watchAging(batchId),
      builder: (context, snapshot) {
        final aging = snapshot.data;

        if (aging == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Выдержка не начата. Залить дистиллят в бочку или стекло — '
                    'приложение посчитает потери и напомнит о доливке.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.tonalIcon(
                    onPressed: () => _start(context, batchId),
                    icon: const Icon(Icons.add),
                    label: const Text('Начать выдержку'),
                  ),
                ],
              ),
            ),
          );
        }

        return StreamBuilder<List<Vessel>>(
          stream: scope.production.watchVessels(),
          builder: (context, vesselsSnapshot) {
            final vessels = vesselsSnapshot.data ?? const <Vessel>[];
            final vessel = vessels
                .where((v) => v.id == aging.vesselId)
                .firstOrNull;

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              children: [
                _AgingCard(aging: aging, vessel: vessel),
                const SizedBox(height: FormSpacing.section),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await scope.production.topUpAging(aging.id);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Доливка отмечена')),
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('Долить'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _confirmDelete(context, aging.id),
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Завершить'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, String agingId) async {
    final scope = AppScope.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Завершить выдержку?'),
        content: const Text(
          'Запись о выдержке удалится. Партия и её события останутся.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Завершить'),
          ),
        ],
      ),
    );
    if (ok == true) await scope.production.deleteAging(agingId);
  }

  Future<void> _start(BuildContext context, String batchId) async {
    final scope = AppScope.of(context);
    final result = await showModalBottomSheet<_AgingSetup>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _AgingSheet(),
    );
    if (result == null) return;
    await scope.production.startAging(
      batchId: batchId,
      vesselId: result.vesselId,
      startedAt: result.startedAt,
      plannedEndAt: result.plannedEndAt,
      angelSharePctYear: result.angelSharePctYear,
    );
  }
}

class _AgingCard extends StatelessWidget {
  const _AgingCard({required this.aging, this.vessel});

  final AgingEntry aging;
  final Vessel? vessel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final days = now.difference(aging.startedAt).inDays;
    final months = days / 30.0;
    final volume = vessel?.volumeL ?? 0;

    // Прогноз остатка: объём тары минус испарение.
    final remaining = volume > 0
        ? ProductionRepository.projectedVolume(
            volumeL: volume,
            startedAt: aging.startedAt,
            at: now,
            angelSharePctYear: aging.angelSharePctYear,
          )
        : 0.0;
    final loss = volume > 0 ? volume - remaining : 0.0;

    final nextTopUp = aging.lastToppedAt == null
        ? aging.startedAt.add(const Duration(days: 30))
        : aging.lastToppedAt!.add(const Duration(days: 30));
    final topUpDue = nextTopUp.isBefore(now);

    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.primary.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vessel?.name ?? 'Тара не выбрана',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: FormSpacing.titleToHint),
            Text(
              [
                formatFullDate(aging.startedAt),
                '$days ${plural(days, 'день', 'дня', 'дней')} '
                    '(≈ ${formatNumber(months, decimals: 1)} мес.)',
                if (aging.angelSharePctYear > 0)
                  'испарение ${formatNumber(aging.angelSharePctYear, decimals: 1)}%/год',
              ].join(' · '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const Divider(height: 24),
            if (volume > 0) ...[
              _row('Залито', formatVolume(volume)),
              _row('Осталось (расчёт)', formatVolume(remaining)),
              _row(
                'Ангельская доля',
                '${formatVolume(loss)} '
                    '(${volume > 0 ? (loss / volume * 100).round() : 0}%)',
              ),
              const Divider(height: 24),
            ],
            _row(
              'Последняя доливка',
              aging.lastToppedAt == null
                  ? 'не было'
                  : formatNumeric(aging.lastToppedAt!),
              warn: aging.lastToppedAt == null && days > 30,
            ),
            _row(
              'Следующая доливка',
              formatNumeric(nextTopUp),
              warn: topUpDue,
            ),
            if (aging.plannedEndAt != null)
              _row('Плановый конец', formatNumeric(aging.plannedEndAt!)),
            if (topUpDue) ...[
              const SizedBox(height: FormSpacing.fieldToHint),
              Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 16, color: theme.colorScheme.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Пора долить: бочка не должна стоять с воздухом.',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.error),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool warn = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FormSpacing.resultRow / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: warn
                  ? const TextStyle(color: Colors.redAccent)
                  : null,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: warn ? Colors.redAccent : null,
            ),
          ),
        ],
      ),
    );
  }
}

/// Результат заполнения формы выдержки.
class _AgingSetup {
  const _AgingSetup({
    required this.vesselId,
    required this.startedAt,
    required this.plannedEndAt,
    required this.angelSharePctYear,
  });

  final String? vesselId;
  final DateTime startedAt;
  final DateTime? plannedEndAt;
  final double angelSharePctYear;
}

class _AgingSheet extends StatefulWidget {
  const _AgingSheet();

  @override
  State<_AgingSheet> createState() => _AgingSheetState();
}

class _AgingSheetState extends State<_AgingSheet> {
  String? _vesselId;
  DateTime _startedAt = DateTime.now();
  int _months = 12;
  double _angelShare = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scope = AppScope.of(context);

    return StreamBuilder<List<Vessel>>(
      stream: scope.production.watchVessels(),
      builder: (context, snapshot) {
        final vessels = snapshot.data ?? const <Vessel>[];
        final barrels = vessels.where((v) => v.kind == 'barrel').toList();
        final others = vessels.where((v) => v.kind != 'barrel').toList();

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
              Text('Начать выдержку', style: theme.textTheme.titleLarge),
              const SizedBox(height: FormSpacing.titleToField),
              if (vessels.isEmpty)
                Text(
                  'Сначала добавьте тару в разделе «Склад и погреб».',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                DropdownButtonFormField<String?>(
                  initialValue: _vesselId,
                  decoration: const InputDecoration(
                    labelText: 'Тара',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Без тары (учёт без объёма)'),
                    ),
                    for (final v in [...barrels, ...others])
                      DropdownMenuItem<String?>(
                        value: v.id,
                        child: Text('${v.name} · ${formatVolume(v.volumeL)}'),
                      ),
                  ],
                  onChanged: (value) => setState(() => _vesselId = value),
                ),
              const SizedBox(height: FormSpacing.field),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _startedAt,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => _startedAt = picked);
                        }
                      },
                      icon: const Icon(Icons.calendar_today, size: 18),
                      label: Text(formatFullDate(_startedAt)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: FormSpacing.field),
              Text('Плановый срок', style: theme.textTheme.titleSmall),
              const SizedBox(height: FormSpacing.titleToField),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final m in const [3, 6, 12, 18, 24, 36])
                    ChoiceChip(
                      label: Text('$m мес.'),
                      selected: _months == m,
                      onSelected: (_) => setState(() => _months = m),
                    ),
                ],
              ),
              const SizedBox(height: FormSpacing.chipsToField),
              Text(
                'Потери на испарение: 2–3 %/год в прохладе, до 5 % в жаре, '
                '10–15 % в малых бочках.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: FormSpacing.field),
              Wrap(
                spacing: 8,
                children: [
                  for (final pct in const [2.0, 3.0, 5.0, 10.0])
                    ChoiceChip(
                      label: Text('${pct.round()} %/год'),
                      selected: (_angelShare - pct).abs() < 0.01,
                      onSelected: (_) => setState(() => _angelShare = pct),
                    ),
                ],
              ),
              const SizedBox(height: FormSpacing.section),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(
                    _AgingSetup(
                      vesselId: _vesselId,
                      startedAt: _startedAt,
                      plannedEndAt:
                          DateTime(_startedAt.year, _startedAt.month + _months,
                              _startedAt.day),
                      angelSharePctYear: _angelShare,
                    ),
                  ),
                  child: const Text('Начать'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
