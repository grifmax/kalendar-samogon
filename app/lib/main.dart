import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/app_scope.dart';
import 'app/app_theme.dart';
import 'app/home_shell.dart';
import 'app/splash_screen.dart';
import 'data/db/app_database.dart';
import 'data/repositories/batch_repository.dart';
import 'data/repositories/production_repository.dart';
import 'data/repositories/recipe_repository.dart';
import 'data/seed/recipe_seeder.dart';
import 'services/backup_service.dart';
import 'services/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Заставку показываем сразу, а базу и сид готовим уже под ней: иначе
  // системная заставка висит всё время инициализации, и название приложения
  // пользователь так и не видит.
  runApp(const BootstrapApp());
}

/// Что нужно приложению после инициализации.
class _Services {
  const _Services({
    required this.db,
    required this.recipes,
    required this.batches,
    required this.production,
    required this.notifications,
    required this.backup,
  });

  final AppDatabase db;
  final RecipeRepository recipes;
  final BatchRepository batches;
  final ProductionRepository production;
  final NotificationService notifications;
  final BackupService backup;
}

/// Запуск приложения: заставка → инициализация → основное окно.
class BootstrapApp extends StatefulWidget {
  const BootstrapApp({super.key});

  /// Сколько минимум держать заставку, чтобы название успели прочитать.
  static const minimumSplash = Duration(milliseconds: 1400);

  @override
  State<BootstrapApp> createState() => _BootstrapAppState();
}

class _BootstrapAppState extends State<BootstrapApp> {
  _Services? _ready;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final started = DateTime.now();

    final db = AppDatabase();
    await RecipeSeeder(db).seedIfNeeded();

    // Партии, заведённые до 0.11.0, хранят старые названия повторов —
    // подтягиваем их к текущим шагам рецепта.
    try {
      await BatchRepository(db).repairRepeatEventTitles();
    } catch (e) {
      debugPrint('Ремонт названий повторов не удался: $e');
    }

    final notifications = NotificationService();
    // Не блокируем старт, если разрешения не выданы или сервис недоступен.
    notifications.init().catchError((Object e) {
      debugPrint('Напоминания недоступны: $e');
    });

    final left = BootstrapApp.minimumSplash - DateTime.now().difference(started);
    if (left > Duration.zero) await Future<void>.delayed(left);

    if (!mounted) return;
    setState(() {
      _ready = _Services(
        db: db,
        recipes: RecipeRepository(db),
        batches: BatchRepository(db),
        production: ProductionRepository(db),
        notifications: notifications,
        backup: BackupService(db),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final services = _ready;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: services == null
          ? MaterialApp(
              key: const ValueKey('splash'),
              debugShowCheckedModeBanner: false,
              theme: AppTheme.dark,
              themeMode: ThemeMode.dark,
              locale: const Locale('ru'),
              supportedLocales: const [Locale('ru')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const SplashView(),
            )
          : KalendarSamogonApp(
              key: const ValueKey('app'),
              db: services.db,
              recipes: services.recipes,
              batches: services.batches,
              production: services.production,
              notifications: services.notifications,
              backup: services.backup,
            ),
    );
  }
}

/// Точка входа приложения «Календарь самогонщика».
class KalendarSamogonApp extends StatelessWidget {
  const KalendarSamogonApp({
    super.key,
    required this.db,
    required this.recipes,
    required this.batches,
    required this.production,
    required this.notifications,
    required this.backup,
  });

  final AppDatabase db;
  final RecipeRepository recipes;
  final BatchRepository batches;
  final ProductionRepository production;
  final NotificationService notifications;
  final BackupService backup;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      db: db,
      recipes: recipes,
      batches: batches,
      production: production,
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
