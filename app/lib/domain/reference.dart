/// Справочные данные: нормы сырья, сахаристость, сладость, типовые крепости.
///
/// Значения — практические средние для домашнего винокурения: нижняя и верхняя
/// граница нормы, содержание сахара и воды в сырье, объём, который занимает
/// килограмм сырья в таре. Используются редактором рецепта, чтобы подсказывать
/// разумные дозы и считать итоговую крепость с учётом разбавления.
library;

/// Сырьё для настоек, ликёров и браг.
class RawMaterial {
  const RawMaterial({
    required this.id,
    required this.title,
    required this.category,
    this.minGramsPerLitre,
    this.maxGramsPerLitre,
    this.sugarFraction = 0,
    this.waterFraction = 0,
    this.volumePerKg = 1.0,
    this.note = '',
  });

  final String id;
  final String title;

  /// tincture | berry | fruit | spice | herb | nut | coffee | grain | starch | sugar
  final String category;

  /// Норма закладки на литр, г. Для настоек и пряностей.
  final double? minGramsPerLitre;
  final double? maxGramsPerLitre;

  /// Доля сахара в сырье (0.10 = 10 %). Для браг — сахаристость.
  final double sugarFraction;

  /// Доля воды в сырье (0.82 = 82 %). Для расчёта объёма, который вытесняет сырьё.
  final double waterFraction;

  /// Сколько литров занимает 1 кг сырья в таре.
  final double volumePerKg;

  final String note;

  /// Средняя норма, г/л.
  double? get averageGramsPerLitre {
    final lo = minGramsPerLitre;
    final hi = maxGramsPerLitre;
    if (lo == null || hi == null) return null;
    return (lo + hi) / 2;
  }

  /// Попадает ли доза в норму.
  bool isInRange(double gramsPerLitre) {
    final lo = minGramsPerLitre;
    final hi = maxGramsPerLitre;
    if (lo == null || hi == null) return true;
    return gramsPerLitre >= lo && gramsPerLitre <= hi;
  }
}

/// Уровни сладости напитка: сахар, г/л.
class SweetnessLevel {
  const SweetnessLevel({
    required this.id,
    required this.title,
    required this.minSugarGramsPerLitre,
    required this.maxSugarGramsPerLitre,
  });

  final String id;
  final String title;
  final double minSugarGramsPerLitre;
  final double maxSugarGramsPerLitre;

  double get averageSugarGramsPerLitre =>
      (minSugarGramsPerLitre + maxSugarGramsPerLitre) / 2;

  static SweetnessLevel? bySugar(double gramsPerLitre) {
    for (final level in sweetnessLevels) {
      if (gramsPerLitre >= level.minSugarGramsPerLitre &&
          gramsPerLitre <= level.maxSugarGramsPerLitre) {
        return level;
      }
    }
    return null;
  }
}

/// Уровни сладости от сухого до ликёра.
const List<SweetnessLevel> sweetnessLevels = [
  SweetnessLevel(
    id: 'dry',
    title: 'Сухое',
    minSugarGramsPerLitre: 0,
    maxSugarGramsPerLitre: 20,
  ),
  SweetnessLevel(
    id: 'semi-dry',
    title: 'Полусухое',
    minSugarGramsPerLitre: 20,
    maxSugarGramsPerLitre: 50,
  ),
  SweetnessLevel(
    id: 'semi-sweet',
    title: 'Полусладкое',
    minSugarGramsPerLitre: 50,
    maxSugarGramsPerLitre: 100,
  ),
  SweetnessLevel(
    id: 'sweet',
    title: 'Сладкое',
    minSugarGramsPerLitre: 100,
    maxSugarGramsPerLitre: 180,
  ),
  SweetnessLevel(
    id: 'liqueur',
    title: 'Ликёр',
    minSugarGramsPerLitre: 180,
    maxSugarGramsPerLitre: 350,
  ),
];

/// Типовые крепости готового напитка по виду рецепта.
const Map<String, (double min, double max)> kTypicalAbvByKind = {
  'tincture': (35, 45),
  'liqueur': (20, 30),
  'distillate': (38, 45),
  'rectification': (40, 96),
  'gin': (37, 47),
  'aging': (55, 65),
};

/// Крепость спирта, которым обычно заливают настойку.
const List<double> kSpiritStrengths = [40, 45, 50, 70, 96];

/// Объём, который занимает 1 кг растворённого сахара, л.
///
/// Сахар при растворении прибавляет примерно 0,6 л на килограмм — это же
/// значение используется при расчёте объёма браги и настойки.
const double kSugarVolumePerKgL = 0.6;

/// Сколько литров абсолютного спирта даёт 1 кг крахмала (теоретически).
///
/// Крахмал → глюкоза (×1,11) → спирт (0,64 л АС/кг) ≈ 0,71 л АС.
const double kAlcoholPerKgStarch = 0.71;

/// Справочник сырья.
const List<RawMaterial> rawMaterials = [
  // ---------- ягоды и фрукты для настоек ----------
  RawMaterial(
    id: 'cherry',
    title: 'Вишня свежая (с косточкой)',
    category: 'berry',
    minGramsPerLitre: 250,
    maxGramsPerLitre: 400,
    sugarFraction: 0.10,
    waterFraction: 0.82,
    volumePerKg: 1.05,
    note: 'Держать дольше 4–6 недель нельзя: косточка даёт горечь и синильную ноту.',
  ),
  RawMaterial(
    id: 'cranberry',
    title: 'Клюква',
    category: 'berry',
    minGramsPerLitre: 200,
    maxGramsPerLitre: 300,
    sugarFraction: 0.035,
    waterFraction: 0.88,
    volumePerKg: 1.0,
    note: 'Кислая ягода: без сахара 100–150 г/л напиток будет резким.',
  ),
  RawMaterial(
    id: 'lingonberry',
    title: 'Брусника',
    category: 'berry',
    minGramsPerLitre: 200,
    maxGramsPerLitre: 300,
    sugarFraction: 0.07,
    waterFraction: 0.86,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'blueberry',
    title: 'Черника',
    category: 'berry',
    minGramsPerLitre: 200,
    maxGramsPerLitre: 300,
    sugarFraction: 0.08,
    waterFraction: 0.85,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'blackcurrant',
    title: 'Смородина чёрная',
    category: 'berry',
    minGramsPerLitre: 200,
    maxGramsPerLitre: 300,
    sugarFraction: 0.08,
    waterFraction: 0.83,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'raspberry',
    title: 'Малина',
    category: 'berry',
    minGramsPerLitre: 250,
    maxGramsPerLitre: 350,
    sugarFraction: 0.06,
    waterFraction: 0.85,
    volumePerKg: 0.9,
  ),
  RawMaterial(
    id: 'sea-buckthorn',
    title: 'Облепиха',
    category: 'berry',
    minGramsPerLitre: 150,
    maxGramsPerLitre: 250,
    sugarFraction: 0.05,
    waterFraction: 0.82,
    volumePerKg: 0.95,
    note: 'Много масел: передержка даёт муть, фильтровать через вату.',
  ),
  RawMaterial(
    id: 'aronia',
    title: 'Черноплодная рябина',
    category: 'berry',
    minGramsPerLitre: 200,
    maxGramsPerLitre: 300,
    sugarFraction: 0.10,
    waterFraction: 0.80,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'plum',
    title: 'Слива',
    category: 'fruit',
    minGramsPerLitre: 300,
    maxGramsPerLitre: 500,
    sugarFraction: 0.09,
    waterFraction: 0.86,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'apple',
    title: 'Яблоко',
    category: 'fruit',
    minGramsPerLitre: 400,
    maxGramsPerLitre: 700,
    sugarFraction: 0.10,
    waterFraction: 0.85,
    volumePerKg: 0.95,
  ),
  RawMaterial(
    id: 'grape',
    title: 'Виноград',
    category: 'fruit',
    minGramsPerLitre: 400,
    maxGramsPerLitre: 700,
    sugarFraction: 0.18,
    waterFraction: 0.80,
    volumePerKg: 1.0,
  ),

  // ---------- цитрус и пряности ----------
  RawMaterial(
    id: 'lemon-zest',
    title: 'Цедра лимона',
    category: 'spice',
    minGramsPerLitre: 40,
    maxGramsPerLitre: 70,
    sugarFraction: 0.02,
    waterFraction: 0.20,
    volumePerKg: 1.2,
    note: 'Только жёлтая часть: белая даёт горечь.',
  ),
  RawMaterial(
    id: 'orange-zest',
    title: 'Цедра апельсина',
    category: 'spice',
    minGramsPerLitre: 40,
    maxGramsPerLitre: 70,
    sugarFraction: 0.02,
    waterFraction: 0.20,
    volumePerKg: 1.2,
  ),
  RawMaterial(
    id: 'horseradish',
    title: 'Корень хрена',
    category: 'spice',
    minGramsPerLitre: 40,
    maxGramsPerLitre: 70,
    sugarFraction: 0.06,
    waterFraction: 0.75,
    volumePerKg: 1.1,
    note: 'Свежий корень жгучее сухого: начинать с нижней границы.',
  ),
  RawMaterial(
    id: 'black-pepper',
    title: 'Перец чёрный горошком',
    category: 'spice',
    minGramsPerLitre: 5,
    maxGramsPerLitre: 15,
    volumePerKg: 1.6,
  ),
  RawMaterial(
    id: 'chili',
    title: 'Перец чили сушёный',
    category: 'spice',
    minGramsPerLitre: 2,
    maxGramsPerLitre: 8,
    volumePerKg: 1.4,
  ),
  RawMaterial(
    id: 'cinnamon',
    title: 'Корица',
    category: 'spice',
    minGramsPerLitre: 5,
    maxGramsPerLitre: 15,
    volumePerKg: 1.3,
  ),
  RawMaterial(
    id: 'clove',
    title: 'Гвоздика',
    category: 'spice',
    minGramsPerLitre: 1,
    maxGramsPerLitre: 3,
    volumePerKg: 1.5,
    note: 'Передержка даёт аптечный тон — не больше 2 недель.',
  ),
  RawMaterial(
    id: 'ginger',
    title: 'Имбирь свежий',
    category: 'spice',
    minGramsPerLitre: 30,
    maxGramsPerLitre: 60,
    sugarFraction: 0.02,
    waterFraction: 0.79,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'vanilla',
    title: 'Ваниль (стручок)',
    category: 'spice',
    minGramsPerLitre: 1,
    maxGramsPerLitre: 3,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'bay-leaf',
    title: 'Лавровый лист',
    category: 'spice',
    minGramsPerLitre: 1,
    maxGramsPerLitre: 3,
    volumePerKg: 1.2,
  ),

  // ---------- травы ----------
  RawMaterial(
    id: 'mint',
    title: 'Мята сушёная',
    category: 'herb',
    minGramsPerLitre: 5,
    maxGramsPerLitre: 15,
    volumePerKg: 2.0,
  ),
  RawMaterial(
    id: 'thyme',
    title: 'Чабрец',
    category: 'herb',
    minGramsPerLitre: 5,
    maxGramsPerLitre: 15,
    volumePerKg: 2.0,
  ),
  RawMaterial(
    id: 'wormwood',
    title: 'Полынь',
    category: 'herb',
    minGramsPerLitre: 2,
    maxGramsPerLitre: 5,
    volumePerKg: 2.2,
    note: 'Очень горькая: превышение делает напиток непригодным.',
  ),
  RawMaterial(
    id: 'st-johns-wort',
    title: 'Зверобой',
    category: 'herb',
    minGramsPerLitre: 10,
    maxGramsPerLitre: 20,
    volumePerKg: 2.0,
  ),
  RawMaterial(
    id: 'oregano',
    title: 'Душица',
    category: 'herb',
    minGramsPerLitre: 5,
    maxGramsPerLitre: 15,
    volumePerKg: 2.0,
  ),

  // ---------- орехи и кофе ----------
  RawMaterial(
    id: 'pine-nut',
    title: 'Кедровый орех',
    category: 'nut',
    minGramsPerLitre: 80,
    maxGramsPerLitre: 150,
    sugarFraction: 0.03,
    waterFraction: 0.03,
    volumePerKg: 0.9,
    note: 'Масла мутят настойку — фильтровать через вату.',
  ),
  RawMaterial(
    id: 'walnut-green',
    title: 'Грецкий орех зелёный',
    category: 'nut',
    minGramsPerLitre: 100,
    maxGramsPerLitre: 200,
    sugarFraction: 0.03,
    waterFraction: 0.75,
    volumePerKg: 1.0,
  ),
  RawMaterial(
    id: 'hazelnut',
    title: 'Фундук',
    category: 'nut',
    minGramsPerLitre: 100,
    maxGramsPerLitre: 180,
    sugarFraction: 0.04,
    waterFraction: 0.05,
    volumePerKg: 0.95,
  ),
  RawMaterial(
    id: 'coffee-bean',
    title: 'Кофе в зёрнах',
    category: 'coffee',
    minGramsPerLitre: 40,
    maxGramsPerLitre: 80,
    volumePerKg: 0.9,
    note: 'Молотый даёт горечь — только целые зёрна.',
  ),

  // ---------- брага: сахаристое сырьё ----------
  RawMaterial(
    id: 'sugar',
    title: 'Сахар',
    category: 'sugar',
    sugarFraction: 0.999,
    waterFraction: 0.001,
    volumePerKg: 0.6,
    note: 'Теоретический выход 0,64 л АС/кг, практический 0,60.',
  ),
  RawMaterial(
    id: 'honey',
    title: 'Мёд',
    category: 'sugar',
    sugarFraction: 0.80,
    waterFraction: 0.17,
    volumePerKg: 0.7,
    note: 'Бродит медленно, нужна подкормка.',
  ),
  RawMaterial(
    id: 'jam',
    title: 'Варенье',
    category: 'sugar',
    sugarFraction: 0.55,
    waterFraction: 0.44,
    volumePerKg: 0.75,
    note: 'Сахаристость сильно разная: считать по этикетке, если есть.',
  ),
  RawMaterial(
    id: 'molasses',
    title: 'Меласса',
    category: 'sugar',
    sugarFraction: 0.50,
    waterFraction: 0.25,
    volumePerKg: 0.8,
  ),
  RawMaterial(
    id: 'potato',
    title: 'Картофель (крахмал 18 %)',
    category: 'starch',
    sugarFraction: 0.18,
    waterFraction: 0.78,
    volumePerKg: 0.75,
    note: 'Крахмал пересчитывается в спирт с коэффициентом 0,71 л АС/кг.',
  ),
  RawMaterial(
    id: 'corn',
    title: 'Кукуруза (крахмал 68 %)',
    category: 'grain',
    sugarFraction: 0.68,
    waterFraction: 0.13,
    volumePerKg: 0.8,
  ),
  RawMaterial(
    id: 'wheat',
    title: 'Пшеница (крахмал 62 %)',
    category: 'grain',
    sugarFraction: 0.62,
    waterFraction: 0.13,
    volumePerKg: 0.8,
  ),
  RawMaterial(
    id: 'rye',
    title: 'Рожь (крахмал 58 %)',
    category: 'grain',
    sugarFraction: 0.58,
    waterFraction: 0.14,
    volumePerKg: 0.8,
  ),
  RawMaterial(
    id: 'barley-malt',
    title: 'Солод ячменный (крахмал 62 %)',
    category: 'grain',
    sugarFraction: 0.62,
    waterFraction: 0.06,
    volumePerKg: 0.7,
  ),
  // ---------- ягоды и фрукты, которых не хватало ----------
  RawMaterial(
    id: 'pear',
    title: 'Груша',
    category: 'fruit',
    sugarFraction: 0.10,
    waterFraction: 0.84,
    volumePerKg: 0.85,
    note: 'Сок даёт мало кислоты — добавьте лимонную, иначе брага пресная.',
  ),
  RawMaterial(
    id: 'apricot',
    title: 'Абрикос',
    category: 'fruit',
    sugarFraction: 0.08,
    waterFraction: 0.86,
    volumePerKg: 0.95,
    note: 'Косточку не дробить: горький миндальный тон перебивает фрукт.',
  ),
  RawMaterial(
    id: 'strawberry',
    title: 'Клубника',
    category: 'berry',
    sugarFraction: 0.07,
    waterFraction: 0.90,
    volumePerKg: 0.95,
    note: 'Аромат уходит при кипении — только холодный способ или настойка.',
  ),
  RawMaterial(
    id: 'blackberry',
    title: 'Ежевика',
    category: 'berry',
    sugarFraction: 0.08,
    waterFraction: 0.88,
    volumePerKg: 0.95,
    note: 'Даёт плотный цвет и терпкость, хорошо в купаже с яблоком.',
  ),
  RawMaterial(
    id: 'pomegranate',
    title: 'Гранат',
    category: 'fruit',
    sugarFraction: 0.12,
    waterFraction: 0.80,
    volumePerKg: 1.0,
    note: 'Кислый: сахара нужно больше обычного, иначе напиток «сводит».',
  ),
  RawMaterial(
    id: 'barberry',
    title: 'Барбарис',
    category: 'berry',
    sugarFraction: 0.06,
    waterFraction: 0.20,
    volumePerKg: 0.7,
    note: 'Сушёный. Кислота сильная — 30–60 г/л достаточно.',
  ),
  RawMaterial(
    id: 'rosehip',
    title: 'Шиповник',
    category: 'berry',
    sugarFraction: 0.05,
    waterFraction: 0.18,
    volumePerKg: 0.7,
    note: 'Сушёный. Много витамина C, вкус травянисто-кислый.',
  ),
  RawMaterial(
    id: 'bird-cherry',
    title: 'Черёмуха',
    category: 'berry',
    sugarFraction: 0.08,
    waterFraction: 0.20,
    volumePerKg: 0.7,
    note: 'Сушёная. Миндальный тон; передержка даёт горечь.',
  ),
  RawMaterial(
    id: 'raisin',
    title: 'Изюм',
    category: 'fruit',
    sugarFraction: 0.65,
    waterFraction: 0.15,
    volumePerKg: 0.7,
    note: 'Сахар почти как у мёда, но с винной кислотой.',
  ),
  RawMaterial(
    id: 'rice',
    title: 'Рис',
    category: 'grain',
    sugarFraction: 0.70,
    waterFraction: 0.13,
    volumePerKg: 0.75,
    note: 'Крахмал: без осахаривания ферментами или солодом не забродит.',
  ),
  RawMaterial(
    id: 'condensed-milk',
    title: 'Сгущённое молоко',
    category: 'sugar',
    sugarFraction: 0.45,
    waterFraction: 0.27,
    volumePerKg: 0.9,
    note: 'Сахара много, но и жира: в ликёре даёт плотность и «сливочность».',
  ),

  RawMaterial(
    id: 'beet',
    title: 'Сахарная свёкла',
    category: 'grain',
    sugarFraction: 0.16,
    waterFraction: 0.78,
    volumePerKg: 0.80,
    note: 'Сахаристость 14–18 %: без осахаривания крахмала не нужно, но '
        'варить и отжимать обязательно.',
  ),
  RawMaterial(
    id: 'dextrose',
    title: 'Декстроза',
    category: 'sugar',
    sugarFraction: 0.90,
    waterFraction: 0.09,
    volumePerKg: 0.65,
    note: 'Виноградный сахар: бродит чище сахарозы, без «свекольной» ноты.',
  ),

  // ---------- пряности и травы ----------
  RawMaterial(
    id: 'juniper',
    title: 'Можжевельник',
    category: 'spice',
    minGramsPerLitre: 8,
    maxGramsPerLitre: 20,
    sugarFraction: 0.05,
    volumePerKg: 0.6,
    note: 'Основа джина. Дробленые ягоды отдают смолу быстрее.',
  ),
  RawMaterial(
    id: 'coriander',
    title: 'Кориандр',
    category: 'spice',
    minGramsPerLitre: 2,
    maxGramsPerLitre: 6,
    volumePerKg: 0.6,
    note: 'Цитрусовая нота джина; передержка даёт мыльный привкус.',
  ),
  RawMaterial(
    id: 'angelica',
    title: 'Корень дягиля',
    category: 'herb',
    minGramsPerLitre: 1,
    maxGramsPerLitre: 3,
    volumePerKg: 0.7,
    note: 'Сухой корень: землистая нота, «скелет» джина.',
  ),
  RawMaterial(
    id: 'orris',
    title: 'Корень ириса',
    category: 'herb',
    minGramsPerLitre: 0.5,
    maxGramsPerLitre: 2,
    volumePerKg: 0.7,
    note: 'Фиксатор аромата, добавляют щепотку.',
  ),
  RawMaterial(
    id: 'anise',
    title: 'Анис',
    category: 'spice',
    minGramsPerLitre: 1,
    maxGramsPerLitre: 4,
    volumePerKg: 0.6,
    note: 'Сладковатый «аптечный» тон; сильный, легко перебить всё.',
  ),
  RawMaterial(
    id: 'cumin',
    title: 'Тмин',
    category: 'spice',
    minGramsPerLitre: 1,
    maxGramsPerLitre: 3,
    volumePerKg: 0.6,
    note: 'Хлебный, чуть горький; хорошо в паре с кориандром.',
  ),
  RawMaterial(
    id: 'fennel',
    title: 'Фенхель',
    category: 'spice',
    minGramsPerLitre: 1,
    maxGramsPerLitre: 3,
    volumePerKg: 0.6,
    note: 'Мягче аниса, даёт «конфетный» оттенок.',
  ),
  RawMaterial(
    id: 'cardamom',
    title: 'Кардамон',
    category: 'spice',
    minGramsPerLitre: 0.5,
    maxGramsPerLitre: 2,
    volumePerKg: 0.6,
    note: 'Зелёные коробочки, не молоть: пыль даёт горечь.',
  ),
  RawMaterial(
    id: 'lavender',
    title: 'Лаванда',
    category: 'herb',
    minGramsPerLitre: 0.5,
    maxGramsPerLitre: 2,
    volumePerKg: 0.5,
    note: 'Половина чайной ложки на литр; больше — мыло.',
  ),
  RawMaterial(
    id: 'bison-grass',
    title: 'Зубровка',
    category: 'herb',
    minGramsPerLitre: 3,
    maxGramsPerLitre: 8,
    volumePerKg: 0.5,
    note: 'Свежая трава пахнет сильнее сушёной; настаивать 3–5 дней.',
  ),
  RawMaterial(
    id: 'valerian',
    title: 'Корень валерианы',
    category: 'herb',
    minGramsPerLitre: 0.5,
    maxGramsPerLitre: 2,
    volumePerKg: 0.7,
    note: 'Очень сильный запах, буквально граммы.',
  ),
  RawMaterial(
    id: 'cocoa',
    title: 'Какао',
    category: 'coffee',
    minGramsPerLitre: 20,
    maxGramsPerLitre: 60,
    volumePerKg: 0.8,
    note: 'Порошок даёт муть — фильтровать через несколько слоёв.',
  ),
  RawMaterial(
    id: 'grapefruit-zest',
    title: 'Цедра грейпфрута',
    category: 'fruit',
    minGramsPerLitre: 10,
    maxGramsPerLitre: 30,
    volumePerKg: 0.7,
    note: 'Горькая нотка, хороша в джине и в биттерах.',
  ),
  RawMaterial(
    id: 'oak-chips',
    title: 'Дубовая щепа',
    category: 'spice',
    minGramsPerLitre: 2,
    maxGramsPerLitre: 10,
    volumePerKg: 0.7,
    note: 'Лёгкий, средний и сильный обжиг дают разный вкус. Дольше двух '
        'месяцев держать нельзя: появляется «доска».',
  ),
  RawMaterial(
    id: 'activated-carbon',
    title: 'Уголь активированный',
    category: 'spice',
    volumePerKg: 0.8,
    note: 'БАУ-А для чистки сортировки: 3–5 г/л, настаивать 1–2 часа.',
  ),

];

/// Найти сырьё по id.
RawMaterial? rawMaterialById(String id) {
  for (final material in rawMaterials) {
    if (material.id == id) return material;
  }
  return null;
}

/// Подобрать сырьё по названию из рецепта: ищем по вхождению ключевого слова.
///
/// В рецептах названия пишутся по-русски («Вишня», «Корень хрена»), а справочник
/// хранит id и полные названия — поэтому сопоставление идёт по подстрокам.
RawMaterial? guessRawMaterial(String name) {
  final lower = name.toLowerCase();
  const keywords = <String, List<String>>{
    'cherry': ['вишн'],
    'cranberry': ['клюкв'],
    'lingonberry': ['брусник'],
    'blueberry': ['черник'],
    'blackcurrant': ['смородин'],
    'raspberry': ['малин'],
    'sea-buckthorn': ['облепих'],
    'aronia': ['черноплод', 'арония', 'рябин'],
    'plum': ['слив'],
    'apple': ['яблок'],
    'grape': ['виноград'],
    'lemon-zest': ['цедра лимон', 'лимон'],
    'orange-zest': ['цедра апельсин', 'апельсин'],
    'horseradish': ['хрен'],
    'black-pepper': ['перец'],
    'chili': ['чили'],
    'cinnamon': ['кориц'],
    'clove': ['гвоздик'],
    'ginger': ['имбир'],
    'vanilla': ['ванил'],
    'bay-leaf': ['лавров'],
    'mint': ['мят'],
    'thyme': ['чабрец', 'тимьян'],
    'wormwood': ['полын'],
    'st-johns-wort': ['зверобой'],
    'oregano': ['душиц'],
    'pine-nut': ['кедров'],
    'walnut-green': ['грецк'],
    'hazelnut': ['фундук', 'лесн'],
    'coffee-bean': ['кофе'],
    'sugar': ['сахар'],
    'honey': ['мёд', 'мед '],
    'jam': ['варень'],
    'molasses': ['меласс'],
    'potato': ['картоф'],
    'corn': ['кукуруз'],
    'wheat': ['пшениц'],
    'rye': ['рожь', 'ржан'],
    'barley-malt': ['солод'],
    'pear': ['груш'],
    'apricot': ['абрикос'],
    'strawberry': ['клубник', 'земляник'],
    'blackberry': ['ежевик'],
    'pomegranate': ['гранат'],
    'barberry': ['барбарис'],
    'rosehip': ['шиповник'],
    'bird-cherry': ['черёмух', 'черемух'],
    'raisin': ['изюм'],
    'rice': ['рис '],
    'condensed-milk': ['сгущён', 'сгущен'],
    'juniper': ['можжевел'],
    'coriander': ['кориандр'],
    'angelica': ['дягил'],
    'orris': ['корень ирис'],
    'anise': ['анис'],
    'cumin': ['тмин'],
    'fennel': ['фенхел'],
    'cardamom': ['кардамон'],
    'lavender': ['лаванд'],
    'bison-grass': ['зубровк'],
    'valerian': ['валериан'],
    'cocoa': ['какао'],
    'grapefruit-zest': ['грейпфрут'],
    'oak-chips': ['щепа', 'клёпк', 'клепк'],
    'activated-carbon': ['уголь'],
    'beet': ['свёкл', 'свекл'],
    'dextrose': ['декстроз'],
  };
  // Сначала ищем конкретное сырьё: «Сахарная свёкла» и «Декстроза» содержат
  // слово «сахар», но это не сахар, и путать их нельзя.
  for (final entry in keywords.entries) {
    if (entry.key == 'sugar') continue;
    for (final word in entry.value) {
      if (lower.contains(word)) return rawMaterialById(entry.key);
    }
  }
  for (final word in keywords['sugar']!) {
    if (lower.contains(word)) return rawMaterialById('sugar');
  }
  return null;
}
