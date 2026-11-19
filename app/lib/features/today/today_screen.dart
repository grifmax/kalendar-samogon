import 'package:material_ui/material_ui.dart';

import '../../widgets/section_placeholder.dart';

/// Экран «Сегодня»: задачи на день, просроченные события, активные партии.
/// Появится в M1.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сегодня')),
      body: const SectionPlaceholder(
        icon: Icons.today,
        title: 'Здесь будут задачи на день',
        message:
            'Заведите партию по рецепту — приложение само разложит процесс '
            'на события и покажет, что делать сегодня.',
      ),
    );
  }
}
