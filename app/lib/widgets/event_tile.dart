import 'package:flutter/material.dart';

import '../data/db/app_database.dart';
import '../utils/format.dart';

/// Строка события календаря с быстрыми действиями.
///
/// Главное действие — «сделано» — вынесено в квадратик слева: один тап вместо
/// «три точки → пункт меню». В меню остались только редкие действия:
/// отложить и пропустить.
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
    final isOverdue =
        event.status == 'planned' &&
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
        contentPadding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        horizontalTitleGap: 10,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DoneBox(
              key: const ValueKey('event-done'),
              checked: isDone,
              accent: accent,
              // Пропущенное событие уже не в плане — возвращать нечего.
              onTap: isDone || isSkipped ? null : onDone,
            ),
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(eventIcon(event.kind), color: accent, size: 19),
            ),
          ],
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
        trailing: isDone || isSkipped
            ? null
            : PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                tooltip: 'Отложить или пропустить',
                onSelected: (value) {
                  switch (value) {
                    case 'snooze':
                      onSnooze?.call();
                    case 'skip':
                      onSkip?.call();
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'snooze', child: Text('Отложить на день')),
                  PopupMenuItem(value: 'skip', child: Text('Пропустить')),
                ],
              ),
      ),
    );
  }
}

/// Квадратик «сделано» слева от события.
class _DoneBox extends StatelessWidget {
  const _DoneBox({
    super.key,
    required this.checked,
    required this.accent,
    this.onTap,
  });

  final bool checked;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      checked: checked,
      label: checked ? 'Выполнено' : 'Отметить выполненным',
      child: InkResponse(
        onTap: onTap,
        radius: 22,
        containedInkWell: true,
        child: SizedBox(
          // 40 px — палец попадает без прицеливания, строка остаётся компактной.
          width: 40,
          height: 40,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: checked ? accent : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: checked
                      ? accent
                      : theme.colorScheme.outline.withValues(alpha: 0.6),
                  width: 1.6,
                ),
              ),
              child: checked
                  ? Icon(
                      Icons.check,
                      size: 15,
                      color: theme.colorScheme.onPrimary,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
