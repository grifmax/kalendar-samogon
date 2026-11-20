import 'package:flutter/material.dart';

import '../../domain/reference.dart';
import '../../utils/format.dart';

/// Справочник: нормы сырья, сладость, типовые крепости, выход спирта.
class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({super.key});

  static const _categories = {
    'berry': 'Ягоды',
    'fruit': 'Фрукты',
    'spice': 'Специи и пряности',
    'herb': 'Травы',
    'nut': 'Орехи',
    'coffee': 'Кофе',
    'sugar': 'Сахаросодержащее',
    'grain': 'Зерно',
    'starch': 'Крахмал',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grouped = <String, List<RawMaterial>>{};
    for (final material in rawMaterials) {
      grouped.putIfAbsent(material.category, () => []).add(material);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Справочник')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Text(
            'Нормы закладки, содержание сахара и объём, который сырьё '
            'занимает в таре. По этим цифрам редактор рецепта считает '
            'итоговую крепость.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),

          _SectionHeader(title: 'Сладость напитка', icon: Icons.icecream),
          for (final level in sweetnessLevels)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(level.title),
              trailing: Text(
                '${level.minSugarGramsPerLitre.round()}–'
                '${level.maxSugarGramsPerLitre.round()} г/л',
                style: theme.textTheme.bodySmall,
              ),
            ),

          const SizedBox(height: 12),
          _SectionHeader(title: 'Типовая крепость', icon: Icons.percent),
          for (final entry in kTypicalAbvByKind.entries)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(kRecipeKindLabels[entry.key] ?? entry.key),
              trailing: Text(
                '${entry.value.$1.round()}–${entry.value.$2.round()}%',
                style: theme.textTheme.bodySmall,
              ),
            ),

          const SizedBox(height: 12),
          _SectionHeader(title: 'Выход спирта', icon: Icons.science),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Сахар'),
            trailing: Text(
              '0,64 л АС/кг (теория), 0,60 (практика)',
              style: theme.textTheme.bodySmall,
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Крахмал'),
            trailing: Text(
              '0,71 л АС/кг',
              style: theme.textTheme.bodySmall,
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Сахар при растворении'),
            trailing: Text(
              '0,6 л объёма на кг',
              style: theme.textTheme.bodySmall,
            ),
          ),

          const SizedBox(height: 12),
          _SectionHeader(title: 'Сырьё и нормы', icon: Icons.eco),
          for (final entry in _categories.entries)
            if (grouped[entry.key] != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 4),
                child: Text(entry.value, style: theme.textTheme.titleSmall),
              ),
              for (final material in grouped[entry.key]!)
                _MaterialTile(material: material),
            ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(title, style: theme.textTheme.titleMedium),
      ],
    );
  }
}

class _MaterialTile extends StatelessWidget {
  const _MaterialTile({required this.material});

  final RawMaterial material;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lo = material.minGramsPerLitre;
    final hi = material.maxGramsPerLitre;
    final dose = lo != null && hi != null
        ? '${lo.round()}–${hi.round()} г/л'
        : null;
    final sugar = material.sugarFraction > 0
        ? 'сахар ${(material.sugarFraction * 100).round()}%'
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    material.title,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                if (dose != null)
                  Text(dose, style: theme.textTheme.bodySmall),
              ],
            ),
            if (sugar != null)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(sugar, style: theme.textTheme.bodySmall),
              ),
            if (material.note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  material.note,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
