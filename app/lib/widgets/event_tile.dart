import 'package:flutter/material.dart';

import '../data/db/app_database.dart';
import '../utils/format.dart';

/// Строка события календаря с быстрыми действиями.
class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.event,
    this.batchTitle,
    this.onDone,
    this.onSkip,
    this.onSnooze,
    this.onTap,
  });

  final BatchEvent event;
  final String? batchTitle;
  final VoidCallback? onDone;
  final VoidCallback? onSkip;
  final VoidCallback? onSnooze;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = event.status == 'done';
    final isSkipped = event.status == 'skipped';
    final isOverdue = event.status == 'planned' &&
        event.plannedAt.isBefore(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );

    final accent = isOverdue
        ? theme.colorScheme.error
        : isDone
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant;

    return Opacity(
      opacity: isSkipped ? 0.5 : 1,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(eventIcon(event.kind), color: accent, size: 22),
        ),
        title: Text(
          event.title,
          style: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
            fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        subtitle: Text(
          [
            ?batchTitle,
            formatTime(event.plannedAt),
            relativeDay(event.plannedAt),
          ].join(' · '),
          style: theme.textTheme.bodySmall,
        ),
        trailing: isDone
            ? Icon(Icons.check, color: theme.colorScheme.primary)
            : PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 'done':
                      onDone?.call();
                    case 'skip':
                      onSkip?.call();
                    case 'snooze':
                      onSnooze?.call();
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'done', child: Text('Сделано')),
                  PopupMenuItem(value: 'snooze', child: Text('Отложить на день')),
                  PopupMenuItem(value: 'skip', child: Text('Пропустить')),
                ],
              ),
      ),
    );
  }
}
