import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../utils/format.dart';
import '../batches/batch_detail_screen.dart';
import 'recipe_tune_sheet.dart';

/// Карточка рецепта: состав, шаги, запуск партии.
class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
    this.startImmediately = false,
  });

  final String recipeId;

  /// Открыть сразу диалог запуска партии (когда рецепт выбирали из «Партий»).
  final bool startImmediately;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  List<RecipeIngredient> _ingredients = const [];
  List<RecipeStep> _steps = const [];
  Recipe? _recipe;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final scope = AppScope.of(context);
    final recipe = await scope.recipes.byId(widget.recipeId);
    final ingredients = await scope.recipes.ingredients(widget.recipeId);
    final steps = await scope.recipes.steps(widget.recipeId);
    if (!mounted) return;
    setState(() {
      _recipe = recipe;
      _ingredients = ingredients;
      _steps = steps;
    });
    if (widget.startImmediately) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startBatch());
    }
  }

  Future<void> _startBatch() async {
    final recipe = _recipe;
    if (recipe == null) return;
    final scope = AppScope.of(context);

    final result = await showRecipeTuneSheet(
      context: context,
      recipe: recipe,
      ingredients: _ingredients,
    );
    if (result == null || !mounted) return;

    final batchId = await scope.batches.createFromRecipe(
      recipe: recipe,
      steps: _steps,
      startedAt: result.startedAt,
      volumeL: result.volumeL,
      notes: [
        if (result.notes.isNotEmpty) result.notes,
        result.summary,
      ].join('\n'),
      ingredients: result.ingredients,
    );
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Партия запущена: ${result.summary}')),
    );
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BatchDetailScreen(batchId: batchId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipe = _recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe?.title ?? 'Рецепт'),
        actions: [
          if (recipe != null)
            IconButton(
              tooltip: 'Настроить под себя',
              icon: const Icon(Icons.edit_outlined),
              onPressed: _startBatch,
            ),
          if (recipe != null)
            IconButton(
              tooltip: recipe.isFavorite ? 'Убрать из избранного' : 'В избранное',
              icon: Icon(
                recipe.isFavorite ? Icons.star : Icons.star_border,
                color: recipe.isFavorite ? theme.colorScheme.primary : null,
              ),
              onPressed: () async {
                await AppScope.of(context).recipes.toggleFavorite(recipe);
                await _load();
              },
            ),
        ],
      ),
      floatingActionButton: recipe == null
          ? null
          : FloatingActionButton.extended(
              onPressed: _startBatch,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Запустить партию'),
            ),
      body: recipe == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
              children: [
                Text(recipe.summary, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(
                      icon: kRecipeKindIcons[recipe.kind] ?? Icons.menu_book,
                      label: kRecipeKindLabels[recipe.kind] ?? recipe.kind,
                    ),
                    if (recipe.baseVolumeL > 0)
                      _InfoChip(
                        icon: Icons.water_drop_outlined,
                        label: 'на ${formatVolume(recipe.baseVolumeL)}',
                      ),
                    if (recipe.expectedYieldL > 0)
                      _InfoChip(
                        icon: Icons.local_drink_outlined,
                        label: 'выход ${formatVolume(recipe.expectedYieldL)}',
                      ),
                    if (recipe.expectedAbv > 0)
                      _InfoChip(
                        icon: Icons.percent,
                        label: '${formatNumber(recipe.expectedAbv, decimals: 1)}%',
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Состав', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < _ingredients.length; i++) ...[
                        if (i > 0) const Divider(height: 1, indent: 16),
                        ListTile(
                          dense: true,
                          title: Text(_ingredients[i].name),
                          trailing: Text(
                            '${formatNumber(_ingredients[i].amount)} '
                            '${_ingredients[i].unit}',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('Шаги', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                for (var i = 0; i < _steps.length; i++)
                  _StepTile(step: _steps[i], index: i + 1),
                if (recipe.source.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Источник: ${recipe.source}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Text(label, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step, required this.index});

  final RecipeStep step;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final meta = <String>[
      if (step.offsetDays > 0)
        'день ${step.offsetDays}'
      else
        'день 0',
      if (step.durationMin != null)
        '${step.durationMin} ${plural(step.durationMin!, 'минута', 'минуты', 'минут')}',
      if (step.tempC != null) '${formatNumber(step.tempC!, decimals: 0)} °C',
      if (step.repeatEveryDays != null && step.repeatUntilDay != null)
        'каждые ${step.repeatEveryDays} дн. до дня ${step.repeatUntilDay}',
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(eventIcon(step.eventKind),
                    size: 16, color: theme.colorScheme.primary),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$index. ${step.title}',
                      style: theme.textTheme.titleSmall),
                  if (step.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(step.description, style: theme.textTheme.bodySmall),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    meta.join(' · '),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
