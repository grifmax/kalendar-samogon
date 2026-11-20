import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/domain/calculators.dart';
import 'package:kalendar_samogon/domain/recipe_tuning.dart';
import 'package:kalendar_samogon/domain/reference.dart';

void main() {
  group('Настройка настойки под тару', () {
    test('3 л, 30%, спирт 40%, вишня 300 г/л, сахар 100 г/л', () {
      final t = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 30,
        spiritAbv: 40,
        rawKg: 0.9,
        sugarKg: 0.3,
        rawMaterial: rawMaterialById('cherry'),
      );
      // Сырьё занимает 0,9 × 1,05 = 0,945 л, сахар 0,3 × 0,6 = 0,18 л.
      expect(t.liquidL, closeTo(3 - 0.945 - 0.18, 1e-9));
      // Доля спирта = 30 / 40 = 0,75 от жидкости.
      expect(t.spiritL, closeTo(0.75 * 1.875, 1e-9));
      expect(t.waterL, closeTo(0.25 * 1.875, 1e-9));
      expect(t.fillL, closeTo(3, 1e-9));
      expect(t.fits, isTrue);
      expect(t.actualAbv, closeTo(30, 1e-6));
      expect(t.warnings, isEmpty);
    });

    test('цель равна крепости спирта — вода не нужна', () {
      final t = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 40,
        spiritAbv: 40,
        rawKg: 0.9,
        sugarKg: 0.3,
        rawMaterial: rawMaterialById('cherry'),
      );
      expect(t.spiritL, closeTo(t.liquidL, 1e-9));
      expect(t.waterL, closeTo(0, 1e-9));
      expect(t.actualAbv, closeTo(40, 1e-6));
    });

    test('больше вишни — меньше спирта при той же крепости', () {
      final base = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 40,
        spiritAbv: 40,
        rawKg: 0.9,
        sugarKg: 0.3,
        rawMaterial: rawMaterialById('cherry'),
      );
      final more = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 40,
        spiritAbv: 40,
        rawKg: 1.8,
        sugarKg: 0.3,
        rawMaterial: rawMaterialById('cherry'),
      );
      expect(more.spiritL, lessThan(base.spiritL));
      expect(more.rawGramsPerLitre, closeTo(600, 1e-6));
    });

    test('сырьё не влезает в банку — предупреждение и дефицит', () {
      final t = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 40,
        spiritAbv: 40,
        rawKg: 4.5,
        sugarKg: 0.3,
        rawMaterial: rawMaterialById('cherry'),
      );
      expect(t.fits, isFalse);
      expect(t.deficitL, greaterThan(0));
      expect(t.warnings.any((w) => w.contains('Не влезает')), isTrue);
    });

    test('крепость выше крепости спирта — предупреждение', () {
      final t = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 60,
        spiritAbv: 40,
        rawKg: 0.5,
        sugarKg: 0.2,
        rawMaterial: rawMaterialById('cherry'),
      );
      expect(
        t.warnings.any((w) => w.contains('нужен спирт крепче')),
        isTrue,
      );
      // Спирт упирается в свою крепость, а не в целевую.
      expect(t.spiritL, closeTo(t.liquidL, 1e-9));
    });

    test('доза вне нормы даёт предупреждение', () {
      final t = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 40,
        spiritAbv: 40,
        rawKg: 3.0,
        sugarKg: 0.1,
        rawMaterial: rawMaterialById('cherry'),
      );
      expect(t.rawInRange, isFalse);
      expect(t.warnings.any((w) => w.contains('вне обычной нормы')), isTrue);
    });

    test('без сырья и сахара жидкость занимает всю тару', () {
      final t = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 40,
        spiritAbv: 96,
        rawKg: 0,
        sugarKg: 0,
      );
      expect(t.liquidL, closeTo(3, 1e-9));
      // 40 / 96 от 3 л = 1,25 л спирта.
      expect(t.spiritL, closeTo(1.25, 1e-9));
      expect(t.waterL, closeTo(1.75, 1e-9));
      expect(t.actualAbv, closeTo(40, 1e-6));
    });

    test('выход после фильтрации больше объёма жидкости', () {
      final t = tuneTincture(
        vesselVolumeL: 3,
        targetAbv: 40,
        spiritAbv: 40,
        rawKg: 0.9,
        sugarKg: 0.3,
        rawMaterial: rawMaterialById('cherry'),
      );
      expect(t.estimatedFinalL, greaterThan(t.liquidL));
    });
  });

  group('Настройка браги', () {
    test('5 кг сахара при 1:4 — 20 л воды и 23 л браги', () {
      final t = tuneMash(sugarKg: 5, hydromodule: 4);
      expect(t.waterL, closeTo(20, 1e-9));
      expect(t.totalVolumeL, closeTo(23, 1e-9));
      expect(t.washAbv, closeTo(3 / 23 * 100, 1e-9));
    });

    test('влезает ли в ёмкость', () {
      final t = tuneMash(sugarKg: 5, hydromodule: 4);
      expect(t.fitsIn(25), isTrue);
      expect(t.fitsIn(20), isFalse);
    });

    test('слишком много сахара — предупреждение', () {
      final t = tuneMash(sugarKg: 10, hydromodule: 2.5);
      expect(t.sugarGramsPerLitre, greaterThan(300));
      expect(t.warnings, isNotEmpty);
    });

    test('дополнительное сырьё добавляет сахар', () {
      final plain = tuneMash(sugarKg: 5, hydromodule: 4);
      final withJam = tuneMash(
        sugarKg: 5,
        hydromodule: 4,
        extraRawKg: 2,
        extraRaw: rawMaterialById('jam'),
      );
      expect(withJam.practicalAlcoholL, greaterThan(plain.practicalAlcoholL));
    });

    test('сахар ровно под ёмкость 25 л при 1:4', () {
      final sugar = sugarForVessel(vesselVolumeL: 25, hydromodule: 4);
      expect(sugar, closeTo(25 / 4.6, 1e-9));
      final t = tuneMash(sugarKg: sugar, hydromodule: 4);
      expect(t.totalVolumeL, closeTo(25, 1e-6));
    });
  });

  group('Сахар и крепость', () {
    test('100 г сахара на литр снижают 40% до 37,7%', () {
      final after = abvAfterSugar(volumeL: 1, abv: 40, sugarKg: 0.1);
      expect(after, closeTo(0.4 / 1.06 * 100, 1e-9));
      expect(40 - after, greaterThan(2));
    });

    test('без сахара крепость не меняется', () {
      expect(abvAfterSugar(volumeL: 3, abv: 40, sugarKg: 0), closeTo(40, 1e-9));
    });
  });

  group('Сортировка на объём', () {
    test('1 л 40% из спирта 96% — 0,417 л спирта и 0,583 л воды', () {
      final plan = sortingForVolume(volumeL: 1, targetAbv: 40, spiritAbv: 96);
      expect(plan.spiritL, closeTo(1 * 40 / 96, 1e-9));
      expect(plan.waterL, closeTo(1 - 40 / 96, 1e-9));
    });

    test('цель крепче спирта — упираемся в спирт', () {
      final plan = sortingForVolume(volumeL: 1, targetAbv: 60, spiritAbv: 40);
      expect(plan.spiritL, closeTo(1, 1e-9));
      expect(plan.waterL, closeTo(0, 1e-9));
    });
  });

  group('Укрепление', () {
    test('3 л 25% до 40% спиртом 70% — 1,5 л добавки', () {
      final add = fortifyToTarget(
        volumeL: 3,
        abv: 25,
        targetAbv: 40,
        spiritAbv: 70,
      );
      expect(add, closeTo(1.5, 1e-9));
    });

    test('спирт слабее цели — поднять нельзя', () {
      expect(
        fortifyToTarget(volumeL: 3, abv: 25, targetAbv: 40, spiritAbv: 35),
        0,
      );
    });

    test('крепость уже выше цели — добавка не нужна', () {
      expect(
        fortifyToTarget(volumeL: 3, abv: 50, targetAbv: 40, spiritAbv: 70),
        0,
      );
    });
  });

  group('Температурные поправки', () {
    test('спирт: при 25 °C поправка минус 1,75%', () {
      expect(hydrometerCorrection(reading: 40, tempC: 25), closeTo(38.25, 1e-9));
    });

    test('спирт: при 20 °C поправки нет', () {
      expect(hydrometerCorrection(reading: 40, tempC: 20), closeTo(40, 1e-9));
    });

    test('сусло: при 25 °C плотность занижена, поправка вверх', () {
      expect(washDensityCorrection(sg: 1.040, tempC: 25), greaterThan(1.040));
      expect(washDensityCorrection(sg: 1.040, tempC: 20), closeTo(1.040, 1e-9));
    });

    test('потенциальная крепость по плотности', () {
      expect(potentialAbvFromGravity(og: 1.090), closeTo(11.8125, 1e-6));
      expect(potentialAbvFromGravity(og: 1.0), 0);
    });

    test('потенциальная крепость по Brix', () {
      expect(potentialAbvFromBrix(brix: 20), closeTo(11, 1e-9));
    });
  });

  group('Выход из сырья', () {
    test('10 кг сахара дают 6,4 л АС', () {
      expect(
        alcoholFromRaw(massKg: 10, sugarFraction: 1.0),
        closeTo(6.4, 1e-9),
      );
    });

    test('крахмал считается по 0,71 л АС на кг', () {
      expect(
        alcoholFromRaw(massKg: 10, sugarFraction: 1.0, fromStarch: true),
        closeTo(7.1, 1e-9),
      );
    });

    test('нулевая масса — нулевой выход', () {
      expect(alcoholFromRaw(massKg: 0, sugarFraction: 1), 0);
    });
  });

  group('Головы по банкам', () {
    test('450 мл в 500-мл банку — одна неполная', () {
      final r = headsIntoJars(headsMl: 450, jarMl: 500);
      expect(r.fullJars, 0);
      expect(r.restMl, closeTo(450, 1e-9));
    });

    test('1200 мл в 500-мл банки — две полные и 200 мл', () {
      final r = headsIntoJars(headsMl: 1200, jarMl: 500);
      expect(r.fullJars, 2);
      expect(r.restMl, closeTo(200, 1e-9));
    });
  });

  group('Купаж трёх объёмов', () {
    test('равные объёмы 30/40/50 дают 40', () {
      expect(
        blendThree(v1: 1, a1: 30, v2: 1, a2: 40, v3: 1, a3: 50),
        closeTo(40, 1e-9),
      );
    });
  });

  group('Справочник сырья', () {
    test('вишня: средняя норма 325 г/л', () {
      final cherry = rawMaterialById('cherry');
      expect(cherry, isNotNull);
      expect(cherry!.averageGramsPerLitre, closeTo(325, 1e-9));
    });

    test('доза в норме и вне нормы', () {
      final cherry = rawMaterialById('cherry')!;
      expect(cherry.isInRange(300), isTrue);
      expect(cherry.isInRange(100), isFalse);
      expect(cherry.isInRange(900), isFalse);
    });

    test('сахар: сахаристость почти 100%', () {
      expect(rawMaterialById('sugar')!.sugarFraction, greaterThan(0.99));
    });

    test('подбор сырья по русскому названию', () {
      expect(guessRawMaterial('Вишня')?.id, 'cherry');
      expect(guessRawMaterial('Корень хрена')?.id, 'horseradish');
      expect(guessRawMaterial('Кедровые орехи')?.id, 'pine-nut');
      expect(guessRawMaterial('Сахар')?.id, 'sugar');
      expect(guessRawMaterial('Нечто неизвестное'), isNull);
    });

    test('сладость по содержанию сахара', () {
      expect(SweetnessLevel.bySugar(10)?.id, 'dry');
      expect(SweetnessLevel.bySugar(70)?.id, 'semi-sweet');
      expect(SweetnessLevel.bySugar(250)?.id, 'liqueur');
    });

    test('все id сырья уникальны', () {
      final ids = rawMaterials.map((m) => m.id).toList();
      expect(ids.toSet().length, ids.length);
    });
  });

  group('Подписи заполнения тары', () {
    test('не влезает', () {
      expect(vesselFitLabel(4, 3), contains('Не влезает'));
    });

    test('впритык', () {
      expect(vesselFitLabel(2.9, 3), contains('Впритык'));
    });

    test('есть место', () {
      expect(vesselFitLabel(1.5, 3), contains('Останется место'));
    });
  });
}
