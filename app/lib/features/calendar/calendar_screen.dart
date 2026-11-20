import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../utils/format.dart';
import '../../widgets/event_tile.dart';
import '../batches/batch_detail_screen.dart';

/// Экран «Календарь»: месяц с точками событий и список выбранного дня.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _month;
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
    _selected = DateTime(now.year, now.month, now.day);
  }

  void _shiftMonth(int delta) {
    setState(() => _month = DateTime(_month.year, _month.month + delta));
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);
    final monthStart = _month;
    final monthEnd = DateTime(_month.year, _month.month + 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: 'Сегодня',
            onPressed: () {
              final now = DateTime.now();
              setState(() {
                _month = DateTime(now.year, now.month);
                _selected = DateTime(now.year, now.month, now.day);
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<List<BatchEvent>>(
        stream: scope.batches.watchEventsInRange(monthStart, monthEnd),
        builder: (context, snapshot) {
          final events = snapshot.data ?? const <BatchEvent>[];
          final byDay = <int, List<BatchEvent>>{};
          for (final e in events) {
            byDay.putIfAbsent(e.plannedAt.day, () => []).add(e);
          }

          final selectedEvents = byDay[_selected.day] ?? const <BatchEvent>[];

          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => _shiftMonth(-1),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Expanded(
                    child: Text(
                      '${kMonthsNominative[_month.month - 1]} ${_month.year}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _shiftMonth(1),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
              _MonthGrid(
                month: _month,
                selected: _selected,
                byDay: byDay,
                onSelect: (d) => setState(() => _selected = d),
              ),
              const SizedBox(height: 20),
              Text(
                formatFullDate(_selected),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (selectedEvents.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'На этот день событий нет.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              else
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < selectedEvents.length; i++) ...[
                        if (i > 0) const Divider(height: 1, indent: 56),
                        EventTile(
                          event: selectedEvents[i],
                          onDone: () => scope.batches
                              .markEvent(selectedEvents[i], 'done'),
                          onSkip: () => scope.batches
                              .markEvent(selectedEvents[i], 'skipped'),
                          onSnooze: () =>
                              scope.batches.snooze(selectedEvents[i], 1),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BatchDetailScreen(
                                batchId: selectedEvents[i].batchId,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.selected,
    required this.byDay,
    required this.onSelect,
  });

  final DateTime month;
  final DateTime selected;
  final Map<int, List<BatchEvent>> byDay;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // Первый день месяца: 1 = понедельник.
    final firstWeekday = DateTime(month.year, month.month, 1).weekday;
    final leading = firstWeekday - 1;
    final cells = leading + daysInMonth;
    final rows = (cells / 7).ceil();
    final today = DateTime.now();

    return Column(
      children: [
        Row(
          children: [
            for (final label in kWeekdaysShort)
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        for (var row = 0; row < rows; row++)
          Row(
            children: [
              for (var col = 0; col < 7; col++)
                Expanded(
                  child: _buildCell(context, row * 7 + col - leading + 1, today),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildCell(BuildContext context, int day, DateTime today) {
    final theme = Theme.of(context);
    if (day < 1 || day > DateTime(month.year, month.month + 1, 0).day) {
      return const SizedBox(height: 52);
    }
    final date = DateTime(month.year, month.month, day);
    final isSelected = date.year == selected.year &&
        date.month == selected.month &&
        date.day == selected.day;
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    final events = byDay[day] ?? const <BatchEvent>[];
    final hasOverdue = events.any((e) =>
        e.status == 'planned' && date.isBefore(DateTime(today.year, today.month, today.day)));

    return InkWell(
      onTap: () => onSelect(date),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 52,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.18)
              : null,
          borderRadius: BorderRadius.circular(10),
          border: isToday
              ? Border.all(color: theme.colorScheme.primary, width: 1.2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final e in events.take(3))
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e.status == 'done'
                          ? theme.colorScheme.primary.withValues(alpha: 0.4)
                          : hasOverdue
                              ? theme.colorScheme.error
                              : theme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
