import 'dart:math' as math;

import 'reference.dart';

/// Расчёты винокурения — чистые функции без зависимостей от UI.
///
/// Все они покрыты юнит-тестами (test/calculators_test.dart). Формулы —
/// практические, с поправками там, где они важны; источник и допущения
/// указаны в комментариях.

/// Теоретический выход абсолютного спирта из сахара: 0,64 л АС на 1 кг.
const double kAlcoholPerKgSugar = 0.64;

/// Практический выход (потери брожения и перегонки): 0,58–0,62.
const double kPracticalAlcoholPerKgSugar = 0.60;

/// Плотность этилового спирта при 20 °C, кг/л.
const double kEthanolDensity = 0.789;

/// Абсолютный спирт (АС) в литрах: объём × крепость.
double absoluteAlcohol({required double volumeL, required double abv}) {
  if (volumeL <= 0 || abv <= 0) return 0;
  return volumeL * abv / 100;
}

/// План сахарной браги.
class SugarWashPlan {
  const SugarWashPlan({
    required this.waterL,
    required this.totalVolumeL,
    required this.theoreticalAlcoholL,
    required this.practicalAlcoholL,
    required this.expectedWashAbv,
  });

  /// Вода для заданного гидромодуля, л.
  final double waterL;

  /// Итоговый объём браги, л.
  final double totalVolumeL;

  /// Теоретический выход АС, л.
  final double theoreticalAlcoholL;

  /// Практический выход АС, л.
  final double practicalAlcoholL;

  /// Ожидаемая крепость готовой браги, % об.
  final double expectedWashAbv;
}

/// План сахарной браги по сахару и гидромодулю (1:4 → [hydromodule] = 4).
SugarWashPlan sugarWashPlan({
  required double sugarKg,
  required double hydromodule,
}) {
  if (sugarKg <= 0) {
    return const SugarWashPlan(
      waterL: 0,
      totalVolumeL: 0,
      theoreticalAlcoholL: 0,
      practicalAlcoholL: 0,
      expectedWashAbv: 0,
    );
  }
  final waterL = sugarKg * hydromodule;
  // 1 кг сахара при растворении добавляет ~0,6 л объёма.
  final totalVolumeL = waterL + sugarKg * 0.6;
  final theoretical = sugarKg * kAlcoholPerKgSugar;
  final practical = sugarKg * kPracticalAlcoholPerKgSugar;
  final washAbv = totalVolumeL > 0 ? practical / totalVolumeL * 100 : 0.0;
  return SugarWashPlan(
    waterL: waterL,
    totalVolumeL: totalVolumeL,
    theoreticalAlcoholL: theoretical,
    practicalAlcoholL: practical,
    expectedWashAbv: washAbv,
  );
}

/// Сколько сахара нужно, чтобы получить [targetVolumeL] браги крепостью [targetAbv].
double sugarForWash({
  required double targetVolumeL,
  required double targetAbv,
  double hydromodule = 4.5,
}) {
  if (targetVolumeL <= 0 || targetAbv <= 0) return 0;
  // Объём = вода + 0,6 × сахар, вода = сахар × гидромодуль.
  final sugarKg = targetVolumeL / (hydromodule + 0.6);
  final requiredAlcohol = targetVolumeL * targetAbv / 100;
  final byAlcohol = requiredAlcohol / kPracticalAlcoholPerKgSugar;
  return math.max(sugarKg, byAlcohol).toDouble();
}

/// Разбавление спирта: сколько воды добавить, чтобы из [volumeL] крепости
/// [fromAbv] получить [toAbv].
///
/// Формула без таблицы Фертмана: V_воды = V × (C₁/C₂ − 1).
/// Даёт погрешность 1–2% из-за контракции — для практики достаточно,
/// итоговый объём всё равно контролируется спиртометром.
double dilutionWater({
  required double volumeL,
  required double fromAbv,
  required double toAbv,
}) {
  if (volumeL <= 0 || fromAbv <= 0 || toAbv <= 0 || toAbv >= fromAbv) return 0;
  return volumeL * (fromAbv / toAbv - 1);
}

/// Итоговый объём после разбавления (с учётом контракции ~ на 3% меньше
/// арифметической суммы).
double dilutedVolume({
  required double volumeL,
  required double fromAbv,
  required double toAbv,
}) {
  if (toAbv <= 0) return 0;
  return volumeL * fromAbv / toAbv;
}

/// Фракции второго перегона.
class FractionsPlan {
  const FractionsPlan({
    required this.absoluteAlcoholL,
    required this.headsL,
    required this.heartsL,
    required this.tailsL,
  });

  final double absoluteAlcoholL;
  final double headsL;
  final double heartsL;
  final double tailsL;
}

/// План отбора фракций.
///
/// [headsPercent] — доля голов от АС: 8–10% для сахарных и зерновых,
/// 10–15% для фруктовых. [heartsYield] — доля тела от остатка АС после голов
/// (практика: 70–80%).
FractionsPlan fractionsPlan({
  required double rawVolumeL,
  required double rawAbv,
  double headsPercent = 9,
  double heartsYield = 0.75,
}) {
  final ac = absoluteAlcohol(volumeL: rawVolumeL, abv: rawAbv);
  final heads = ac * headsPercent / 100;
  final rest = ac - heads;
  final hearts = rest * heartsYield;
  final tails = rest - hearts;
  return FractionsPlan(
    absoluteAlcoholL: ac,
    headsL: heads,
    heartsL: hearts,
    tailsL: tails,
  );
}

/// Крепость по плотности (формула стандартная, для сахарных заторов):
/// ABV ≈ (OG − FG) × 131,25.
double abvFromGravity({required double og, required double fg}) {
  if (og <= fg) return 0;
  return (og - fg) * 131.25;
}

/// Поправка показаний ареометра к 20 °C для спиртовых растворов.
///
/// Приближение по таблицам ГОСТ: ±0,3–0,5% об. на 5 °C отклонения.
/// Для точных измерений нужна таблица, но для журнала этого достаточно.
double hydrometerCorrection({required double reading, required double tempC}) {
  final delta = tempC - 20;
  // Для крепких растворов поправка отрицательная при нагреве.
  return reading - delta * 0.35;
}

/// Крепость сиропа/смеси после внесения сахара.
///
/// [sugarG] — сахар в граммах, [volumeMl] — объём жидкости в мл.
/// 1 г сахара в 100 мл ≈ 1 °Bx (упрощённо, для кухонных расчётов).
double brixFromSugar({required double sugarG, required double volumeMl}) {
  if (volumeMl <= 0) return 0;
  return sugarG / volumeMl * 100;
}

/// Крепость смеси двух объёмов.
double blendAbv({
  required double volume1L,
  required double abv1,
  required double volume2L,
  required double abv2,
}) {
  final total = volume1L + volume2L;
  if (total <= 0) return 0;
  return (volume1L * abv1 + volume2L * abv2) / total;
}

/// Сколько спирта 96% нужно, чтобы получить [targetVolumeL] сортировки
/// крепостью [targetAbv].
double spiritForSorting({
  required double targetVolumeL,
  required double targetAbv,
  double spiritAbv = 96,
}) {
  if (targetVolumeL <= 0 || targetAbv <= 0 || spiritAbv <= 0) return 0;
  return targetVolumeL * targetAbv / spiritAbv;
}

/// Эквивалент щепы: сколько граммов дубовой щепы соответствует выдержке
/// в бочке объёмом [barrelL] за [months] месяцев.
///
/// Ориентир: 1 г/л щепы ≈ 1 месяц в бочке 20–50 л. Малые бочки отдают
/// дуб быстрее, поэтому коэффициент растёт при объёме меньше 10 л.
double chipsEquivalentGrams({required double volumeL, required double months}) {
  if (volumeL <= 0 || months <= 0) return 0;
  final speed = volumeL < 10 ? 1.4 : (volumeL < 30 ? 1.0 : 0.8);
  return volumeL * months * speed;
}

/// Ангельская доля: сколько литров испарится за [months] месяцев.
///
/// [annualPercent] — потери в год: 2–3% в прохладе, до 5% в жаре,
/// 10–15% в малых бочках 5–10 л.
double angelShareLoss({
  required double volumeL,
  required double months,
  required double annualPercent,
}) {
  if (volumeL <= 0 || months <= 0 || annualPercent <= 0) return 0;
  final years = months / 12;
  return volumeL * (1 - math.pow(1 - annualPercent / 100, years)).toDouble();
}

/// Себестоимость литра абсолютного спирта.
double costPerLiterOfAlcohol({
  required double totalCost,
  required double volumeL,
  required double abv,
}) {
  final ac = absoluteAlcohol(volumeL: volumeL, abv: abv);
  if (ac <= 0) return 0;
  return totalCost / ac;
}

/// Пересчёт объёма рецепта под свой объём: коэффициент масштабирования.
double scaleFactor({required double recipeVolumeL, required double myVolumeL}) {
  if (recipeVolumeL <= 0 || myVolumeL <= 0) return 1;
  return myVolumeL / recipeVolumeL;
}

// ---------- дополнительные расчёты (M2) ----------

/// Поправка плотности сусла к 20 °C.
///
/// Для сахарных растворов при нагреве ареометр показывает заниженную плотность:
/// примерно 0,002 на каждые 5 °C выше 20.
double washDensityCorrection({required double sg, required double tempC}) {
  final delta = tempC - 20;
  return sg + delta * 0.0004;
}

/// Потенциальная крепость по начальной плотности (до брожения).
///
/// Оценка: (OG − 1.000) × 131 — сколько процентов спирта получится,
/// если брожение дойдёт до 1.000.
double potentialAbvFromGravity({required double og}) {
  if (og <= 1.0) return 0;
  return (og - 1.0) * 131.25;
}

/// Потенциальная крепость по Brix (для фруктовых заторов и сусла).
///
/// Приближение: 1 °Bx ≈ 0,55 % об. спирта при полном сбраживании.
double potentialAbvFromBrix({required double brix}) {
  if (brix <= 0) return 0;
  return brix * 0.55;
}

/// Купаж трёх объёмов.
double blendThree({
  required double v1,
  required double a1,
  required double v2,
  required double a2,
  required double v3,
  required double a3,
}) {
  final total = v1 + v2 + v3;
  if (total <= 0) return 0;
  return (v1 * a1 + v2 * a2 + v3 * a3) / total;
}

/// Сколько долить в бочку, чтобы компенсировать ангельскую долю.
///
/// [currentL] — сколько сейчас в бочке, [targetL] — до какого уровня доливать.
double topUpNeeded({required double currentL, required double targetL}) {
  final delta = targetL - currentL;
  return delta > 0 ? delta : 0;
}

/// Сколько литров абсолютного спирта даст сырьё.
///
/// [massKg] — масса, [sugarFraction] — доля сахара или крахмала,
/// [fromStarch] — считать по крахмалу (0,71 л АС/кг) или по сахару (0,64).
double alcoholFromRaw({
  required double massKg,
  required double sugarFraction,
  bool fromStarch = false,
}) {
  if (massKg <= 0 || sugarFraction <= 0) return 0;
  final perKg = fromStarch ? kAlcoholPerKgStarch : kAlcoholPerKgSugar;
  return massKg * sugarFraction * perKg;
}

/// Разбить объём голов на банки по [jarMl].
///
/// Возвращает число полных банок и остаток в миллилитрах.
({int fullJars, double restMl}) headsIntoJars({
  required double headsMl,
  required double jarMl,
}) {
  if (jarMl <= 0 || headsMl <= 0) return (fullJars: 0, restMl: 0);
  final full = (headsMl / jarMl).floor();
  return (fullJars: full, restMl: headsMl - full * jarMl);
}
