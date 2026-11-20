import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../utils/format.dart';

/// Склад и погреб: тара, что в ней и сколько всего занято.
class VesselsScreen extends StatelessWidget {
  const VesselsScreen({super.key});

  static const _kinds = {
    'barrel': 'Бочка',
    'glass': 'Стекло',
    'steel': 'Нерж',
    'jar': 'Банка',
    'bottle': 'Бутылка',
    'fermenter': 'Бродильная ёмкость',
  };

  static const _icons = {
    'barrel': Icons.inventory_2,
    'glass': Icons.wine_bar,
    'steel': Icons.local_drink,
    'jar': Icons.coffee_maker,
    'bottle': Icons.liquor,
    'fermenter': Icons.science,
  };

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Склад и погреб')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context),
        icon: const Icon(Icons.add),
        label: const Text('Добавить тару'),
      ),
      body: StreamBuilder<List<Vessel>>(
        stream: scope.production.watchVessels(),
        builder: (context, snapshot) {
          final vessels = snapshot.data ?? const <Vessel>[];
          if (vessels.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Тара не заведена. Добавьте бочки и бутыли — приложение '
                  'посчитает, сколько занято и сколько свободно.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            );
          }

          final total = vessels.fold<double>(0, (s, v) => s + v.volumeL);
          final occupied = vessels
              .where((v) => v.isOccupied)
              .fold<double>(0, (s, v) => s + v.volumeL);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              Card(
                margin: EdgeInsets.zero,
                color: theme.colorScheme.primary.withValues(alpha: 0.10),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Всего тары', style: theme.textTheme.titleSmall),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Объём', style: theme.textTheme.bodyMedium),
                          Text(
                            formatVolume(total),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Занято', style: theme.textTheme.bodyMedium),
                          Text(
                            '${formatVolume(occupied)} '
                            '(${total > 0 ? (occupied / total * 100).round() : 0}%)',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Свободно', style: theme.textTheme.bodyMedium),
                          Text(
                            formatVolume(total - occupied),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              for (final vessel in vessels) _VesselTile(vessel: vessel),
            ],
          );
        },
      ),
    );
  }

  Future<void> _add(BuildContext context) async {
    final scope = AppScope.of(context);
    var kind = 'jar';
    final name = TextEditingController();
    final volume = TextEditingController();
    final location = TextEditingController();
    var charLevel = 2;

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('Новая тара'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  onChanged: (value) => setLocal(() => kind = value ?? 'jar'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                    hintText: 'Бочка №1',
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
                    suffixText: 'л',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: location,
                  decoration: const InputDecoration(
                    labelText: 'Где стоит',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                if (kind == 'barrel') ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: charLevel,
                    decoration: const InputDecoration(
                      labelText: 'Обжиг',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Лёгкий')),
                      DropdownMenuItem(value: 2, child: Text('Средний')),
                      DropdownMenuItem(value: 3, child: Text('Сильный')),
                    ],
                    onChanged: (value) =>
                        setLocal(() => charLevel = value ?? 2),
                  ),
                ],
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
                await scope.production.addVessel(
                  name: name.text.trim().isEmpty
                      ? _kinds[kind] ?? 'Тара'
                      : name.text.trim(),
                  kind: kind,
                  volumeL: v,
                  location: location.text.trim(),
                  charLevel: kind == 'barrel' ? charLevel : null,
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

class _VesselTile extends StatelessWidget {
  const _VesselTile({required this.vessel});

  final Vessel vessel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scope = AppScope.of(context);

    final subtitle = [
      VesselsScreen._kinds[vessel.kind] ?? vessel.kind,
      formatVolume(vessel.volumeL),
      if (vessel.charLevel != null)
        'обжиг ${['', 'лёгкий', 'средний', 'сильный'][vessel.charLevel!.clamp(1, 3)]}',
      if (vessel.location.isNotEmpty) vessel.location,
    ].join(' · ');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          VesselsScreen._icons[vessel.kind] ?? Icons.inventory_2,
          color: vessel.isOccupied
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(vessel.name),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: vessel.isOccupied,
              onChanged: (value) =>
                  scope.production.setVesselOccupied(vessel.id, value),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () => scope.production.deleteVessel(vessel.id),
            ),
          ],
        ),
      ),
    );
  }
}
