import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../data/repositories/production_repository.dart';
import '../../utils/format.dart';
import '../../widgets/form_fields.dart';

/// Вкладка «Настаивание»: сколько дней партия стоит на сырье, когда
/// взбалтывать и когда снимать с осадка.
///
/// Отдельный процесс, а не просто шаги рецепта: у настаивания есть состояние —
/// дата закладки, интервал взбалтываний, сколько раз уже взболтали и срок
/// снятия с осадка. По нему приложение и напоминает.
class MacerationTab extends StatelessWidget {
  const MacerationTab({super.key, required this.batchId});

  final String batchId;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);

    return StreamBuilder<Maceration?>(
      stream: scope.production.watchMaceration(batchId),
      builder: (context, snapshot) {
        final entry = snapshot.data;

        if (entry == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Настаивание не начато. Заложите сырьё и укажите срок — '
                    'приложение подскажет, когда взболтать и когда снимать '
                    'с осадка.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.tonalIcon(
                    onPressed: () => _start(context, batchId),
                    icon: const Icon(Icons.add),
                    label: const Text('Начать настаивание'),
                  ),
                ],
              ),
            ),
          );
        }

        final now = DateTime.now();
        final finished = entry.finishedAt != null;
        final days = now.difference(entry.startedAt).inDays;
        final progress = ProductionRepository.macerationProgress(
          entry,
          now: now,
        );
        final nextShake = ProductionRepository.nextShakeAt(entry);
        final shakeDue =
            !finished && nextShake != null && nextShake.isBefore(now);
        final endDue =
            !finished &&
            entry.plannedEndAt != null &&
            entry.plannedEndAt!.isBefore(now);

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: theme.colorScheme.primary.withValues(alpha: 0.10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            finished ? 'Снято с осадка' : 'Настаивается',
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                        if (entry.strengthAbv > 0)
                          Text(
                            'на спирте '
                            '${formatNumber(entry.strengthAbv, decimals: 0)} %',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: FormSpacing.titleToHint),
                    Text(
                      [
                        formatNumeric(entry.startedAt),
                        '$days ${plural(days, 'день', 'дня', 'дней')}',
                        if (entry.plannedEndAt != null)
                          'до ${formatNumeric(entry.plannedEndAt!)}',
                      ].join(' · '),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (progress != null) ...[
                      const SizedBox(height: FormSpacing.fieldToHint),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        finished
                            ? 'Готово'
                            : 'Пройдено ${(progress * 100).round()} % срока',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const Divider(height: 24),
                    _row(
                      'Взбалтывать',
                      entry.shakeEveryDays > 0
                          ? 'каждые ${entry.shakeEveryDays} '
                                '${plural(entry.shakeEveryDays, 'день', 'дня', 'дней')}'
                          : 'не нужно',
                    ),
                    _row(
                      'Взболтано',
                      entry.shakenCount == 0
                          ? 'ещё ни разу'
                          : '${entry.shakenCount} раз · '
                                '${formatNumeric(entry.lastShakenAt!)}',
                    ),
                    if (!finished && nextShake != null)
                      _row(
                        'Следующее взбалтывание',
                        formatNumeric(nextShake),
                        warn: shakeDue,
                      ),
                    if (entry.notes.isNotEmpty) ...[
                      const Divider(height: 24),
                      Text(entry.notes, style: theme.textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
            ),
            if (shakeDue || endDue) ...[
              const SizedBox(height: FormSpacing.field),
              _Hint(
                text: endDue && progress != null && progress >= 1
                    ? 'Срок вышел — пора снимать с осадка и фильтровать.'
                    : 'Пора взболтать: сырьё должно быть в спирте, а не лежать '
                          'на дне.',
              ),
            ],
            const SizedBox(height: FormSpacing.section),
            if (!finished)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: entry.shakeEveryDays > 0
                          ? () async {
                              await scope.production.shakeMaceration(entry.id);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Взболтано')),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.autorenew),
                      label: const Text('Взболтать'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _finish(context, entry.id),
                      icon: const Icon(Icons.filter_alt_outlined),
                      label: const Text('Снять с осадка'),
                    ),
                  ),
                ],
              ),
            if (finished)
              OutlinedButton.icon(
                onPressed: () => _confirmDelete(context, entry.id),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Убрать запись о настаивании'),
              ),
          ],
        );
      },
    );
  }

  Widget _row(String label, String value, {bool warn = false}) {
    final color = warn ? Colors.orangeAccent : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FormSpacing.resultRow / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: TextStyle(color: color)),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  Future<void> _finish(BuildContext context, String id) async {
    final scope = AppScope.of(context);
    await scope.production.finishMaceration(id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Снято с осадка')));
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    final scope = AppScope.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Убрать запись?'),
        content: const Text('Партия и её события останутся на месте.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Убрать'),
          ),
        ],
      ),
    );
    if (ok == true) await scope.production.deleteMaceration(id);
  }

  Future<void> _start(BuildContext context, String batchId) async {
    final scope = AppScope.of(context);
    final result = await showModalBottomSheet<_MacerationSetup>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _MacerationSheet(),
    );
    if (result == null) return;
    await scope.production.startMaceration(
      batchId: batchId,
      startedAt: result.startedAt,
      plannedEndAt: result.plannedEndAt,
      shakeEveryDays: result.shakeEveryDays,
      strengthAbv: result.strengthAbv,
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

/// Результат заполнения формы настаивания.
class _MacerationSetup {
  const _MacerationSetup({
    required this.startedAt,
    required this.plannedEndAt,
    required this.shakeEveryDays,
    required this.strengthAbv,
  });

  final DateTime startedAt;
  final DateTime? plannedEndAt;
  final int shakeEveryDays;
  final double strengthAbv;
}

class _MacerationSheet extends StatefulWidget {
  const _MacerationSheet();

  @override
  State<_MacerationSheet> createState() => _MacerationSheetState();
}

class _MacerationSheetState extends State<_MacerationSheet> {
  DateTime _startedAt = DateTime.now();
  int _days = 21;
  int _shakeEvery = 3;
  final _strengthController = TextEditingController(text: '45');

  @override
  void dispose() {
    _strengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          Text('Начать настаивание', style: theme.textTheme.titleLarge),
          const SizedBox(height: FormSpacing.titleToField),
          OutlinedButton.icon(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _startedAt,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (picked != null) setState(() => _startedAt = picked);
            },
            icon: const Icon(Icons.calendar_today, size: 18),
            label: Text('Заложено ${formatFullDate(_startedAt)}'),
          ),
          const SizedBox(height: FormSpacing.field),
          Text('Срок настаивания', style: theme.textTheme.titleSmall),
          const SizedBox(height: FormSpacing.titleToField),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final d in const [7, 14, 21, 30, 45, 60])
                ChoiceChip(
                  label: Text('$d дн.'),
                  selected: _days == d,
                  onSelected: (_) => setState(() => _days = d),
                ),
            ],
          ),
          const SizedBox(height: FormSpacing.chipsToField),
          Text('Взбалтывать', style: theme.textTheme.titleSmall),
          const SizedBox(height: FormSpacing.titleToField),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final d in const [0, 2, 3, 5, 7])
                ChoiceChip(
                  label: Text(d == 0 ? 'не нужно' : 'каждые $d дн.'),
                  selected: _shakeEvery == d,
                  onSelected: (_) => setState(() => _shakeEvery = d),
                ),
            ],
          ),
          const SizedBox(height: FormSpacing.chipsToField),
          FormNumberField(
            controller: _strengthController,
            label: 'Крепость спирта',
            suffix: '%',
            onChanged: () => setState(() {}),
          ),
          const SizedBox(height: FormSpacing.fieldToHint),
          Text(
            'Сырьё настаивается на спирте 40–50 %: крепче — быстрее и чище, '
            'слабее — больше вкуса, но риск закисания.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: FormSpacing.section),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(
                _MacerationSetup(
                  startedAt: _startedAt,
                  plannedEndAt: _startedAt.add(Duration(days: _days)),
                  shakeEveryDays: _shakeEvery,
                  strengthAbv:
                      double.tryParse(
                        _strengthController.text.replaceAll(',', '.'),
                      ) ??
                      0,
                ),
              ),
              child: const Text('Начать'),
            ),
          ),
        ],
      ),
    );
  }
}
