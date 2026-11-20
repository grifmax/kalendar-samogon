import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/app_scope.dart';
import '../../app/app_version.dart';
import '../../utils/format.dart';
import '../calculators/calculators_screen.dart';
import '../reference/reference_screen.dart';
import '../vessels/vessels_screen.dart';

/// Экран «Ещё»: калькуляторы, бэкап, служебная информация.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Ещё')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.calculate_outlined),
            title: const Text('Калькуляторы'),
            subtitle: const Text('Брага, разбавление, фракции, щепа, масштаб'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const CalculatorsScreen(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: const Text('Резервная копия'),
            subtitle: const Text('Сохранить все данные в файл'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _backup(context),
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Восстановить из копии'),
            subtitle: const Text('Заменить данные содержимым файла'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _restore(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Проверить напоминания'),
            subtitle: Text(
              scope.notifications.isReady
                  ? (scope.notifications.exactAllowed
                      ? 'Точные напоминания доступны'
                      : 'Разрешены неточные напоминания')
                  : 'Разрешения не выданы',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              if (!scope.notifications.exactAllowed) {
                await scope.notifications.requestExactAlarms();
              }
              await scope.notifications.showNow(
                title: 'Календарь самогонщика',
                body: 'Напоминания работают. События придут в назначенное время.',
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Тестовое уведомление отправлено')),
                );
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.auto_stories_outlined),
            title: const Text('Справочник'),
            subtitle: const Text('Нормы сырья, сладость, выход спирта'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const ReferenceScreen(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Склад и погреб'),
            subtitle: const Text('Бочки, бутыли, сколько занято'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const VesselsScreen(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.precision_manufacturing_outlined),
            title: const Text('Оборудование'),
            subtitle: const Text('Интеграция с колонной — после релиза'),
            enabled: false,
          ),
          const SizedBox(height: 24),
          const Center(child: _VersionLabel()),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _backup(BuildContext context) async {
    final scope = AppScope.of(context);
    try {
      final path = await scope.backup.exportToFile();
      await scope.backup.markBackupNow();
      final last = await scope.backup.lastBackupAt();
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(path)],
          subject: 'Резервная копия «Календарь самогонщика»',
        ),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Копия сохранена${last != null ? ' (${formatFullDate(DateTime.parse(last))})' : ''}',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось сохранить копию: $e')),
      );
    }
  }

  Future<void> _restore(BuildContext context) async {
    final scope = AppScope.of(context);
    final picked = await FilePicker.pickFile();
    if (picked == null) return;
    if (!context.mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Заменить все данные?'),
        content: const Text(
          'Текущие рецепты, партии, события и замеры будут заменены '
          'содержимым файла. Отменить это будет нельзя.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Восстановить'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    try {
      final content = await picked.xFile.readAsString();
      final result = await scope.backup.importFromString(content);
      if (!context.mounted) return;
      final summary = result.counts.entries
          .map((e) => '${e.value} ${e.key}')
          .join(', ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Восстановлено: $summary')),
      );
    } on FormatException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось восстановить: ${jsonEncode('$e')}')),
      );
    }
  }
}

class _VersionLabel extends StatelessWidget {
  const _VersionLabel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Календарь самогонщика · версия $kAppVersion',
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
