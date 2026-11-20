import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../utils/format.dart';
import '../../widgets/batch_card.dart';
import '../../widgets/event_tile.dart';
import '../batches/batch_detail_screen.dart';
import '../recipes/recipes_screen.dart';

/// Экран «Сегодня»: что делать сейчас, что просрочено, что скоро.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сегодня'),
        actions: [
          IconButton(
            tooltip: 'Каталог рецептов',
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const RecipesScreen(selectMode: true),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<BatchEvent>>(
        stream: scope.batches.watchEventsInRange(
          DateTime(now.year, now.month, now.day),
          DateTime(now.year, now.month, now.day).add(const Duration(days: 8)),
        ),
        builder: (context, upcomingSnapshot) {
          return StreamBuilder<List<BatchEvent>>(
            stream: scope.batches.watchOverdue(),
            builder: (context, overdueSnapshot) {
              final upcoming = upcomingSnapshot.data ?? const <BatchEvent>[];
              final overdue = overdueSnapshot.data ?? const <BatchEvent>[];
              final tomorrow =
                  DateTime(now.year, now.month, now.day).add(const Duration(days: 1));

              final todayEvents = upcoming
                  .where((e) =>
                      e.status == 'planned' && e.plannedAt.isBefore(tomorrow))
                  .toList();
              final soon = upcoming
                  .where((e) =>
                      e.status == 'planned' &&
                      !e.plannedAt.isBefore(tomorrow))
                  .toList();

              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                children: [
                  Text(
                    formatFullDate(now),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  if (overdue.isNotEmpty) ...[
                    _SectionHeader(
                      title: 'Просрочено',
                      color: theme.colorScheme.error,
                      count: overdue.length,
                    ),
                    _EventList(events: overdue, scope: scope),
                    const SizedBox(height: 16),
                  ],
                  _SectionHeader(
                    title: 'Сегодня',
                    count: todayEvents.length,
                    color: theme.colorScheme.primary,
                  ),
                  if (todayEvents.isEmpty)
                    _EmptyHint(
                      text: overdue.isEmpty
                          ? 'На сегодня задач нет. Заведите партию — расписание '
                              'появится само.'
                          : 'На сегодня всё сделано.',
                    )
                  else
                    _EventList(events: todayEvents, scope: scope),
                  if (soon.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _SectionHeader(title: 'Скоро', count: soon.length),
                    _EventList(events: soon, scope: scope),
                  ],
                  const SizedBox(height: 24),
                  Text('Активные партии', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  _ActiveBatches(scope: scope),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.count, this.color});

  final String title;
  final int? count;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(color: color),
          ),
          if (count != null && count! > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: (color ?? theme.colorScheme.primary).withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('$count', style: theme.textTheme.labelSmall),
            ),
          ],
        ],
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({required this.events, required this.scope});

  final List<BatchEvent> events;
  final AppScope scope;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < events.length; i++) ...[
            if (i > 0) const Divider(height: 1, indent: 56),
            EventTile(
              event: events[i],
              onDone: () => scope.batches.markEvent(events[i], 'done'),
              onSkip: () => scope.batches.markEvent(events[i], 'skipped'),
              onSnooze: () => scope.batches.snooze(events[i], 1),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BatchDetailScreen(batchId: events[i].batchId),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class _ActiveBatches extends StatelessWidget {
  const _ActiveBatches({required this.scope});

  final AppScope scope;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Batch>>(
      stream: scope.batches.watchActive(),
      builder: (context, snapshot) {
        final batches = snapshot.data ?? const <Batch>[];
        if (batches.isEmpty) {
          return const _EmptyHint(
            text: 'Партий пока нет. Откройте «Рецепты» и запустите первую.',
          );
        }
        return Column(
          children: [
            for (final batch in batches)
              BatchCard(
                batch: batch,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => BatchDetailScreen(batchId: batch.id),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
