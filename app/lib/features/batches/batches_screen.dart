import 'package:material_ui/material_ui.dart';

import '../../widgets/section_placeholder.dart';

/// Экран «Партии»: список партий, статусы, прогресс. Появится в M1.
class BatchesScreen extends StatelessWidget {
  const BatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Партии')),
      body: const SectionPlaceholder(
        icon: Icons.science,
        title: 'Партий пока нет',
        message:
            'Партия — это конкретная брага, перегон или настойка: дата старта, '
            'объём, замеры и вся история от сырья до бутылки.',
      ),
    );
  }
}
