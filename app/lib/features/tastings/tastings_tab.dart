import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../utils/format.dart';
import '../../widgets/form_fields.dart';

/// Вкладка «Дегустации»: оценки, аромат, вкус, выводы.
class TastingsTab extends StatelessWidget {
  const TastingsTab({super.key, required this.batchId});

  final String batchId;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);

    return StreamBuilder<List<Tasting>>(
      stream: scope.production.watchTastings(batchId),
      builder: (context, snapshot) {
        final tastings = snapshot.data ?? const <Tasting>[];
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (tastings.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Дегустаций пока нет. Записывайте оценки — через полгода '
                  'будет видно, что действительно удалось.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            for (final tasting in tastings) _TastingCard(tasting: tasting),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: () => _add(context, batchId),
              icon: const Icon(Icons.add),
              label: const Text('Добавить дегустацию'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _add(BuildContext context, String batchId) async {
    final scope = AppScope.of(context);
    var rating = 3;
    String? photoPath;
    final aroma = TextEditingController();
    final taste = TextEditingController();
    final finish = TextEditingController();
    final verdict = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('Дегустация'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (var i = 1; i <= 5; i++)
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => setLocal(() => rating = i),
                        icon: Icon(
                          i <= rating ? Icons.star : Icons.star_border,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: aroma,
                  decoration: const InputDecoration(
                    labelText: 'Аромат',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: FormSpacing.field),
                TextField(
                  controller: taste,
                  decoration: const InputDecoration(
                    labelText: 'Вкус',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: FormSpacing.field),
                TextField(
                  controller: finish,
                  decoration: const InputDecoration(
                    labelText: 'Послевкусие',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: FormSpacing.field),
                TextField(
                  controller: verdict,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Что менять в следующий раз',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: FormSpacing.field),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1600,
                        imageQuality: 85,
                      );
                      if (picked != null) {
                        setLocal(() => photoPath = picked.path);
                      }
                    },
                    icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                    label: Text(
                      photoPath == null ? 'Добавить фото' : 'Фото выбрано',
                    ),
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
                await scope.production.addTasting(
                  batchId: batchId,
                  rating: rating,
                  aroma: aroma.text.trim(),
                  taste: taste.text.trim(),
                  finish: finish.text.trim(),
                  verdict: verdict.text.trim(),
                  photoPath: photoPath ?? '',
                );
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TastingCard extends StatelessWidget {
  const _TastingCard({required this.tasting});

  final Tasting tasting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scope = AppScope.of(context);

    final lines = <(String, String)>[
      if (tasting.aroma.isNotEmpty) ('Аромат', tasting.aroma),
      if (tasting.taste.isNotEmpty) ('Вкус', tasting.taste),
      if (tasting.finish.isNotEmpty) ('Послевкусие', tasting.finish),
      if (tasting.verdict.isNotEmpty) ('В следующий раз', tasting.verdict),
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  Icon(
                    i <= tasting.rating ? Icons.star : Icons.star_border,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                const Spacer(),
                Text(
                  formatNumeric(tasting.at),
                  style: theme.textTheme.bodySmall,
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.delete_outline, size: 18),
                  onPressed: () => scope.production.deleteTasting(tasting.id),
                ),
              ],
            ),
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: '${line.$1}: ',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextSpan(text: line.$2),
                    ],
                  ),
                ),
              ),
            if (tasting.photoPath.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(tasting.photoPath),
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => const SizedBox(
                      height: 0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
