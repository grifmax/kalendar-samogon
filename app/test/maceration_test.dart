import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/data/db/app_database.dart';
import 'package:kalendar_samogon/data/repositories/batch_repository.dart';
import 'package:kalendar_samogon/data/repositories/production_repository.dart';
import 'package:kalendar_samogon/data/repositories/recipe_repository.dart';
import 'package:kalendar_samogon/services/backup_service.dart';

void main() {
  late AppDatabase db;
  late RecipeRepository recipes;
  late BatchRepository batches;
  late ProductionRepository production;
  late BackupService backup;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    recipes = RecipeRepository(db);
    batches = BatchRepository(db);
    production = ProductionRepository(db);
    backup = BackupService(db);
  });

  /// Партия настойки — основа для проверок настаивания.
  Future<String> makeBatch() async {
    final recipeId = await recipes.createRecipe(
      title: 'Вишнёвка',
      kind: 'tincture',
      baseVolumeL: 3,
    );
    final recipe = await recipes.byId(recipeId);
    return batches.createFromRecipe(
      recipe: recipe!,
      steps: await recipes.steps(recipeId),
      startedAt: DateTime(2026, 11, 1),
      volumeL: 3,
    );
  }

  test('настаивание создаётся с интервалом взбалтывания', () async {
    final batchId = await makeBatch();

    await production.startMaceration(
      batchId: batchId,
      startedAt: DateTime(2026, 11, 1),
      plannedEndAt: DateTime(2026, 11, 22),
      shakeEveryDays: 3,
      strengthAbv: 45,
    );

    final entry = await production.watchMaceration(batchId).first;
    expect(entry, isNotNull);
    expect(entry!.shakeEveryDays, 3);
    expect(entry.shakenCount, 0);
    expect(entry.strengthAbv, 45);
    expect(entry.finishedAt, isNull);
    expect(entry.plannedEndAt, DateTime(2026, 11, 22));
  });

  test('взбалтывание сдвигает срок и считает разы', () async {
    final batchId = await makeBatch();
    await production.startMaceration(
      batchId: batchId,
      startedAt: DateTime(2026, 11, 1),
      shakeEveryDays: 3,
    );
    final entry = (await production.watchMaceration(batchId).first)!;

    await production.shakeMaceration(entry.id);
    final once = (await production.watchMaceration(batchId).first)!;
    expect(once.shakenCount, 1);
    expect(once.lastShakenAt, isNotNull);

    await production.shakeMaceration(entry.id);
    final twice = (await production.watchMaceration(batchId).first)!;
    expect(twice.shakenCount, 2);
  });

  test('снятие с осадка закрывает настаивание', () async {
    final batchId = await makeBatch();
    await production.startMaceration(
      batchId: batchId,
      startedAt: DateTime(2026, 11, 1),
    );
    final entry = (await production.watchMaceration(batchId).first)!;

    expect(entry.finishedAt, isNull);
    await production.finishMaceration(entry.id);

    final closed = (await production.watchMaceration(batchId).first)!;
    expect(closed.finishedAt, isNotNull);
  });

  group('nextShakeAt', () {
    Maceration entry({
      required DateTime startedAt,
      DateTime? lastShakenAt,
      int shakeEveryDays = 3,
    }) => Maceration(
      id: 'm1',
      batchId: 'b1',
      startedAt: startedAt,
      plannedEndAt: null,
      shakeEveryDays: shakeEveryDays,
      lastShakenAt: lastShakenAt,
      shakenCount: 0,
      strengthAbv: 0,
      finishedAt: null,
      notes: '',
    );

    test('до первого взбалтывания считается от старта', () {
      final next = ProductionRepository.nextShakeAt(
        entry(startedAt: DateTime(2026, 11, 1, 10)),
      );
      expect(next, DateTime(2026, 11, 4, 10));
    });

    test('после взбалтывания — от последнего', () {
      final next = ProductionRepository.nextShakeAt(
        entry(
          startedAt: DateTime(2026, 11, 1, 10),
          lastShakenAt: DateTime(2026, 11, 5, 18),
        ),
      );
      expect(next, DateTime(2026, 11, 8, 18));
    });

    test('нулевой интервал — напоминаний нет', () {
      expect(
        ProductionRepository.nextShakeAt(
          entry(startedAt: DateTime(2026, 11, 1), shakeEveryDays: 0),
        ),
        isNull,
      );
    });
  });

  group('macerationProgress', () {
    Maceration entry({DateTime? plannedEndAt}) => Maceration(
      id: 'm1',
      batchId: 'b1',
      startedAt: DateTime(2026, 11, 1),
      plannedEndAt: plannedEndAt,
      shakeEveryDays: 3,
      lastShakenAt: null,
      shakenCount: 0,
      strengthAbv: 0,
      finishedAt: null,
      notes: '',
    );

    test('половина срока — 0.5', () {
      final progress = ProductionRepository.macerationProgress(
        entry(plannedEndAt: DateTime(2026, 11, 21)),
        now: DateTime(2026, 11, 11),
      );
      expect(progress, closeTo(0.5, 0.001));
    });

    test('после срока не выходит за 1', () {
      final progress = ProductionRepository.macerationProgress(
        entry(plannedEndAt: DateTime(2026, 11, 21)),
        now: DateTime(2026, 12, 5),
      );
      expect(progress, 1.0);
    });

    test('без срока прогресса нет', () {
      expect(
        ProductionRepository.macerationProgress(
          entry(),
          now: DateTime(2026, 11, 11),
        ),
        isNull,
      );
    });
  });

  test('бэкап v3 переносит настаивание', () async {
    final batchId = await makeBatch();
    await production.startMaceration(
      batchId: batchId,
      startedAt: DateTime(2026, 11, 1),
      plannedEndAt: DateTime(2026, 11, 22),
      shakeEveryDays: 5,
      strengthAbv: 50,
    );
    final entry = (await production.watchMaceration(batchId).first)!;
    await production.shakeMaceration(entry.id);

    final dump = await backup.exportToMap();
    expect(dump['backupVersion'], 4);
    expect((dump['macerations'] as List).length, 1);

    final result = await backup.importFromString(jsonEncode(dump));
    expect(result.counts['настаиваний'], 1);

    final restored = await production.watchMaceration(batchId).first;
    expect(restored, isNotNull);
    expect(restored!.shakeEveryDays, 5);
    expect(restored.shakenCount, 1);
    expect(restored.strengthAbv, 50);
  });

  test('старый бэкап без настаивания импортируется', () async {
    final batchId = await makeBatch();
    final dump = await backup.exportToMap();
    // Файл формата v2: поля macerations просто нет.
    dump.remove('macerations');
    dump['backupVersion'] = 2;

    final result = await backup.importFromString(jsonEncode(dump));
    expect(result.counts['настаиваний'], 0);
    expect(await production.watchMaceration(batchId).first, isNull);
  });

  test('удаление партии уносит настаивание', () async {
    final batchId = await makeBatch();
    await production.startMaceration(
      batchId: batchId,
      startedAt: DateTime(2026, 11, 1),
    );
    await batches.deleteBatch(batchId);

    final left = await db.select(db.macerations).get();
    expect(left, isEmpty);
  });
}
