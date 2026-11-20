import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../utils/format.dart';
import 'recipe_detail_screen.dart';

/// Экран «Рецепты»: каталог с поиском и фильтром по типу.
///
/// В режиме [selectMode] список открывается для выбора рецепта под новую
/// партию — тогда вместо карточки рецепта сразу открывается запуск партии.
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key, this.selectMode = false});

  final bool selectMode;

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final _controller = TextEditingController();
  String? _kind;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectMode ? 'Выберите рецепт' : 'Рецепты'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: TextField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Поиск: хреновуха, кукуруза, бочка…',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _KindChip(
                  label: 'Все',
                  selected: _kind == null,
                  onTap: () => setState(() => _kind = null),
                ),
                for (final entry in kRecipeKindLabels.entries)
                  _KindChip(
                    label: entry.value,
                    selected: _kind == entry.key,
                    onTap: () => setState(() => _kind = entry.key),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<List<Recipe>>(
              stream: scope.recipes.search(_controller.text, kind: _kind),
              builder: (context, snapshot) {
                final recipes = snapshot.data ?? const <Recipe>[];
                if (recipes.isEmpty) {
                  return Center(
                    child: Text(
                      'Ничего не нашлось',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  itemCount: recipes.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, i) => _RecipeTile(
                    recipe: recipes[i],
                    selectMode: widget.selectMode,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _KindChip extends StatelessWidget {
  const _KindChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
      ),
    );
  }
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({required this.recipe, required this.selectMode});

  final Recipe recipe;
  final bool selectMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tags = recipe.styleTags
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .split(',')
        .where((t) => t.trim().isNotEmpty)
        .take(3)
        .toList();

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            kRecipeKindIcons[recipe.kind] ?? Icons.menu_book,
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(recipe.title, style: theme.textTheme.titleSmall),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              '${kRecipeKindLabels[recipe.kind] ?? recipe.kind}'
              '${recipe.expectedYieldL > 0 ? ' · выход ${formatVolume(recipe.expectedYieldL)}' : ''}',
              style: theme.textTheme.bodySmall,
            ),
            if (tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Wrap(
                  spacing: 4,
                  children: [
                    for (final tag in tags)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(tag.trim(),
                            style: theme.textTheme.labelSmall),
                      ),
                  ],
                ),
              ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => RecipeDetailScreen(
              recipeId: recipe.id,
              startImmediately: selectMode,
            ),
          ),
        ),
      ),
    );
  }
}
