import 'package:drift/native.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/data/db/app_database.dart';
import 'package:kalendar_samogon/data/repositories/batch_repository.dart';
import 'package:kalendar_samogon/data/repositories/recipe_repository.dart';
import 'package:kalendar_samogon/widgets/event_tile.dart';

/// Событие для проверки плитки.
BatchEvent event({
  String status = 'planned',
  DateTime? plannedAt,
  String title = 'Заложить вишню',
}) => BatchEvent(
  id: 'e1',
  batchId: 'b1',
  kind: 'macerate',
  title: title,
  description: '',
  plannedAt: plannedAt ?? DateTime.now(),
  actualAt: null,
  status: status,
  remindBeforeMin: 0,
  notificationId: null,
);

void main() {
  group('названия повторных событий', () {
    late AppDatabase db;
    late RecipeRepository recipes;
    late BatchRepository batches;

    setUp(() {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      recipes = RecipeRepository(db);
      batches = BatchRepository(db);
    });

    Future<List<BatchEvent>> eventsFor(RecipeStep step, DateTime start) async {
      final recipeId = await recipes.createRecipe(
        title: 'Вишнёвка',
        kind: 'tincture',
        baseVolumeL: 3,
        steps: [
          (
            title: step.title,
            description: step.description,
            offsetDays: step.offsetDays,
            durationMin: step.durationMin,
            tempC: step.tempC,
            eventKind: step.eventKind,
            repeatEveryDays: step.repeatEveryDays,
            repeatUntilDay: step.repeatUntilDay,
            repeatTitle: step.repeatTitle,
          ),
        ],
      );
      final recipe = await recipes.byId(recipeId);
      final batchId = await batches.createFromRecipe(
        recipe: recipe!,
        steps: await recipes.steps(recipeId),
        startedAt: start,
        volumeL: 3,
      );
      return batches.eventsForBatch(batchId);
    }

    test('первое событие — действие, повторы — «Взболтать»', () async {
      final events = await eventsFor(
        RecipeStep(
          id: 1,
          recipeId: 'r',
          sortOrder: 0,
          title: 'Заложить вишню',
          description: '',
          offsetDays: 0,
          durationMin: null,
          tempC: null,
          eventKind: 'macerate',
          repeatEveryDays: 3,
          repeatUntilDay: 9,
          repeatTitle: 'Взболтать',
        ),
        DateTime(2026, 11, 20),
      );

      // Дни 0, 3, 6, 9 — четыре события.
      expect(events.length, 4);
      expect(events.first.title, 'Заложить вишню');
      expect(
        events.skip(1).map((e) => e.title).toSet(),
        {'Взболтать'},
        reason: 'повторы не должны называться «Заложить вишню»',
      );
    });

    test('без названия повтора подставляется действие по типу', () async {
      final events = await eventsFor(
        RecipeStep(
          id: 1,
          recipeId: 'r',
          sortOrder: 0,
          title: 'Бурное брожение',
          description: '',
          offsetDays: 0,
          durationMin: null,
          tempC: null,
          eventKind: 'check',
          repeatEveryDays: 2,
          repeatUntilDay: 4,
          repeatTitle: '',
        ),
        DateTime(2026, 11, 20),
      );

      expect(events.first.title, 'Бурное брожение');
      expect(events.skip(1).map((e) => e.title).toSet(), {'Проверить'});
    });

    test('repeatEventTitle: доливка и проба', () {
      RecipeStep step(String kind) => RecipeStep(
        id: 1,
        recipeId: 'r',
        sortOrder: 0,
        title: 'Шаг',
        description: '',
        offsetDays: 0,
        durationMin: null,
        tempC: null,
        eventKind: kind,
        repeatEveryDays: 1,
        repeatUntilDay: 5,
        repeatTitle: '',
      );

      expect(BatchRepository.repeatEventTitle(step('topup')), 'Долить');
      expect(BatchRepository.repeatEventTitle(step('taste')), 'Проба');
      expect(BatchRepository.repeatEventTitle(step('macerate')), 'Взболтать');
      expect(
        BatchRepository.repeatEventTitle(step('bottle')),
        'Повторить: шаг',
      );
    });

    test('ремонт переименовывает повторы в старых партиях', () async {
      final recipeId = await recipes.createRecipe(
        title: 'Вишнёвка',
        kind: 'tincture',
        steps: const [
          (
            title: 'Заложить вишню',
            description: '',
            offsetDays: 0,
            durationMin: null,
            tempC: null,
            eventKind: 'macerate',
            repeatEveryDays: 3,
            repeatUntilDay: 6,
            repeatTitle: 'Взболтать',
          ),
        ],
      );
      final recipe = await recipes.byId(recipeId);
      final batchId = await batches.createFromRecipe(
        recipe: recipe!,
        steps: await recipes.steps(recipeId),
        startedAt: DateTime(2026, 11, 1),
        volumeL: 3,
      );

      // Имитируем состояние до 0.11.0: все события названы как первый шаг.
      await (db.update(db.batchEvents)..where((t) => t.batchId.equals(batchId)))
          .write(const BatchEventsCompanion(title: Value('Заложить вишню')));

      final renamed = await batches.repairRepeatEventTitles();
      expect(renamed, 2);

      final events = await batches.eventsForBatch(batchId);
      final titles = events.map((e) => e.title).toList();
      expect(titles.first, 'Заложить вишню');
      expect(titles.skip(1), everyElement('Взболтать'));

      // Второй прогон ничего не меняет.
      expect(await batches.repairRepeatEventTitles(), 0);
    });

    test('правка рецепта сохраняет повтор', () async {
      final id = await recipes.createRecipe(
        title: 'Вишнёвка',
        kind: 'tincture',
        steps: const [
          (
            title: 'Заложить вишню',
            description: '',
            offsetDays: 0,
            durationMin: null,
            tempC: null,
            eventKind: 'macerate',
            repeatEveryDays: 3,
            repeatUntilDay: 28,
            repeatTitle: 'Взболтать',
          ),
        ],
      );

      await recipes.updateRecipe(
        id: id,
        title: 'Вишнёвка крепкая',
        steps: const [
          (
            title: 'Заложить вишню',
            description: '',
            offsetDays: 0,
            durationMin: null,
            tempC: null,
            eventKind: 'macerate',
            repeatEveryDays: 3,
            repeatUntilDay: 28,
            repeatTitle: 'Взболтать',
          ),
        ],
      );

      final steps = await recipes.steps(id);
      expect(steps.single.repeatEveryDays, 3);
      expect(steps.single.repeatUntilDay, 28);
      expect(steps.single.repeatTitle, 'Взболтать');
    });
  });

  group('EventTile', () {
    testWidgets('квадратик слева отмечает выполнение одним тапом', (
      tester,
    ) async {
      var done = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventTile(
              event: event(),
              onDone: () => done++,
              onSkip: () {},
              onSnooze: () {},
            ),
          ),
        ),
      );

      // Квадратик слева — цель тапа; меню остаётся для редких действий.
      expect(find.byKey(const ValueKey('event-done')), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      // До отметки внутри квадратика галочки нет.
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('event-done')),
          matching: find.byIcon(Icons.check),
        ),
        findsNothing,
      );

      await tester.tap(find.byKey(const ValueKey('event-done')));
      await tester.pump();

      expect(done, 1);
    });

    testWidgets('у выполненного события квадратик отмечен и меню скрыто', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventTile(event: event(status: 'done'), onDone: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.more_vert), findsNothing);
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('event-done')),
          matching: find.byIcon(Icons.check),
        ),
        findsOneWidget,
      );
    });

    testWidgets('меню больше не предлагает «Сделано»', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventTile(
              event: event(),
              onDone: () {},
              onSkip: () {},
              onSnooze: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(find.text('Отложить на день'), findsOneWidget);
      expect(find.text('Пропустить'), findsOneWidget);
      expect(find.text('Сделано'), findsNothing);
    });
  });
}
