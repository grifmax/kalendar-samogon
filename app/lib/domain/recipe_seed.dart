import 'reference.dart';

/// Как считается рецепт: у браги, настойки и перегонки разная арифметика.
enum TuningMode {
  /// Сахар, гидромодуль, выход спирта.
  mash,

  /// Крепость = спирт / весь объём; сырьё и сахар вытесняют жидкость.
  tincture,

  /// Перегонка: объём заливки и её крепость, выход АС.
  distillate,
}

/// Ингредиент рецепта в нормализованном виде.
class SeedIngredient {
  const SeedIngredient({
    required this.name,
    required this.amount,
    required this.unit,
  });

  final String name;
  final double amount;
  final String unit;
}

/// Разобранный рецепт: с чего начинать настройку.
///
/// Отсюда берутся стартовые значения формы, поэтому всё считается от реального
/// состава рецепта и его объёма, а не от констант: раньше любая брага
/// открывалась с 5 кг сахара и гидромодулем 4,5, а настойка без сахара —
/// с 50 г/л.
class RecipeSeed {
  const RecipeSeed({
    required this.mode,
    required this.vesselL,
    required this.targetAbv,
    required this.spiritAbv,
    required this.rawGramsPerLitre,
    required this.sugarGramsPerLitre,
    required this.sugarKg,
    required this.hydromodule,
    required this.waterL,
    required this.rawMaterial,
    required this.rawName,
    required this.carried,
    required this.chargeAbv,
    required this.chargeVolumeL,
  });

  final TuningMode mode;

  /// Объём тары (брага, настойка) или заливки в куб (перегонка), л.
  final double vesselL;

  /// Крепость готового напитка / браги / заливки, %.
  final double targetAbv;

  /// Крепость спирта, который заливаем, %.
  final double spiritAbv;

  /// Норма сырья, г/л тары.
  final double rawGramsPerLitre;

  /// Сахар, г/л тары.
  final double sugarGramsPerLitre;

  /// Сахар для браги, кг.
  final double sugarKg;

  /// Вода на сахар для браги (1 : N).
  final double hydromodule;

  /// Вода из рецепта, л (для браги — чтобы понять гидромодуль).
  final double waterL;

  final RawMaterial? rawMaterial;

  /// Название сырья как в рецепте.
  final String? rawName;

  /// Ингредиенты, которые не пересчитываются по формуле, но должны попасть
  /// в партию: дрожжи, подкормка, кислота, травы. Масштабируются по объёму.
  final List<SeedIngredient> carried;

  /// Крепость заливки в куб для перегонки, %.
  final double chargeAbv;

  /// Объём заливки в куб для перегонки, л.
  final double chargeVolumeL;

  bool get isMash => mode == TuningMode.mash;
  bool get isTincture => mode == TuningMode.tincture;
  bool get isDistillate => mode == TuningMode.distillate;
}

/// Слова, которые означают добавку, а не настаиваемое сырьё.
const _additiveWords = [
  'дрожж',
  'подкормк',
  'кислот',
  'фермент',
  'витамин',
  'соль',
  'сода',
  'разрыхлител',
];

/// Граммы из (количество, единица). Неизвестные единицы считаем граммами.
double seedGrams(double amount, String unit) {
  switch (unit.trim().toLowerCase()) {
    case 'кг':
    case 'kg':
      return amount * 1000;
    case 'мг':
      return amount / 1000;
    case 'л':
    case 'l':
      return amount * 1000;
    case 'мл':
    case 'ml':
      return amount;
    default:
      return amount;
  }
}

/// Литры из (количество, единица). Штуки и граммы литрами не считаем.
double seedLitres(double amount, String unit) {
  switch (unit.trim().toLowerCase()) {
    case 'л':
    case 'l':
      return amount;
    case 'мл':
    case 'ml':
      return amount / 1000;
    case 'кг':
    case 'kg':
      // Для воды 1 кг ≈ 1 л; для сахара объём считаем отдельно.
      return amount;
    default:
      return 0;
  }
}

/// Разобрать рецепт в стартовые значения формы настройки.
///
/// [ingredients] — состав рецепта как он есть; вода и спирт распознаются по
/// названию, остальное ищется в справочнике [guessRawMaterial].
RecipeSeed seedFromRecipe({
  required String kind,
  required double baseVolumeL,
  required double expectedAbv,
  required List<SeedIngredient> ingredients,
}) {
  final mode = switch (kind) {
    'mash' => TuningMode.mash,
    'tincture' || 'liqueur' => TuningMode.tincture,
    _ => TuningMode.distillate,
  };

  final vessel = baseVolumeL > 0 ? baseVolumeL : 3.0;

  var sugarGrams = 0.0;
  var waterL = 0.0;
  var spiritL = 0.0;
  var spiritAbv = 0.0;
  RawMaterial? raw;
  String? rawName;
  var rawGrams = 0.0;
  final carried = <SeedIngredient>[];

  for (final ing in ingredients) {
    final name = ing.name.toLowerCase();

    // Добавки проверяем раньше всего: «Дрожжи спиртовые» — не спирт.
    if (_additiveWords.any(name.contains)) {
      carried.add(SeedIngredient(
        name: ing.name,
        amount: ing.amount,
        unit: ing.unit,
      ));
      continue;
    }

    if (name.contains('сахар') && !name.contains('сахарн')) {
      sugarGrams += seedGrams(ing.amount, ing.unit);
      continue;
    }
    if (name.startsWith('вода') || name == 'вода') {
      waterL += seedLitres(ing.amount, ing.unit);
      continue;
    }
    if (name.contains('спирт') ||
        name.contains('сортировк') ||
        name.contains('водка') ||
        name.contains('дистиллят') ||
        name.contains('коньяк') ||
        name.contains('бренди')) {
      spiritL += seedLitres(ing.amount, ing.unit);
      final match = RegExp(r'(\d+[.,]?\d*)\s*%').firstMatch(ing.name);
      if (match != null) {
        spiritAbv = double.parse(match.group(1)!.replaceAll(',', '.'));
      }
      continue;
    }

    // Сырьём считаем только то, что действительно настаивается: дрожжи,
    // подкормка, кислота и соль — это добавки, а не закладка. Штуки в граммы
    // не переводятся, поэтому тоже уходят в перенос.
    final material = mode == TuningMode.distillate
        ? null
        : guessRawMaterial(ing.name);
    final countable = ing.unit.trim().toLowerCase() == 'шт';

    // Для браги «сахарным сырьём» считаем варенье и мёд — они дают и сахар,
    // и объём. Для настойки сахар уже разобран выше отдельным полем.
    final sugarLike = material?.category == 'sugar';
    final allowSugarLike = mode == TuningMode.mash;

    if (material != null &&
        (!sugarLike || allowSugarLike) &&
        !countable) {
      final grams = seedGrams(ing.amount, ing.unit);
      // Из нескольких видов сырья закладкой считаем то, которого больше:
      // вишня 800 г и корица 5 г — настаивается вишня.
      if (grams > rawGrams) {
        raw = material;
        rawName = ing.name;
        rawGrams = grams;
      }
      continue;
    }

    carried.add(SeedIngredient(
      name: ing.name,
      amount: ing.amount,
      unit: ing.unit,
    ));
  }

  final rawGpl = rawGrams > 0 ? rawGrams / vessel : 0.0;
  final sugarGpl = sugarGrams > 0 ? sugarGrams / vessel : 0.0;

  final sugarKg = sugarGrams / 1000;
  // Гидромодуль считаем по всему сахару, включая сахар фруктов и варенья:
  // иначе у вишнёвой браги выходит 1:2,7 и ложное «слишком густо».
  final rawSugarKg = rawGrams / 1000 * (raw?.sugarFraction ?? 0);
  final totalSugarKg = sugarKg + rawSugarKg;
  final hydromodule = totalSugarKg > 0 && waterL > 0
      ? waterL / totalSugarKg
      : (mode == TuningMode.mash ? 4.5 : 0.0);

  // Крепость, которой заливаем: у настойки это спирт из состава, у перегонки —
  // крепость заливки. Если в рецепте спирта нет, берём типовую для типа.
  final fallbackSpiritAbv = switch (mode) {
    TuningMode.mash => 0.0,
    TuningMode.tincture => 40.0,
    TuningMode.distillate => 0.0,
  };

  // Заливка перегонки: объём = спирт + вода из рецепта (если заданы).
  final chargeVolume = spiritL + waterL;
  final chargeAbv = chargeVolume > 0 && spiritAbv > 0
      ? spiritL * spiritAbv / chargeVolume
      : (expectedAbv > 0 ? expectedAbv : 0.0);

  return RecipeSeed(
    mode: mode,
    vesselL: vessel,
    targetAbv: expectedAbv > 0
        ? expectedAbv
        : (kTypicalAbvByKind[kind]?.$1 ?? 40),
    spiritAbv: spiritAbv > 0 ? spiritAbv : fallbackSpiritAbv,
    rawGramsPerLitre: rawGpl > 0 ? rawGpl : (raw?.averageGramsPerLitre ?? 0),
    sugarGramsPerLitre: sugarGpl,
    sugarKg: sugarKg,
    hydromodule: hydromodule,
    waterL: waterL,
    rawMaterial: raw,
    rawName: rawName,
    carried: carried,
    chargeAbv: chargeAbv,
    chargeVolumeL: chargeVolume > 0 ? chargeVolume : vessel,
  );
}
