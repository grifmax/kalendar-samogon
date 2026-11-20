import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../data/db/app_database.dart';
import '../../widgets/batch_card.dart';
import '../recipes/recipes_screen.dart';
import 'batch_detail_screen.dart';

/// Экран «Партии»: все партии с фильтром по статусу.
class BatchesScreen extends StatelessWidget {
  const BatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Партии')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const RecipesScreen(selectMode: true),
          ),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Новая партия'),
      ),
      body: StreamBuilder<List<Batch>>(
        stream: scope.batches.watchAll(),
        builder: (context, snapshot) {
          final batches = snapshot.data ?? const <Batch>[];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (batches.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.science,
                        size: 56, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 16),
                    Text('Партий пока нет',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Выберите рецепт — приложение разложит процесс на события '
                      'и напомнит, что делать.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const RecipesScreen(selectMode: true),
                        ),
                      ),
                      icon: const Icon(Icons.menu_book),
                      label: const Text('Открыть рецепты'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              for (final batch in batches)
                BatchCard(
                  batch: batch,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => BatchDetailScreen(batchId: batch.id),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
