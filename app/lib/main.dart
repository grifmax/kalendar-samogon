import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/app_scope.dart';
import 'app/app_theme.dart';
import 'app/home_shell.dart';
import 'data/db/app_database.dart';
import 'data/repositories/batch_repository.dart';
import 'data/repositories/recipe_repository.dart';
import 'data/seed/recipe_seeder.dart';
import 'services/backup_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  await RecipeSeeder(db).seedIfNeeded();

  final notifications = NotificationService();
  // Не блокируем старт, если разрешения не выданы или сервис недоступен.
  notifications.init().catchError((Object e) {
    debugPrint('Напоминания недоступны: $e');
  });

  runApp(
    KalendarSamogonApp(
      db: db,
      recipes: RecipeRepository(db),
      batches: BatchRepository(db),
      notifications: notifications,
      backup: BackupService(db),
    ),
  );
}

/// Точка входа приложения «Календарь самогонщика».
class KalendarSamogonApp extends StatelessWidget {
  const KalendarSamogonApp({
    super.key,
    required this.db,
    required this.recipes,
    required this.batches,
    required this.notifications,
    required this.backup,
  });

  final AppDatabase db;
  final RecipeRepository recipes;
  final BatchRepository batches;
  final NotificationService notifications;
  final BackupService backup;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      db: db,
      recipes: recipes,
      batches: batches,
      notifications: notifications,
      backup: backup,
      child: MaterialApp(
        title: 'Календарь самогонщика',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        locale: const Locale('ru'),
        supportedLocales: const [Locale('ru')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const HomeShell(),
      ),
    );
  }
}
