import 'package:flutter/material.dart';

import '../data/db/app_database.dart';
import '../utils/format.dart';

/// Карточка активной партии: что это, сколько дней идёт, что дальше.
class BatchCard extends StatelessWidget {
  const BatchCard({
    super.key,
    required this.batch,
    this.recipeKind,
    this.nextEvent,
    this.onTap,
  });

  final Batch batch;
  final String? recipeKind;
  final BatchEvent? nextEvent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = daysSince(batch.startedAt);
    final icon = kRecipeKindIcons[recipeKind] ?? Icons.science;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: theme.colorScheme.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          batch.title,
                          style: theme.textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          [
                            if (batch.code.isNotEmpty) batch.code,
                            '${days < 0 ? 0 : days} ${plural(days, 'день', 'дня', 'дней')}',
                            kBatchStatusLabels[batch.status] ?? batch.status,
                          ].join(' · '),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (batch.volumeL > 0)
                    Text(
                      formatVolume(batch.volumeL),
                      style: theme.textTheme.labelLarge,
                    ),
                ],
              ),
              if (nextEvent != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(eventIcon(nextEvent!.kind),
                          size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          nextEvent!.title,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        relativeDay(nextEvent!.plannedAt),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
