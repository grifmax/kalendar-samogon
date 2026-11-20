import 'package:flutter/material.dart';

import '../data/db/app_database.dart';
import '../data/repositories/batch_repository.dart';
import '../data/repositories/production_repository.dart';
import '../data/repositories/recipe_repository.dart';
import '../services/backup_service.dart';
import '../services/notification_service.dart';

/// Доступ к базе и сервисам из любого места дерева виджетов.
///
/// Простой InheritedWidget вместо внешнего state-менеджера: данные реактивны
/// сами по себе (drift отдаёт Stream), поэтому отдельное хранилище состояния
/// не нужно — меньше зависимостей и никаких платформенных сюрпризов на iOS.
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.db,
    required this.recipes,
    required this.batches,
    required this.production,
    required this.notifications,
    required this.backup,
    required super.child,
  });

  final AppDatabase db;
  final RecipeRepository recipes;
  final BatchRepository batches;
  final ProductionRepository production;
  final NotificationService notifications;
  final BackupService backup;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope не найден в дереве виджетов');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
