import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

/// Перегонки, фракции, тара, выдержка и дегустации.
class ProductionRepository {
  ProductionRepository(this.db);

  final AppDatabase db;
  static const _uuid = Uuid();

  // ---------- перегонки ----------

  Stream<List<Run>> watchRuns(String batchId) => (db.select(db.runs)
        ..where((t) => t.batchId.equals(batchId))
        ..orderBy([(t) => OrderingTerm(expression: t.startedAt)]))
      .watch();

  Stream<List<RunFraction>> watchFractions(String runId) =>
      (db.select(db.runFractions)
            ..where((t) => t.runId.equals(runId))
            ..orderBy([(t) => OrderingTerm(expression: t.jarNo)]))
          .watch();

  Future<String> createRun({
    required String batchId,
    required String kind,
    required double chargeVolumeL,
    required double chargeAbv,
    DateTime? startedAt,
    String notes = '',
  }) async {
    final id = _uuid.v4();
    await db.into(db.runs).insert(
          RunsCompanion.insert(
            id: id,
            batchId: batchId,
            kind: kind,
            startedAt: startedAt ?? DateTime.now(),
            chargeVolumeL: Value(chargeVolumeL),
            chargeAbv: Value(chargeAbv),
            notes: Value(notes),
          ),
        );
    return id;
  }

  Future<void> deleteRun(String runId) async {
    await (db.delete(db.runs)..where((t) => t.id.equals(runId))).go();
  }

  Future<void> finishRun({
    required String runId,
    double? cubeTempEndC,
    String? notes,
  }) async {
    await (db.update(db.runs)..where((t) => t.id.equals(runId))).write(
      RunsCompanion(
        endedAt: Value(DateTime.now()),
        cubeTempEndC: Value(cubeTempEndC),
        notes: notes == null ? const Value.absent() : Value(notes),
      ),
    );
  }

  Future<void> addFraction({
    required String runId,
    required String kind,
    required int jarNo,
    required double volumeMl,
    required double abv,
    double? tempC,
    String note = '',
  }) async {
    await db.into(db.runFractions).insert(
          RunFractionsCompanion.insert(
            runId: runId,
            kind: kind,
            jarNo: Value(jarNo),
            volumeMl: volumeMl,
            abv: abv,
            tempC: Value(tempC),
            note: Value(note),
          ),
        );
  }

  Future<void> deleteFraction(int id) async {
    await (db.delete(db.runFractions)..where((t) => t.id.equals(id))).go();
  }

  /// Итог по прогону: объём и абсолютный спирт по каждой фракции.
  static Map<String, ({double volumeL, double alcoholL})> summarize(
    List<RunFraction> fractions,
  ) {
    final result = <String, ({double volumeL, double alcoholL})>{};
    for (final f in fractions) {
      final current = result[f.kind] ?? (volumeL: 0.0, alcoholL: 0.0);
      result[f.kind] = (
        volumeL: current.volumeL + f.volumeMl / 1000,
        alcoholL: current.alcoholL + f.volumeMl / 1000 * f.abv / 100,
      );
    }
    return result;
  }

  // ---------- тара ----------

  Stream<List<Vessel>> watchVessels() => (db.select(db.vessels)
        ..orderBy([(t) => OrderingTerm(expression: t.name)]))
      .watch();

  Future<void> addVessel({
    required String name,
    required String kind,
    required double volumeL,
    String material = '',
    int? charLevel,
    String location = '',
  }) async {
    await db.into(db.vessels).insert(
          VesselsCompanion.insert(
            id: _uuid.v4(),
            name: name,
            kind: kind,
            volumeL: volumeL,
            material: Value(material),
            charLevel: Value(charLevel),
            location: Value(location),
          ),
        );
  }

  Future<void> deleteVessel(String id) async {
    await (db.delete(db.vessels)..where((t) => t.id.equals(id))).go();
  }

  Future<void> setVesselOccupied(String id, bool occupied) async {
    await (db.update(db.vessels)..where((t) => t.id.equals(id))).write(
      VesselsCompanion(isOccupied: Value(occupied)),
    );
  }

  // ---------- выдержка ----------

  Stream<AgingEntry?> watchAging(String batchId) =>
      (db.select(db.aging)..where((t) => t.batchId.equals(batchId)))
          .watchSingleOrNull();

  Future<void> startAging({
    required String batchId,
    String? vesselId,
    required DateTime startedAt,
    DateTime? plannedEndAt,
    double angelSharePctYear = 3,
  }) async {
    await db.into(db.aging).insert(
          AgingCompanion.insert(
            id: _uuid.v4(),
            batchId: batchId,
            vesselId: Value(vesselId),
            startedAt: startedAt,
            plannedEndAt: Value(plannedEndAt),
            angelSharePctYear: Value(angelSharePctYear),
          ),
        );
  }

  Future<void> topUpAging(String agingId) async {
    await (db.update(db.aging)..where((t) => t.id.equals(agingId))).write(
      AgingCompanion(lastToppedAt: Value(DateTime.now())),
    );
  }

  Future<void> deleteAging(String id) async {
    await (db.delete(db.aging)..where((t) => t.id.equals(id))).go();
  }

  /// Прогноз остатка с учётом доли ангела.
  static double projectedVolume({
    required double volumeL,
    required DateTime startedAt,
    required DateTime at,
    required double angelSharePctYear,
  }) {
    final years = at.difference(startedAt).inHours / 24 / 365.25;
    if (years <= 0) return volumeL;
    return volumeL * math.pow(1 - angelSharePctYear / 100, years).toDouble();
  }

  // ---------- дегустации ----------

  Stream<List<Tasting>> watchTastings(String batchId) => (db.select(db.tastings)
        ..where((t) => t.batchId.equals(batchId))
        ..orderBy([(t) => OrderingTerm(expression: t.at, mode: OrderingMode.desc)]))
      .watch();

  Future<void> addTasting({
    required String batchId,
    required int rating,
    String aroma = '',
    String taste = '',
    String finish = '',
    String verdict = '',
    String photoPath = '',
    DateTime? at,
  }) async {
    await db.into(db.tastings).insert(
          TastingsCompanion.insert(
            id: _uuid.v4(),
            batchId: batchId,
            at: at ?? DateTime.now(),
            rating: Value(rating),
            aroma: Value(aroma),
            taste: Value(taste),
            finish: Value(finish),
            verdict: Value(verdict),
            photoPath: Value(photoPath),
          ),
        );
  }

  Future<void> deleteTasting(String id) async {
    await (db.delete(db.tastings)..where((t) => t.id.equals(id))).go();
  }
}
