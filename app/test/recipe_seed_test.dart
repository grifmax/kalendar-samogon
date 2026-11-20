import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/domain/recipe_seed.dart';
import 'package:kalendar_samogon/domain/recipe_tuning.dart';
import 'package:kalendar_samogon/domain/reference.dart';

/// Все встроенные рецепты из assets/recipes.json.
List<Map<String, dynamic>> loadRecipes() {
  final raw = File('assets/recipes.json').readAsStringSync();
  final data = jsonDecode(raw) as Map<String, dynamic>;
  return (data['recipes'] as List).cast<Map<String, dynamic>>();
}

RecipeSeed seedOf(Map<String, dynamic> recipe) => seedFromRecipe(
  kind: recipe['kind'] as String,
  baseVolumeL: (recipe['baseVolumeL'] as num?)?.toDouble() ?? 0,
  expectedAbv: (recipe['expectedAbv'] as num?)?.toDouble() ?? 0,
  ingredients: [
    for (final ing in (recipe['ingredients'] as List).cast<Map<String, dynamic>>())
      SeedIngredient(
        name: ing['name'] as String,
        amount: (ing['amount'] as num).toDouble(),
        unit: ing['unit'] as String,
      ),
  ],
);

Map<String, dynamic> recipeById(String id) =>
    loadRecipes().firstWhere((r) => r['id'] == id);

void main() {
  group('seedFromRecipe', () {
    test('брага: сахар и гидромодуль берутся из состава', () {
      final seed = seedOf(recipeById('sugar-classic'));

      expect(seed.mode, TuningMode.mash);
      // Объём тары — с учётом объёма сахара и запаса на пену:
      // 20 л воды + 5 кг сахара = 23 л, плюс 10 %.
      expect(seed.vesselL, 26);
      // 5 кг сахара и 20 л воды в рецепте.
      expect(seed.sugarKg, closeTo(5, 0.001));
      expect(seed.hydromodule, closeTo(4.0, 0.001));
      // Дрожжи, подкормка и кислота переносятся в партию как есть.
      final names = seed.carried.map((c) => c.name).toList();
      expect(names, contains('Дрожжи спиртовые'));
      expect(names, contains('Подкормка (диаммонийфосфат)'));
      expect(seed.rawMaterial, isNull);
    });

    test('настойка: крепость, сырьё и сахар считаются от объёма рецепта', () {
      final seed = seedOf(recipeById('tinct-vishnevka'));

      expect(seed.mode, TuningMode.tincture);
      expect(seed.vesselL, 3);
      expect(seed.spiritAbv, 45);
      expect(seed.targetAbv, 30);
      // 800 г вишни на 3 л и 200 г сахара на 3 л.
      expect(seed.rawGramsPerLitre, closeTo(266.7, 0.5));
      expect(seed.sugarGramsPerLitre, closeTo(66.7, 0.5));
      expect(seed.rawName, 'Вишня');
      // Вода из рецепта не переносится отдельно — её считает формула.
      expect(seed.carried, isEmpty);
    });

    test('перегонка: режим заливки, а не настойки', () {
      final seed = seedOf(recipeById('distill-sugar'));

      expect(seed.mode, TuningMode.distillate);
      expect(seed.chargeVolumeL, greaterThan(0));
      expect(seed.chargeAbv, greaterThan(0));
      // У перегонки нет «сырья г/л» и «сахара г/л» — иначе форма просит
      // бессмысленные значения.
      expect(seed.rawGramsPerLitre, 0);
      expect(seed.sugarGramsPerLitre, 0);
    });

    test('жидкая заливка без спирта: крепость не выдумывается', () {
      final seed = seedFromRecipe(
        kind: 'distillate',
        baseVolumeL: 20,
        expectedAbv: 0,
        ingredients: const [
          SeedIngredient(name: 'Спирт-сырец', amount: 20, unit: 'л'),
        ],
      );
      expect(seed.mode, TuningMode.distillate);
      expect(seed.chargeAbv, 0);
    });
  });

  group('настройка по значениям рецепта не даёт ложных предупреждений', () {
    test('все встроенные браги и настойки настраиваются без ошибок', () {
      final problems = <String>[];

      for (final recipe in loadRecipes()) {
        final seed = seedOf(recipe);
        final id = recipe['id'] as String;

        switch (seed.mode) {
          case TuningMode.mash:
            final tuning = tuneMash(
              sugarKg: seed.sugarKg,
              hydromodule: seed.hydromodule,
              waterL: seed.waterL,
              extraRawKg: seed.rawGramsPerLitre * seed.vesselL / 1000,
              extraRaw: seed.rawMaterial,
              warnAboutHydromodule:
                  (seed.rawMaterial?.waterFraction ?? 0) < 0.5,
            );
            if (!tuning.fitsIn(seed.vesselL)) {
              problems.add('$id: брага не влезает '
                  '(${tuning.totalVolumeL} л при ${seed.vesselL} л)');
            }
            if (tuning.warnings.isNotEmpty) {
              problems.add('$id: ${tuning.warnings.join('; ')}');
            }
          case TuningMode.tincture:
            final tuning = tuneTincture(
              vesselVolumeL: seed.vesselL,
              targetAbv: seed.targetAbv,
              spiritAbv: seed.spiritAbv,
              rawKg: seed.rawGramsPerLitre * seed.vesselL / 1000,
              sugarKg: seed.sugarGramsPerLitre * seed.vesselL / 1000,
              rawMaterial: seed.rawMaterial,
              warnAboutDose: false,
            );
            if (!tuning.fits) {
              problems.add('$id: закладка не влезает '
                  '(${tuning.fillL} л при ${seed.vesselL} л)');
            }
            if (tuning.warnings.isNotEmpty) {
              problems.add('$id: ${tuning.warnings.join('; ')}');
            }
          case TuningMode.distillate:
            if (seed.chargeAbv > 96) {
              problems.add('$id: крепость заливки ${seed.chargeAbv} %');
            }
        }
      }

      expect(problems, isEmpty, reason: problems.join('\n'));
    });
  });

  group('seedLitres и seedGrams', () {
    test('единицы приводятся к граммам', () {
      expect(seedGrams(5, 'кг'), 5000);
      expect(seedGrams(500, 'г'), 500);
      expect(seedGrams(2, 'л'), 2000);
      expect(seedGrams(250, 'мл'), 250);
    });

    test('единицы приводятся к литрам', () {
      expect(seedLitres(2, 'л'), 2);
      expect(seedLitres(400, 'мл'), 0.4);
      expect(seedLitres(3, 'кг'), 3);
      expect(seedLitres(3, 'шт'), 0);
    });
  });

  test('сырьё для браги из варенья распознаётся как доп. сахар', () {
    final recipe = loadRecipes().firstWhere(
      (r) => r['id'] == 'fruit-jam',
    );
    final seed = seedOf(recipe);
    expect(seed.mode, TuningMode.mash);
    expect(seed.rawMaterial, isNotNull);
    expect(seed.rawMaterial!.sugarFraction, greaterThan(0));
    expect(seed.rawGramsPerLitre, greaterThan(0));
  });

  test('guessRawMaterial находит сырьё по названию', () {
    expect(guessRawMaterial('Вишня')?.title, contains('Вишня'));
    expect(guessRawMaterial('Сахар')?.category, 'sugar');
  });
}
