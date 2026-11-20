import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/domain/calculators.dart';

void main() {
  group('Абсолютный спирт', () {
    test('20 л при 40% = 8 л АС', () {
      expect(absoluteAlcohol(volumeL: 20, abv: 40), closeTo(8, 1e-9));
    });

    test('нулевые и отрицательные значения дают 0', () {
      expect(absoluteAlcohol(volumeL: 0, abv: 40), 0);
      expect(absoluteAlcohol(volumeL: 10, abv: -5), 0);
    });
  });

  group('Сахарная брага', () {
    test('5 кг сахара при гидромодуле 1:4 дают 20 л воды', () {
      final plan = sugarWashPlan(sugarKg: 5, hydromodule: 4);
      expect(plan.waterL, closeTo(20, 1e-9));
    });

    test('объём браги учитывает объём растворённого сахара', () {
      final plan = sugarWashPlan(sugarKg: 5, hydromodule: 4);
      expect(plan.totalVolumeL, closeTo(23, 1e-9));
    });

    test('теоретический выход — 0,64 л АС на кг сахара', () {
      final plan = sugarWashPlan(sugarKg: 10, hydromodule: 4);
      expect(plan.theoreticalAlcoholL, closeTo(6.4, 1e-9));
    });

    test('практический выход меньше теоретического', () {
      final plan = sugarWashPlan(sugarKg: 10, hydromodule: 4);
      expect(plan.practicalAlcoholL, lessThan(plan.theoreticalAlcoholL));
    });

    test('нулевой сахар — нулевой план', () {
      final plan = sugarWashPlan(sugarKg: 0, hydromodule: 4);
      expect(plan.waterL, 0);
      expect(plan.totalVolumeL, 0);
    });
  });

  group('Разбавление', () {
    test('5 л 70% до 40% требуют 3,75 л воды', () {
      expect(
        dilutionWater(volumeL: 5, fromAbv: 70, toAbv: 40),
        closeTo(3.75, 1e-9),
      );
    });

    test('итоговый объём 5 л 70% при 40% = 8,75 л', () {
      expect(
        dilutedVolume(volumeL: 5, fromAbv: 70, toAbv: 40),
        closeTo(8.75, 1e-9),
      );
    });

    test('повышение крепости разбавлением невозможно', () {
      expect(dilutionWater(volumeL: 5, fromAbv: 40, toAbv: 70), 0);
    });
  });

  group('Фракции', () {
    test('20 л 25% дают 5 л АС и 0,45 л голов при 9%', () {
      final plan = fractionsPlan(rawVolumeL: 20, rawAbv: 25);
      expect(plan.absoluteAlcoholL, closeTo(5, 1e-9));
      expect(plan.headsL, closeTo(0.45, 1e-9));
    });

    test('сумма фракций равна АС', () {
      final plan = fractionsPlan(rawVolumeL: 20, rawAbv: 25);
      expect(
        plan.headsL + plan.heartsL + plan.tailsL,
        closeTo(plan.absoluteAlcoholL, 1e-9),
      );
    });

    test('для фруктов доля голов выше', () {
      final sugar = fractionsPlan(rawVolumeL: 20, rawAbv: 25, headsPercent: 9);
      final fruit = fractionsPlan(rawVolumeL: 20, rawAbv: 25, headsPercent: 15);
      expect(fruit.headsL, greaterThan(sugar.headsL));
    });
  });

  group('Плотность и крепость', () {
    test('1.090 → 1.010 даёт около 10,5% ABV', () {
      expect(abvFromGravity(og: 1.090, fg: 1.010), closeTo(10.5, 1e-9));
    });

    test('плотность не падает — крепости нет', () {
      expect(abvFromGravity(og: 1.010, fg: 1.090), 0);
    });
  });

  group('Поправка ареометра', () {
    test('при 20 °C поправки нет', () {
      expect(hydrometerCorrection(reading: 40, tempC: 20), closeTo(40, 1e-9));
    });

    test('при 25 °C показания завышены — поправка вниз', () {
      expect(hydrometerCorrection(reading: 40, tempC: 25), lessThan(40));
    });
  });

  group('Купаж', () {
    test('равные объёмы 40% и 60% дают 50%', () {
      expect(
        blendAbv(volume1L: 5, abv1: 40, volume2L: 5, abv2: 60),
        closeTo(50, 1e-9),
      );
    });

    test('пустой купаж даёт 0', () {
      expect(blendAbv(volume1L: 0, abv1: 40, volume2L: 0, abv2: 60), 0);
    });
  });

  group('Щепа и бочка', () {
    test('3 л на 3 месяца — десятки граммов щепы', () {
      final grams = chipsEquivalentGrams(volumeL: 3, months: 3);
      expect(grams, greaterThan(5));
      expect(grams, lessThan(40));
    });

    test('ангельская доля при 3%/год за год ≈ 3% объёма', () {
      final loss = angelShareLoss(volumeL: 100, months: 12, annualPercent: 3);
      expect(loss, closeTo(3, 1e-6));
    });

    test('за полгода потери меньше, чем за год', () {
      final half = angelShareLoss(volumeL: 100, months: 6, annualPercent: 3);
      final year = angelShareLoss(volumeL: 100, months: 12, annualPercent: 3);
      expect(half, lessThan(year));
    });
  });

  group('Масштабирование', () {
    test('рецепт на 20 л под 25 л — коэффициент 1,25', () {
      expect(
        scaleFactor(recipeVolumeL: 20, myVolumeL: 25),
        closeTo(1.25, 1e-9),
      );
    });

    test('некорректные объёмы не ломают расчёт', () {
      expect(scaleFactor(recipeVolumeL: 0, myVolumeL: 25), 1);
    });
  });

  group('Себестоимость', () {
    test('1000 ₽ на 10 л 40% — 250 ₽ за литр АС', () {
      expect(
        costPerLiterOfAlcohol(totalCost: 1000, volumeL: 10, abv: 40),
        closeTo(250, 1e-9),
      );
    });
  });
}
