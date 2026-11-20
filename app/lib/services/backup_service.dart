import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide Batch;

import 'package:path_provider/path_provider.dart';

import '../data/db/app_database.dart';

/// Резервное копирование и восстановление.
///
/// Формат — один JSON-файл: версия схемы + все таблицы. Импорт проверяет
/// версию и не затирает данные молча: сначала показывает, что будет заменено.
class BackupService {
  BackupService(this.db);

  final AppDatabase db;

  static const backupVersion = 4;

  Future<Map<String, dynamic>> exportToMap() async {
    final recipes = await db.select(db.recipes).get();
    final ingredients = await db.select(db.recipeIngredients).get();
    final steps = await db.select(db.recipeSteps).get();
    final batches = await db.select(db.batches).get();
    final events = await db.select(db.batchEvents).get();
    final measurements = await db.select(db.measurements).get();

    // Таблицы M2.
    final batchIngredients = await db.select(db.batchIngredients).get();
    final runs = await db.select(db.runs).get();
    final fractions = await db.select(db.runFractions).get();
    final vessels = await db.select(db.vessels).get();
    final aging = await db.select(db.aging).get();
    final macerations = await db.select(db.macerations).get();
    final tastings = await db.select(db.tastings).get();

    return {
      'format': 'kalendar-samogon-backup',
      'backupVersion': backupVersion,
      'schemaVersion': db.schemaVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'recipes': recipes.map(_recipeToMap).toList(),
      'recipeIngredients': ingredients.map(_ingredientToMap).toList(),
      'recipeSteps': steps.map(_stepToMap).toList(),
      'batches': batches.map(_batchToMap).toList(),
      'batchEvents': events.map(_eventToMap).toList(),
      'measurements': measurements.map(_measurementToMap).toList(),
      'batchIngredients': batchIngredients.map(_batchIngredientToMap).toList(),
      'runs': runs.map(_runToMap).toList(),
      'runFractions': fractions.map(_fractionToMap).toList(),
      'vessels': vessels.map(_vesselToMap).toList(),
      'aging': aging.map(_agingToMap).toList(),
      'macerations': macerations.map(_macerationToMap).toList(),
      'tastings': tastings.map(_tastingToMap).toList(),
    };
  }

  /// Сохранить бэкап в файл и вернуть путь.
  Future<String> exportToFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final stamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .split('.')
        .first;
    final file = File('${dir.path}/kalendar-samogon-$stamp.json');
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(await exportToMap()),
    );
    return file.path;
  }

  /// Импорт: заменяет все данные содержимым файла.
  Future<ImportResult> importFromString(String content) async {
    final data = jsonDecode(content) as Map<String, dynamic>;
    if (data['format'] != 'kalendar-samogon-backup') {
      throw const FormatException('Это не файл резервной копии приложения');
    }
    final schema = data['schemaVersion'] as int? ?? 0;
    if (schema > db.schemaVersion) {
      throw FormatException(
        'Файл создан более новой версией приложения (схема $schema). '
        'Обновите приложение.',
      );
    }

    var counts = <String, int>{};
    await db.transaction(() async {
      await db.delete(db.measurements).go();
      await db.delete(db.batchEvents).go();
      await db.delete(db.batchIngredients).go();
      await db.delete(db.runs).go();
      await db.delete(db.runFractions).go();
      await db.delete(db.aging).go();
      await db.delete(db.macerations).go();
      await db.delete(db.tastings).go();
      await db.delete(db.batches).go();
      await db.delete(db.vessels).go();
      await db.delete(db.recipeSteps).go();
      await db.delete(db.recipeIngredients).go();
      await db.delete(db.recipes).go();

      for (final m in (data['recipes'] as List? ?? const [])) {
        await db
            .into(db.recipes)
            .insert(_recipeFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['recipeIngredients'] as List? ?? const [])) {
        await db
            .into(db.recipeIngredients)
            .insert(_ingredientFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['recipeSteps'] as List? ?? const [])) {
        await db
            .into(db.recipeSteps)
            .insert(_stepFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['batches'] as List? ?? const [])) {
        await db
            .into(db.batches)
            .insert(_batchFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['batchEvents'] as List? ?? const [])) {
        await db
            .into(db.batchEvents)
            .insert(_eventFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['measurements'] as List? ?? const [])) {
        await db
            .into(db.measurements)
            .insert(_measurementFromMap(m as Map<String, dynamic>));
      }
      // Таблицы M2: в старых копиях их нет — импорт остаётся совместимым.
      for (final m in (data['vessels'] as List? ?? const [])) {
        await db
            .into(db.vessels)
            .insert(_vesselFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['batchIngredients'] as List? ?? const [])) {
        await db
            .into(db.batchIngredients)
            .insert(_batchIngredientFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['runs'] as List? ?? const [])) {
        await db.into(db.runs).insert(_runFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['runFractions'] as List? ?? const [])) {
        await db
            .into(db.runFractions)
            .insert(_fractionFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['aging'] as List? ?? const [])) {
        await db
            .into(db.aging)
            .insert(_agingFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['macerations'] as List? ?? const [])) {
        await db
            .into(db.macerations)
            .insert(_macerationFromMap(m as Map<String, dynamic>));
      }
      for (final m in (data['tastings'] as List? ?? const [])) {
        await db
            .into(db.tastings)
            .insert(_tastingFromMap(m as Map<String, dynamic>));
      }
      counts = {
        'рецептов': (data['recipes'] as List? ?? const []).length,
        'партий': (data['batches'] as List? ?? const []).length,
        'событий': (data['batchEvents'] as List? ?? const []).length,
        'замеров': (data['measurements'] as List? ?? const []).length,
        'прогонов': (data['runs'] as List? ?? const []).length,
        'тары': (data['vessels'] as List? ?? const []).length,
        'настаиваний': (data['macerations'] as List? ?? const []).length,
        'дегустаций': (data['tastings'] as List? ?? const []).length,
      };
    });
    return ImportResult(
      counts: counts,
      exportedAt: data['exportedAt'] as String?,
    );
  }

  Future<void> markBackupNow() async {
    await db
        .into(db.appMeta)
        .insertOnConflictUpdate(
          AppMetaCompanion.insert(
            key: 'lastBackupAt',
            value: DateTime.now().toIso8601String(),
          ),
        );
  }

  Future<String?> lastBackupAt() async {
    final row = await (db.select(
      db.appMeta,
    )..where((t) => t.key.equals('lastBackupAt'))).getSingleOrNull();
    return row?.value;
  }

  // ---------- сериализация ----------

  Map<String, dynamic> _recipeToMap(Recipe r) => {
    'id': r.id,
    'title': r.title,
    'kind': r.kind,
    'styleTags': r.styleTags,
    'baseVolumeL': r.baseVolumeL,
    'expectedYieldL': r.expectedYieldL,
    'expectedAbv': r.expectedAbv,
    'summary': r.summary,
    'source': r.source,
    'isBuiltIn': r.isBuiltIn,
    'isFavorite': r.isFavorite,
    'createdAt': r.createdAt.toIso8601String(),
    'updatedAt': r.updatedAt.toIso8601String(),
  };

  RecipesCompanion _recipeFromMap(Map<String, dynamic> m) =>
      RecipesCompanion.insert(
        id: m['id'] as String,
        title: m['title'] as String,
        kind: m['kind'] as String,
        styleTags: Value(m['styleTags'] as String? ?? '[]'),
        baseVolumeL: Value((m['baseVolumeL'] as num?)?.toDouble() ?? 0),
        expectedYieldL: Value((m['expectedYieldL'] as num?)?.toDouble() ?? 0),
        expectedAbv: Value((m['expectedAbv'] as num?)?.toDouble() ?? 0),
        summary: Value(m['summary'] as String? ?? ''),
        source: Value(m['source'] as String? ?? ''),
        isBuiltIn: Value(m['isBuiltIn'] as bool? ?? false),
        isFavorite: Value(m['isFavorite'] as bool? ?? false),
        createdAt: Value(DateTime.parse(m['createdAt'] as String)),
        updatedAt: Value(DateTime.parse(m['updatedAt'] as String)),
      );

  Map<String, dynamic> _ingredientToMap(RecipeIngredient i) => {
    'recipeId': i.recipeId,
    'sortOrder': i.sortOrder,
    'name': i.name,
    'amount': i.amount,
    'unit': i.unit,
    'note': i.note,
  };

  RecipeIngredientsCompanion _ingredientFromMap(Map<String, dynamic> m) =>
      RecipeIngredientsCompanion.insert(
        recipeId: m['recipeId'] as String,
        sortOrder: Value((m['sortOrder'] as num?)?.toInt() ?? 0),
        name: m['name'] as String,
        amount: (m['amount'] as num).toDouble(),
        unit: m['unit'] as String,
        note: Value(m['note'] as String? ?? ''),
      );

  Map<String, dynamic> _stepToMap(RecipeStep s) => {
    'recipeId': s.recipeId,
    'sortOrder': s.sortOrder,
    'title': s.title,
    'description': s.description,
    'offsetDays': s.offsetDays,
    'durationMin': s.durationMin,
    'tempC': s.tempC,
    'eventKind': s.eventKind,
    'repeatEveryDays': s.repeatEveryDays,
    'repeatUntilDay': s.repeatUntilDay,
  };

  RecipeStepsCompanion _stepFromMap(Map<String, dynamic> m) =>
      RecipeStepsCompanion.insert(
        recipeId: m['recipeId'] as String,
        sortOrder: Value((m['sortOrder'] as num?)?.toInt() ?? 0),
        title: m['title'] as String,
        description: Value(m['description'] as String? ?? ''),
        offsetDays: Value((m['offsetDays'] as num?)?.toInt() ?? 0),
        durationMin: Value((m['durationMin'] as num?)?.toInt()),
        tempC: Value((m['tempC'] as num?)?.toDouble()),
        eventKind: Value(m['eventKind'] as String? ?? 'check'),
        repeatEveryDays: Value((m['repeatEveryDays'] as num?)?.toInt()),
        repeatUntilDay: Value((m['repeatUntilDay'] as num?)?.toInt()),
        repeatTitle: Value(m['repeatTitle'] as String? ?? ''),
      );

  Map<String, dynamic> _batchToMap(Batch b) => {
    'id': b.id,
    'recipeId': b.recipeId,
    'code': b.code,
    'title': b.title,
    'startedAt': b.startedAt.toIso8601String(),
    'finishedAt': b.finishedAt?.toIso8601String(),
    'volumeL': b.volumeL,
    'abv': b.abv,
    'status': b.status,
    'notes': b.notes,
    'createdAt': b.createdAt.toIso8601String(),
    'updatedAt': b.updatedAt.toIso8601String(),
  };

  BatchesCompanion _batchFromMap(Map<String, dynamic> m) =>
      BatchesCompanion.insert(
        id: m['id'] as String,
        recipeId: m['recipeId'] as String,
        code: Value(m['code'] as String? ?? ''),
        title: m['title'] as String,
        startedAt: DateTime.parse(m['startedAt'] as String),
        finishedAt: Value(
          m['finishedAt'] == null
              ? null
              : DateTime.parse(m['finishedAt'] as String),
        ),
        volumeL: Value((m['volumeL'] as num?)?.toDouble() ?? 0),
        abv: Value((m['abv'] as num?)?.toDouble() ?? 0),
        status: Value(m['status'] as String? ?? 'fermenting'),
        notes: Value(m['notes'] as String? ?? ''),
        createdAt: Value(DateTime.parse(m['createdAt'] as String)),
        updatedAt: Value(DateTime.parse(m['updatedAt'] as String)),
      );

  Map<String, dynamic> _eventToMap(BatchEvent e) => {
    'id': e.id,
    'batchId': e.batchId,
    'kind': e.kind,
    'title': e.title,
    'description': e.description,
    'plannedAt': e.plannedAt.toIso8601String(),
    'actualAt': e.actualAt?.toIso8601String(),
    'status': e.status,
    'remindBeforeMin': e.remindBeforeMin,
  };

  BatchEventsCompanion _eventFromMap(Map<String, dynamic> m) =>
      BatchEventsCompanion.insert(
        id: m['id'] as String,
        batchId: m['batchId'] as String,
        kind: m['kind'] as String,
        title: m['title'] as String,
        description: Value(m['description'] as String? ?? ''),
        plannedAt: DateTime.parse(m['plannedAt'] as String),
        actualAt: Value(
          m['actualAt'] == null
              ? null
              : DateTime.parse(m['actualAt'] as String),
        ),
        status: Value(m['status'] as String? ?? 'planned'),
        remindBeforeMin: Value((m['remindBeforeMin'] as num?)?.toInt() ?? 0),
      );

  Map<String, dynamic> _measurementToMap(Measurement m) => {
    'id': m.id,
    'batchId': m.batchId,
    'at': m.at.toIso8601String(),
    'kind': m.kind,
    'value': m.value,
    'note': m.note,
  };

  MeasurementsCompanion _measurementFromMap(Map<String, dynamic> m) =>
      MeasurementsCompanion.insert(
        id: m['id'] as String,
        batchId: m['batchId'] as String,
        at: DateTime.parse(m['at'] as String),
        kind: m['kind'] as String,
        value: (m['value'] as num).toDouble(),
        note: Value(m['note'] as String? ?? ''),
      );

  // ---------- M2 ----------

  Map<String, dynamic> _batchIngredientToMap(BatchIngredient i) => {
    'batchId': i.batchId,
    'sortOrder': i.sortOrder,
    'name': i.name,
    'amount': i.amount,
    'unit': i.unit,
    'note': i.note,
  };

  BatchIngredientsCompanion _batchIngredientFromMap(Map<String, dynamic> m) =>
      BatchIngredientsCompanion.insert(
        batchId: m['batchId'] as String,
        sortOrder: Value((m['sortOrder'] as num?)?.toInt() ?? 0),
        name: m['name'] as String,
        amount: (m['amount'] as num).toDouble(),
        unit: m['unit'] as String,
        note: Value(m['note'] as String? ?? ''),
      );

  Map<String, dynamic> _runToMap(Run r) => {
    'id': r.id,
    'batchId': r.batchId,
    'kind': r.kind,
    'startedAt': r.startedAt.toIso8601String(),
    'endedAt': r.endedAt?.toIso8601String(),
    'chargeVolumeL': r.chargeVolumeL,
    'chargeAbv': r.chargeAbv,
    'cubeTempStartC': r.cubeTempStartC,
    'cubeTempEndC': r.cubeTempEndC,
    'notes': r.notes,
  };

  RunsCompanion _runFromMap(Map<String, dynamic> m) => RunsCompanion.insert(
    id: m['id'] as String,
    batchId: m['batchId'] as String,
    kind: m['kind'] as String,
    startedAt: DateTime.parse(m['startedAt'] as String),
    endedAt: Value(
      m['endedAt'] == null ? null : DateTime.parse(m['endedAt'] as String),
    ),
    chargeVolumeL: Value((m['chargeVolumeL'] as num?)?.toDouble() ?? 0),
    chargeAbv: Value((m['chargeAbv'] as num?)?.toDouble() ?? 0),
    cubeTempStartC: Value((m['cubeTempStartC'] as num?)?.toDouble()),
    cubeTempEndC: Value((m['cubeTempEndC'] as num?)?.toDouble()),
    notes: Value(m['notes'] as String? ?? ''),
  );

  Map<String, dynamic> _fractionToMap(RunFraction f) => {
    'runId': f.runId,
    'jarNo': f.jarNo,
    'kind': f.kind,
    'volumeMl': f.volumeMl,
    'abv': f.abv,
    'tempC': f.tempC,
    'note': f.note,
  };

  RunFractionsCompanion _fractionFromMap(Map<String, dynamic> m) =>
      RunFractionsCompanion.insert(
        runId: m['runId'] as String,
        jarNo: Value((m['jarNo'] as num?)?.toInt() ?? 1),
        kind: m['kind'] as String,
        volumeMl: (m['volumeMl'] as num).toDouble(),
        abv: (m['abv'] as num).toDouble(),
        tempC: Value((m['tempC'] as num?)?.toDouble()),
        note: Value(m['note'] as String? ?? ''),
      );

  Map<String, dynamic> _vesselToMap(Vessel v) => {
    'id': v.id,
    'name': v.name,
    'kind': v.kind,
    'volumeL': v.volumeL,
    'material': v.material,
    'charLevel': v.charLevel,
    'location': v.location,
    'isOccupied': v.isOccupied,
  };

  VesselsCompanion _vesselFromMap(Map<String, dynamic> m) =>
      VesselsCompanion.insert(
        id: m['id'] as String,
        name: m['name'] as String,
        kind: m['kind'] as String,
        volumeL: (m['volumeL'] as num).toDouble(),
        material: Value(m['material'] as String? ?? ''),
        charLevel: Value((m['charLevel'] as num?)?.toInt()),
        location: Value(m['location'] as String? ?? ''),
        isOccupied: Value(m['isOccupied'] as bool? ?? false),
      );

  Map<String, dynamic> _agingToMap(AgingEntry a) => {
    'id': a.id,
    'batchId': a.batchId,
    'vesselId': a.vesselId,
    'startedAt': a.startedAt.toIso8601String(),
    'plannedEndAt': a.plannedEndAt?.toIso8601String(),
    'angelSharePctYear': a.angelSharePctYear,
    'lastToppedAt': a.lastToppedAt?.toIso8601String(),
    'notes': a.notes,
  };

  AgingCompanion _agingFromMap(Map<String, dynamic> m) => AgingCompanion.insert(
    id: m['id'] as String,
    batchId: m['batchId'] as String,
    vesselId: Value(m['vesselId'] as String?),
    startedAt: DateTime.parse(m['startedAt'] as String),
    plannedEndAt: Value(
      m['plannedEndAt'] == null
          ? null
          : DateTime.parse(m['plannedEndAt'] as String),
    ),
    angelSharePctYear: Value((m['angelSharePctYear'] as num?)?.toDouble() ?? 3),
    lastToppedAt: Value(
      m['lastToppedAt'] == null
          ? null
          : DateTime.parse(m['lastToppedAt'] as String),
    ),
    notes: Value(m['notes'] as String? ?? ''),
  );

  Map<String, dynamic> _macerationToMap(Maceration m) => {
    'id': m.id,
    'batchId': m.batchId,
    'startedAt': m.startedAt.toIso8601String(),
    'plannedEndAt': m.plannedEndAt?.toIso8601String(),
    'shakeEveryDays': m.shakeEveryDays,
    'lastShakenAt': m.lastShakenAt?.toIso8601String(),
    'shakenCount': m.shakenCount,
    'strengthAbv': m.strengthAbv,
    'finishedAt': m.finishedAt?.toIso8601String(),
    'notes': m.notes,
  };

  MacerationsCompanion _macerationFromMap(Map<String, dynamic> m) =>
      MacerationsCompanion.insert(
        id: m['id'] as String,
        batchId: m['batchId'] as String,
        startedAt: DateTime.parse(m['startedAt'] as String),
        plannedEndAt: Value(
          m['plannedEndAt'] == null
              ? null
              : DateTime.parse(m['plannedEndAt'] as String),
        ),
        shakeEveryDays: Value((m['shakeEveryDays'] as num?)?.toInt() ?? 3),
        lastShakenAt: Value(
          m['lastShakenAt'] == null
              ? null
              : DateTime.parse(m['lastShakenAt'] as String),
        ),
        shakenCount: Value((m['shakenCount'] as num?)?.toInt() ?? 0),
        strengthAbv: Value((m['strengthAbv'] as num?)?.toDouble() ?? 0),
        finishedAt: Value(
          m['finishedAt'] == null
              ? null
              : DateTime.parse(m['finishedAt'] as String),
        ),
        notes: Value(m['notes'] as String? ?? ''),
      );

  Map<String, dynamic> _tastingToMap(Tasting t) => {
    'id': t.id,
    'batchId': t.batchId,
    'at': t.at.toIso8601String(),
    'rating': t.rating,
    'aroma': t.aroma,
    'taste': t.taste,
    'finish': t.finish,
    'verdict': t.verdict,
    'photoPath': t.photoPath,
  };

  TastingsCompanion _tastingFromMap(Map<String, dynamic> m) =>
      TastingsCompanion.insert(
        id: m['id'] as String,
        batchId: m['batchId'] as String,
        at: DateTime.parse(m['at'] as String),
        rating: Value((m['rating'] as num?)?.toInt() ?? 0),
        aroma: Value(m['aroma'] as String? ?? ''),
        taste: Value(m['taste'] as String? ?? ''),
        finish: Value(m['finish'] as String? ?? ''),
        verdict: Value(m['verdict'] as String? ?? ''),
        photoPath: Value(m['photoPath'] as String? ?? ''),
      );
}

class ImportResult {
  const ImportResult({required this.counts, this.exportedAt});

  final Map<String, int> counts;
  final String? exportedAt;
}
