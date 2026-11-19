import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Экран «Ещё»: калькуляторы, склад, дегустации, оборудование, справочник,
/// настройки. Появится в M1–M2.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ещё')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          _Tile(
            icon: Icons.calculate_outlined,
            title: 'Калькуляторы',
            subtitle: 'Брага, разбавление, фракции, сироп, бочка',
          ),
          _Tile(
            icon: Icons.inventory_2_outlined,
            title: 'Склад и погреб',
            subtitle: 'Бочки, бутыли, что готово к розливу',
          ),
          _Tile(
            icon: Icons.local_bar_outlined,
            title: 'Дегустации',
            subtitle: 'Оценки, заметки, фото',
          ),
          _Tile(
            icon: Icons.precision_manufacturing_outlined,
            title: 'Оборудование',
            subtitle: 'Аппарат, куб, датчики, Smart-Column S3',
          ),
          _Tile(
            icon: Icons.auto_stories_outlined,
            title: 'Справочник',
            subtitle: 'Статьи, глоссарий, таблицы',
          ),
          _Tile(
            icon: Icons.settings_outlined,
            title: 'Настройки',
            subtitle: 'Тема, напоминания, бэкап, экспорт',
          ),
          const SizedBox(height: 24),
          const Center(child: _VersionLabel()),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _VersionLabel extends StatelessWidget {
  const _VersionLabel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final info = snapshot.data;
        final text = info == null
            ? 'Календарь самогонщика'
            : 'Календарь самогонщика · версия ${info.version}';
        return Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('«$title» появится на следующем этапе')),
        );
      },
    );
  }
}
