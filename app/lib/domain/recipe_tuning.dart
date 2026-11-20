import 'dart:math' as math;

import 'reference.dart';

/// Настройка рецепта под свои условия: тара, крепость, количество сырья и сахара.
///
/// Главная идея: крепость готового напитка — это отношение спирта ко всему
/// объёму жидкости. Сахар и сырьё занимают объём и вытесняют спирт с водой,
/// поэтому «положу больше вишни» автоматически означает «меньше спирта» или
/// «крепче спирт», иначе в банку не влезет и крепость упадёт.
///
/// Расчёт идёт от тары: жидкость (спирт + вода + растворённый сахар) занимает
/// всё место, которое осталось после сырья, и её крепость равна заданной.

/// Результат настройки настойки или ликёра.
class TinctureTuning {
  const TinctureTuning({
    required this.vesselVolumeL,
    required this.targetAbv,
    required this.spiritAbv,
    required this.spiritL,
    required this.waterL,
    required this.sugarKg,
    required this.rawKg,
    required this.liquidL,
    required this.fillL,
    required this.maxAbvPossible,
    required this.rawGramsPerLitre,
    required this.sugarGramsPerLitre,
    required this.rawMaterial,
    required this.warnings,
  });

  /// Объём тары, л.
  final double vesselVolumeL;

  /// Желаемая крепость жидкости, %.
  final double targetAbv;

  /// Крепость заливаемого спирта, %.
  final double spiritAbv;

  final double spiritL;
  final double waterL;
  final double sugarKg;
  final double rawKg;

  /// Объём жидкости: спирт + вода + растворённый сахар.
  final double liquidL;

  /// Объём закладки: жидкость + сырьё. Должен влезать в тару.
  final double fillL;

  /// Максимальная крепость, которую можно получить при этих сырье и сахаре.
  final double maxAbvPossible;

  final double rawGramsPerLitre;
  final double sugarGramsPerLitre;
  final RawMaterial? rawMaterial;
  final List<String> warnings;

  /// Заполнение тары, 0..1.
  double get fillFraction =>
      vesselVolumeL > 0 ? fillL / vesselVolumeL : 0;

  bool get fits => fillL <= vesselVolumeL + 0.001;

  /// Сколько не хватает места, л (0 — влезает).
  double get deficitL => math.max(0, fillL - vesselVolumeL);

  /// Свободное место в таре, л.
  double get headroomL => math.max(0, vesselVolumeL - fillL);

  /// Объём после фильтрации: сырьё отдаёт часть сока, но и впитывает спирт.
  /// Оценка: примерно 40 % объёма сырья возвращается в напиток.
  double get estimatedFinalL => liquidL + rawKg * (rawMaterial?.volumePerKg ?? 1) * 0.4;

  /// Абсолютный спирт в настойке, л.
  double get alcoholL => spiritL * spiritAbv / 100;

  /// Итоговая крепость с учётом всего объёма жидкости.
  double get actualAbv => liquidL > 0 ? alcoholL / liquidL * 100 : 0;

  /// Категория сладости по содержанию сахара.
  SweetnessLevel? get sweetness => SweetnessLevel.bySugar(sugarGramsPerLitre);

  /// В норме ли дозировка сырья.
  bool get rawInRange =>
      rawMaterial?.isInRange(rawGramsPerLitre) ?? true;
}

/// Настроить настойку или ликёр под тару.
///
/// [vesselVolumeL] — объём банки/бутыли.
/// [targetAbv] — желаемая крепость жидкости.
/// [spiritAbv] — крепость спирта, который есть в наличии.
/// [rawKg] — сколько сырья кладём.
/// [sugarKg] — сколько сахара.
/// [warnAboutDose] — предупреждать ли о дозе вне нормы. Когда значения взяты
/// из самого рецепта, это выбор автора рецепта, а не ошибка пользователя.
///
/// Возвращает разложение по объёмам и предупреждения, если что-то не сходится.
TinctureTuning tuneTincture({
  required double vesselVolumeL,
  required double targetAbv,
  required double spiritAbv,
  required double rawKg,
  required double sugarKg,
  RawMaterial? rawMaterial,
  bool warnAboutDose = true,
}) {
  final warnings = <String>[];

  final volumePerKg = rawMaterial?.volumePerKg ?? 1.0;
  final rawVolume = math.max(0.0, rawKg) * volumePerKg;
  final sugarVolume = math.max(0.0, sugarKg) * kSugarVolumePerKgL;

  // Жидкость занимает всё, что осталось после сырья и сахара.
  final liquid = math.max(0.0, vesselVolumeL - rawVolume - sugarVolume);

  // Доля спирта в жидкости = целевая крепость / крепость спирта.
  // При цели 40 % и спирте 40 % воды не остаётся вовсе — это нормально.
  final effectiveTarget = targetAbv.clamp(0.0, spiritAbv);
  final spirit = spiritAbv > 0 ? effectiveTarget / spiritAbv * liquid : 0.0;
  final water = math.max(0.0, liquid - spirit);

  // Максимум — если залить только спирт: его крепость и есть предел.
  final maxAbv = liquid > 0 ? spiritAbv : 0.0;

  final fill = liquid + rawVolume + sugarVolume;
  final rawGpl = vesselVolumeL > 0 ? rawKg * 1000 / vesselVolumeL : 0.0;
  final sugarGpl = vesselVolumeL > 0 ? sugarKg * 1000 / vesselVolumeL : 0.0;

  if (targetAbv > spiritAbv) {
    warnings.add(
      'Крепость $spiritAbv% не даст напиток ${targetAbv.round()}%: '
      'нужен спирт крепче или меньше воды.',
    );
  }
  if (fill > vesselVolumeL + 0.001) {
    warnings.add(
      'Не влезает: закладка ${fill.toStringAsFixed(2)} л при таре '
      '${vesselVolumeL.toStringAsFixed(2)} л. Уменьшите сырьё, сахар '
      'или возьмите тару больше.',
    );
  }
  if (warnAboutDose && rawMaterial != null && !rawMaterial.isInRange(rawGpl)) {
    final lo = rawMaterial.minGramsPerLitre?.round();
    final hi = rawMaterial.maxGramsPerLitre?.round();
    warnings.add(
      'Дозировка ${rawGpl.round()} г/л вне обычной нормы $lo–$hi г/л.',
    );
  }
  if (sugarGpl > 350) {
    warnings.add(
      'Больше 350 г/л сахара не растворится полностью — часть останется '
      'сиропом на дне.',
    );
  }
  if (liquid <= 0) {
    warnings.add(
      'Сырья и сахара столько, что для жидкости не осталось места.',
    );
  }

  return TinctureTuning(
    vesselVolumeL: vesselVolumeL,
    targetAbv: targetAbv,
    spiritAbv: spiritAbv,
    spiritL: spirit,
    waterL: water,
    sugarKg: sugarKg,
    rawKg: rawKg,
    liquidL: liquid,
    fillL: fill,
    maxAbvPossible: maxAbv,
    rawGramsPerLitre: rawGpl,
    sugarGramsPerLitre: sugarGpl,
    rawMaterial: rawMaterial,
    warnings: warnings,
  );
}

/// Насколько сахар снижает крепость.
///
/// Сахар увеличивает объём, но не добавляет спирта: 100 г/л «съедают»
/// примерно 2–3 % крепости. Возвращает крепость после добавления сахара.
double abvAfterSugar({
  required double volumeL,
  required double abv,
  required double sugarKg,
}) {
  final alcohol = volumeL * abv / 100;
  final newVolume = volumeL + sugarKg * kSugarVolumePerKgL;
  if (newVolume <= 0) return 0;
  return alcohol / newVolume * 100;
}

/// Сколько спирта [spiritAbv] и воды нужно, чтобы получить [volumeL]
/// сортировки крепостью [targetAbv].
///
/// Это обратная задача к разбавлению: считаем от нужного объёма, а не от того,
/// что уже налито.
({double spiritL, double waterL}) sortingForVolume({
  required double volumeL,
  required double targetAbv,
  required double spiritAbv,
}) {
  if (volumeL <= 0 || targetAbv <= 0 || spiritAbv <= 0) {
    return (spiritL: 0.0, waterL: 0.0);
  }
  final effectiveAbv = targetAbv > spiritAbv ? spiritAbv : targetAbv;
  final spirit = volumeL * effectiveAbv / spiritAbv;
  return (spiritL: spirit, waterL: math.max(0.0, volumeL - spirit));
}

/// Сколько спирта [spiritAbv] добавить в [volumeL] напитка крепостью [abv],
/// чтобы поднять крепость до [targetAbv].
///
/// Возвращает объём добавки; 0, если поднять крепость этим спиртом нельзя.
double fortifyToTarget({
  required double volumeL,
  required double abv,
  required double targetAbv,
  required double spiritAbv,
}) {
  if (volumeL <= 0 || targetAbv <= abv || spiritAbv <= targetAbv) return 0;
  final alcohol = volumeL * abv / 100;
  final target = targetAbv / 100;
  // alcohol + x * s = target * (V + x)
  final x = (target * volumeL - alcohol) / (spiritAbv / 100 - target);
  return math.max(0.0, x);
}

/// Результат настройки браги.
class MashTuning {
  const MashTuning({
    required this.sugarKg,
    required this.hydromodule,
    required this.waterL,
    required this.extraRawKg,
    required this.totalVolumeL,
    required this.theoreticalAlcoholL,
    required this.practicalAlcoholL,
    required this.washAbv,
    required this.sugarGramsPerLitre,
    required this.warnings,
  });

  final double sugarKg;
  final double hydromodule;
  final double waterL;

  /// Дополнительное сахаристое сырьё (варенье, мёд, зерно), кг.
  final double extraRawKg;

  final double totalVolumeL;
  final double theoreticalAlcoholL;
  final double practicalAlcoholL;

  /// Крепость готовой браги, %.
  final double washAbv;

  final double sugarGramsPerLitre;
  final List<String> warnings;

  /// Влезает ли в тару объёмом [vesselVolumeL].
  bool fitsIn(double vesselVolumeL) => totalVolumeL <= vesselVolumeL + 0.001;
}

/// Настроить брагу: сахар, гидромодуль и дополнительное сырьё.
///
/// [extraRaw] — например варенье или зерно: его сахар добавляется к общему,
/// а объём учитывается отдельно.
MashTuning tuneMash({
  required double sugarKg,
  required double hydromodule,
  double extraRawKg = 0,
  RawMaterial? extraRaw,

  /// Вода из рецепта, л. Если задана — берём её, а не сахар × гидромодуль:
  /// у зерновых и фруктовых браг вода задана отдельно и от сахара не зависит.
  double? waterL,

  /// Сочное сырьё (фрукты, ягоды) само даёт воду: правило «не гуще 1:3»
  /// к нему не относится, иначе вишнёвая брага всегда «слишком густая».
  bool warnAboutHydromodule = true,
}) {
  final warnings = <String>[];
  final h = hydromodule > 0 ? hydromodule : 4.5;

  final extraSugar = math.max(0.0, extraRawKg) * (extraRaw?.sugarFraction ?? 0);
  final totalSugar = math.max(0.0, sugarKg) + extraSugar;

  final water = math.max(
    0.0,
    waterL ?? math.max(0.0, sugarKg) * h,
  );
  final sugarVolume = math.max(0.0, sugarKg) * kSugarVolumePerKgL;
  final extraVolume =
      math.max(0.0, extraRawKg) * (extraRaw?.volumePerKg ?? 1.0);

  final total = water + sugarVolume + extraVolume;
  final theoretical = totalSugar * 0.64;
  final practical = totalSugar * 0.60;
  final washAbv = total > 0 ? practical / total * 100 : 0.0;
  final sugarGpl = total > 0 ? totalSugar * 1000 / total : 0.0;

  if (sugarGpl > 300) {
    warnings.add(
      'Больше 300 г сахара на литр брага обычно не выбраживает: дрожжи '
      'гибнут от спирта. Снизьте гидромодуль или добавьте воды.',
    );
  }
  if (washAbv > 14) {
    warnings.add(
      'Расчётная крепость браги выше 14 % — большинство дрожжей столько '
      'не дадут. Ожидайте недоброд.',
    );
  }
  if (warnAboutHydromodule && h < 3) {
    warnings.add(
      'Гидромодуль меньше 1:3 — густая брага, риск перегрева и недоброда.',
    );
  }

  return MashTuning(
    sugarKg: sugarKg,
    hydromodule: h,
    waterL: water,
    extraRawKg: extraRawKg,
    totalVolumeL: total,
    theoreticalAlcoholL: theoretical,
    practicalAlcoholL: practical,
    washAbv: washAbv,
    sugarGramsPerLitre: sugarGpl,
    warnings: warnings,
  );
}

/// Подобрать сахар, чтобы брага заняла тару [vesselVolumeL] при гидромодуле [h].
double sugarForVessel({
  required double vesselVolumeL,
  required double hydromodule,
  double extraRawKg = 0,
  RawMaterial? extraRaw,
}) {
  final h = hydromodule > 0 ? hydromodule : 4.5;
  final extraVolume =
      math.max(0.0, extraRawKg) * (extraRaw?.volumePerKg ?? 1.0);
  final available = math.max(0.0, vesselVolumeL - extraVolume);
  // available = sugar*h + sugar*0.6
  return available / (h + kSugarVolumePerKgL);
}

/// Проверить, влезает ли закладка в тару, и вернуть текстовую оценку.
String vesselFitLabel(double fillL, double vesselL) {
  if (vesselL <= 0) return '';
  final fraction = fillL / vesselL;
  if (fraction > 1.001) {
    return 'Не влезает: не хватает ${(fillL - vesselL).toStringAsFixed(2)} л';
  }
  if (fraction > 0.95) return 'Впритык: ${(fraction * 100).round()} % тары';
  if (fraction > 0.8) return 'Заполнит ${(fraction * 100).round()} % тары';
  return 'Останется место: ${(fraction * 100).round()} % тары';
}
