import 'package:material_ui/material_ui.dart';

import '../../widgets/section_placeholder.dart';

/// Экран «Рецепты»: каталог встроенных и своих рецептов. Появится в M1.
class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Рецепты')),
      body: const SectionPlaceholder(
        icon: Icons.menu_book,
        title: 'Каталог рецептов',
        message:
            'Брага, дистилляты, настойки, ликёры, выдержка. Состав, шаги, '
            'сроки и признаки готовности — в одном месте.',
      ),
    );
  }
}
