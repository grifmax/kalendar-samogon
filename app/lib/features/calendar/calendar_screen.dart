import 'package:material_ui/material_ui.dart';

import '../../widgets/section_placeholder.dart';

/// Экран «Календарь»: месяц/неделя/список событий по партиям. Появится в M1.
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Календарь')),
      body: const SectionPlaceholder(
        icon: Icons.calendar_month,
        title: 'Календарь процессов',
        message:
            'Брага, перегонка, настойки, доливки бочек и дегустации — '
            'в одном календаре с напоминаниями.',
      ),
    );
  }
}
