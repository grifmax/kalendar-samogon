import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/data/db/app_database.dart';
import 'package:kalendar_samogon/data/repositories/batch_repository.dart';
import 'package:kalendar_samogon/data/repositories/production_repository.dart';
import 'package:kalendar_samogon/data/repositories/recipe_repository.dart';
import 'package:kalendar_samogon/app/app_theme.dart';
import 'package:kalendar_samogon/app/splash_screen.dart';
import 'package:kalendar_samogon/main.dart';
import 'package:kalendar_samogon/services/backup_service.dart';
import 'package:kalendar_samogon/services/notification_service.dart';

/// Тестовое приложение на базе в памяти.
Widget _app(AppDatabase db) => KalendarSamogonApp(
      db: db,
      recipes: RecipeRepository(db),
      batches: BatchRepository(db),
      production: ProductionRepository(db),
      notifications: NotificationService(),
      backup: BackupService(db),
    );

/// Корректно снять дерево виджетов.
///
/// Drift при закрытии стрима планирует таймер с нулевой задержкой; если его
/// не «прокрутить», тест падает на проверке незавершённых таймеров.
/// Снять дерево и «прокрутить» таймеры, которые drift планирует при
/// закрытии стримов (нулевая задержка). Базу не закрываем: close() при живых
/// подписках ждёт их отмены и подвешивает тест, а база в памяти всё равно
/// умирает вместе с процессом.
Future<void> _teardownTree(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  // Базу намеренно не закрываем — см. комментарий у _teardownTree.

  testWidgets('Каркас запускается и показывает пять разделов', (tester) async {
    await tester.pumpWidget(_app(db));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Сегодня'), findsWidgets);
    // Нижняя навигация: все пять разделов на месте.
    expect(find.text('Календарь'), findsOneWidget);
    expect(find.text('Партии'), findsOneWidget);
    expect(find.text('Рецепты'), findsOneWidget);
    expect(find.text('Ещё'), findsOneWidget);

    await _teardownTree(tester);
  });

  testWidgets('Заставка показывает название и подпись', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark, home: const SplashView()),
    );
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('Календарь\nсамогонщика'), findsOneWidget);
    expect(find.text('браги · настойки · выдержка'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    await _teardownTree(tester);
  });

  testWidgets('Раздел «Ещё» показывает калькуляторы и бэкап', (tester) async {
    await tester.pumpWidget(_app(db));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Ещё'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Калькуляторы'), findsOneWidget);
    expect(find.text('Резервная копия'), findsOneWidget);

    await _teardownTree(tester);
  });

  testWidgets('Пустой экран партий предлагает открыть рецепты', (tester) async {
    await tester.pumpWidget(_app(db));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text('Партии'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Партий пока нет'), findsOneWidget);

    await _teardownTree(tester);
  });
}
