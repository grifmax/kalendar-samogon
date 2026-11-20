import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/db/app_database.dart';
import '../../domain/reference.dart';
import '../../domain/recipe_tuning.dart';
import '../../utils/format.dart';
import '../../widgets/form_fields.dart';

/// Итог настройки рецепта: что реально заложить в партию.
class TuningResult {
  const TuningResult({
    required this.startedAt,
    required this.volumeL,
    required this.ingredients,
    required this.notes,
    required this.summary,
  });

  final DateTime startedAt;
  final double volumeL;
  final List<({String name, double amount, String unit, String note})>
  ingredients;
  final String notes;

  /// Человекочитаемое описание настроек для заметки партии.
  final String summary;
}

/// Начальные значения для редактора — берутся из рецепта.
class TuningSeed {
  const TuningSeed({
    required this.vesselL,
    required this.targetAbv,
    required this.spiritAbv,
    required this.rawGramsPerLitre,
    required this.sugarGramsPerLitre,
    required this.rawMaterial,
    required this.isMash,
    required this.hydromodule,
  });

  final double vesselL;
  final double targetAbv;
  final double spiritAbv;
  final double rawGramsPerLitre;
  final double sugarGramsPerLitre;
  final RawMaterial? rawMaterial;
  final bool isMash;
  final double hydromodule;

  /// Разобрать рецепт: найти спирт, сырьё, сахар и посчитать дозы.
  static TuningSeed fromRecipe(
    Recipe recipe,
    List<RecipeIngredient> ingredients,
  ) {
    final isMash = recipe.kind == 'mash';
    final vessel = recipe.baseVolumeL > 0 ? recipe.baseVolumeL : 3.0;

    var spiritAbv = 40.0;
    var sugarG = 0.0;
    var rawG = 0.0;
    RawMaterial? raw;
    var hydromodule = 4.5;

    for (final ing in ingredients) {
      final name = ing.name.toLowerCase();

      if (name.contains('спирт')) {
        final match = RegExp(r'(\d+)').firstMatch(ing.name);
        if (match != null) spiritAbv = double.parse(match.group(1)!);
      } else if (name.contains('сахар')) {
        sugarG = ing.unit == 'г' ? ing.amount : ing.amount * 1000;
      } else if (name.contains('вода')) {
        // вода в рецепте не задаёт дозу — её считаем сами
      } else {
        final material = guessRawMaterial(ing.name);
        if (material != null && material.category != 'sugar') {
          raw = material;
          rawG = ing.unit == 'г' ? ing.amount : ing.amount * 1000;
        }
      }
    }

    final effectiveVessel = vessel > 0 ? vessel : 3.0;
    final rawGpl = rawG > 0 ? rawG / effectiveVessel : 0.0;
    final sugarGpl = sugarG > 0 ? sugarG / effectiveVessel : 0.0;

    return TuningSeed(
      vesselL: effectiveVessel,
      targetAbv: recipe.expectedAbv > 0
          ? recipe.expectedAbv
          : (kTypicalAbvByKind[recipe.kind]?.$1 ?? 40),
      spiritAbv: spiritAbv,
      rawGramsPerLitre: rawGpl > 0 ? rawGpl : (raw?.averageGramsPerLitre ?? 0),
      sugarGramsPerLitre: sugarGpl,
      rawMaterial: raw,
      isMash: isMash,
      hydromodule: hydromodule,
    );
  }
}

/// Редактор рецепта перед запуском партии.
///
/// Один экран закрывает два сценария: «запустить как есть» и «подкрутить под
/// себя» — больше сырья, крепче, в другую тару. Расчёт живой: меняешь сырьё —
/// видишь, сколько останется спирта и влезет ли в банку.
class RecipeTuneSheet extends StatefulWidget {
  const RecipeTuneSheet({
    super.key,
    required this.recipe,
    required this.ingredients,
    required this.seed,
  });

  final Recipe recipe;
  final List<RecipeIngredient> ingredients;
  final TuningSeed seed;

  @override
  State<RecipeTuneSheet> createState() => _RecipeTuneSheetState();
}

class _RecipeTuneSheetState extends State<RecipeTuneSheet> {
  static const _vesselPresets = [0.5, 1.0, 3.0, 5.0, 10.0, 20.0];

  late final TextEditingController _vessel;
  late final TextEditingController _abv;
  late final TextEditingController _spiritAbv;
  late final TextEditingController _rawGpl;
  late final TextEditingController _sugarGpl;
  late final TextEditingController _sugarKg;
  late final TextEditingController _hydro;
  late final TextEditingController _notes;

  late DateTime _startedAt;
  late double _spiritAbvValue;

  @override
  void initState() {
    super.initState();
    final s = widget.seed;
    _vessel = TextEditingController(text: formatNumber(s.vesselL));
    _abv = TextEditingController(text: formatNumber(s.targetAbv, decimals: 0));
    _spiritAbv = TextEditingController(
      text: formatNumber(s.spiritAbv, decimals: 0),
    );
    _rawGpl = TextEditingController(
      text: s.rawGramsPerLitre > 0
          ? formatNumber(s.rawGramsPerLitre, decimals: 0)
          : '',
    );
    _sugarGpl = TextEditingController(
      text: s.sugarGramsPerLitre > 0
          ? formatNumber(s.sugarGramsPerLitre, decimals: 0)
          : '50',
    );
    _sugarKg = TextEditingController(text: '5');
    _hydro = TextEditingController(text: formatNumber(s.hydromodule));
    _notes = TextEditingController();
    _startedAt = DateTime.now();
    _spiritAbvValue = s.spiritAbv;
  }

  @override
  void dispose() {
    for (final c in [
      _vessel,
      _abv,
      _spiritAbv,
      _rawGpl,
      _sugarGpl,
      _sugarKg,
      _hydro,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  double _v(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '.')) ?? 0;

  /// Подсказка под полем сырья: обычная норма закладки.
  String? _rawHint() {
    final material = widget.seed.rawMaterial;
    if (material == null) return null;
    final lo = material.minGramsPerLitre?.round();
    final hi = material.maxGramsPerLitre?.round();
    if (lo == null || hi == null) return null;
    return material.isInRange(_v(_rawGpl))
        ? 'В норме: обычно $lo–$hi г/л'
        : 'Вне нормы: обычно $lo–$hi г/л';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMash = widget.seed.isMash;
    final vesselL = _v(_vessel);

    return Scaffold(
      appBar: AppBar(
        title: Text(isMash ? 'Настроить брагу' : 'Настроить рецепт'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          Text(widget.recipe.title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            isMash
                ? 'Сахар, вода и объём браги считаются вместе: меняете сахар — '
                      'меняется вода и выход.'
                : 'Крепость готового напитка — это спирт, делённый на весь '
                      'объём. Сырьё и сахар занимают место и «съедают» крепость.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: FormSpacing.section),

          // ---------- тара ----------
          FormSectionTitle(
            title: 'Тара',
            hint: isMash ? 'Объём бродильной ёмкости' : 'Куда закладываем',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final preset in _vesselPresets)
                ChoiceChip(
                  label: Text(formatVolume(preset)),
                  selected: (vesselL - preset).abs() < 0.01,
                  onSelected: (_) {
                    _vessel.text = formatNumber(preset);
                    setState(() {});
                  },
                ),
            ],
          ),
          const SizedBox(height: FormSpacing.chipsToField),
          FormNumberField(
            controller: _vessel,
            label: 'Свой объём',
            suffix: 'л',
            onChanged: () => setState(() {}),
          ),

          if (isMash) ...[
            const SizedBox(height: FormSpacing.sectionAfterField),
            const FormSectionTitle(title: 'Сахар', hint: 'Сколько кладём'),
            FormNumberField(
              controller: _sugarKg,
              label: 'Сахар',
              suffix: 'кг',
              onChanged: () => setState(() {}),
            ),
            FormNumberField(
              controller: _hydro,
              label: 'Гидромодуль (1 к N)',
              suffix: 'N',
              onChanged: () => setState(() {}),
            ),
            const SizedBox(height: FormSpacing.fieldToHint),
            _MashResult(
              vesselL: vesselL,
              sugarKg: _v(_sugarKg),
              hydromodule: _v(_hydro),
            ),
          ] else ...[
            const SizedBox(height: FormSpacing.sectionAfterField),
            const FormSectionTitle(
              title: 'Крепость',
              hint: 'Какой напиток хотите получить',
            ),
            FormNumberField(
              controller: _abv,
              label: 'Крепость напитка',
              suffix: '%',
              onChanged: () => setState(() {}),
            ),

            const SizedBox(height: FormSpacing.sectionAfterField),
            const FormSectionTitle(
              title: 'Чем заливаем',
              hint: 'Крепость спирта или сортировки',
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final strength in kSpiritStrengths)
                  ChoiceChip(
                    label: Text('${strength.round()}%'),
                    selected: (_spiritAbvValue - strength).abs() < 0.01,
                    onSelected: (_) {
                      _spiritAbvValue = strength;
                      _spiritAbv.text = strength.round().toString();
                      setState(() {});
                    },
                  ),
              ],
            ),
            const SizedBox(height: FormSpacing.chipsToField),
            FormNumberField(
              controller: _spiritAbv,
              label: 'Своя крепость спирта',
              suffix: '%',
              onChanged: () => setState(() => _spiritAbvValue = _v(_spiritAbv)),
            ),

            const SizedBox(height: FormSpacing.sectionAfterField),
            FormSectionTitle(
              title: widget.seed.rawMaterial?.title ?? 'Сырьё',
              hint: widget.seed.rawMaterial?.note,
            ),
            FormNumberField(
              controller: _rawGpl,
              label: 'Сырьё',
              suffix: 'г/л',
              onChanged: () => setState(() {}),
              hint: _rawHint(),
              hintIcon:
                  widget.seed.rawMaterial != null &&
                      !widget.seed.rawMaterial!.isInRange(_v(_rawGpl))
                  ? Icons.info_outline
                  : Icons.check_circle_outline,
              hintIsWarning:
                  widget.seed.rawMaterial != null &&
                  !widget.seed.rawMaterial!.isInRange(_v(_rawGpl)),
            ),

            const SizedBox(height: FormSpacing.sectionAfterField),
            const FormSectionTitle(
              title: 'Сахар',
              hint: 'Сладость и её влияние на крепость',
            ),
            FormNumberField(
              controller: _sugarGpl,
              label: 'Сахар',
              suffix: 'г/л',
              onChanged: () => setState(() {}),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final level in sweetnessLevels)
                  ChoiceChip(
                    label: Text(level.title),
                    selected:
                        (SweetnessLevel.bySugar(_v(_sugarGpl))?.id ?? '') ==
                        level.id,
                    onSelected: (_) {
                      _sugarGpl.text = level.averageSugarGramsPerLitre
                          .round()
                          .toString();
                      setState(() {});
                    },
                  ),
              ],
            ),
            const SizedBox(height: FormSpacing.chipsToField),
            _TinctureResult(
              vesselL: vesselL,
              targetAbv: _v(_abv),
              spiritAbv: _v(_spiritAbv),
              rawGpl: _v(_rawGpl),
              sugarGpl: _v(_sugarGpl),
              material: widget.seed.rawMaterial,
            ),
          ],

          const SizedBox(height: FormSpacing.section),
          const FormSectionTitle(title: 'Дата старта'),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 14),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(formatFullDate(_startedAt))),
                  const Icon(Icons.calendar_today, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: FormSpacing.field),
          TextField(
            controller: _notes,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Заметка (необязательно)',
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 14),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(_buildResult()),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Запустить партию'),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _startedAt = picked);
  }

  TuningResult _buildResult() {
    final vesselL = _v(_vessel);
    final isMash = widget.seed.isMash;

    if (isMash) {
      final tuning = tuneMash(sugarKg: _v(_sugarKg), hydromodule: _v(_hydro));
      return TuningResult(
        startedAt: _startedAt,
        volumeL: tuning.totalVolumeL > 0 ? tuning.totalVolumeL : vesselL,
        ingredients: [
          (name: 'Сахар', amount: _v(_sugarKg), unit: 'кг', note: ''),
          (
            name: 'Вода',
            amount: tuning.waterL,
            unit: 'л',
            note: 'гидромодуль 1:${formatNumber(tuning.hydromodule)}',
          ),
        ],
        notes: _notes.text.trim(),
        summary:
            'Брага ${formatVolume(tuning.totalVolumeL)}, '
            'вода ${formatVolume(tuning.waterL)}, '
            'ожидаемый выход ${formatVolume(tuning.practicalAlcoholL)} АС',
      );
    }

    final tuning = tuneTincture(
      vesselVolumeL: vesselL,
      targetAbv: _v(_abv),
      spiritAbv: _v(_spiritAbv),
      rawKg: _v(_rawGpl) * vesselL / 1000,
      sugarKg: _v(_sugarGpl) * vesselL / 1000,
      rawMaterial: widget.seed.rawMaterial,
    );

    final ingredients =
        <({String name, double amount, String unit, String note})>[
          (
            name: 'Спирт ${formatNumber(_v(_spiritAbv), decimals: 0)}%',
            amount: tuning.spiritL,
            unit: 'л',
            note: '',
          ),
          if (tuning.waterL > 0.005)
            (name: 'Вода', amount: tuning.waterL, unit: 'л', note: ''),
          if (tuning.sugarKg > 0.0005)
            (name: 'Сахар', amount: tuning.sugarKg, unit: 'кг', note: ''),
          if (tuning.rawKg > 0.0005)
            (
              name: widget.seed.rawMaterial?.title ?? 'Сырьё',
              amount: tuning.rawKg,
              unit: 'кг',
              note: '${tuning.rawGramsPerLitre.round()} г/л',
            ),
        ];

    return TuningResult(
      startedAt: _startedAt,
      volumeL: vesselL,
      ingredients: ingredients,
      notes: _notes.text.trim(),
      summary:
          '${formatVolume(tuning.liquidL)} жидкости, '
          '${formatNumber(tuning.targetAbv, decimals: 0)}%, '
          'закладка ${formatVolume(tuning.fillL)} из ${formatVolume(vesselL)}',
    );
  }
}

// ---------- вспомогательные виджеты ----------

class _TinctureResult extends StatelessWidget {
  const _TinctureResult({
    required this.vesselL,
    required this.targetAbv,
    required this.spiritAbv,
    required this.rawGpl,
    required this.sugarGpl,
    required this.material,
  });

  final double vesselL;
  final double targetAbv;
  final double spiritAbv;
  final double rawGpl;
  final double sugarGpl;
  final RawMaterial? material;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tuning = tuneTincture(
      vesselVolumeL: vesselL,
      targetAbv: targetAbv,
      spiritAbv: spiritAbv,
      rawKg: rawGpl * vesselL / 1000,
      sugarKg: sugarGpl * vesselL / 1000,
      rawMaterial: material,
    );

    final fill = tuning.fillFraction.clamp(0.0, 1.5);
    final over = fill > 1.0;

    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.primary.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Что получится', style: theme.textTheme.titleSmall),
            const SizedBox(height: FormSpacing.titleToField),
            // Рамка вокруг шкалы: при 100 % заполнения трек не виден, и без
            // контура полоса читается как декоративная линия, а не индикатор.
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: fill.clamp(0.0, 1.0),
                  minHeight: 10,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation(
                    over ? theme.colorScheme.error : theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              vesselFitLabel(tuning.fillL, vesselL),
              style: theme.textTheme.bodySmall?.copyWith(
                color: over
                    ? theme.colorScheme.error
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const Divider(height: 20),
            _row('Спирт ${spiritAbv.round()}%', formatVolume(tuning.spiritL)),
            _row('Вода', formatVolume(tuning.waterL)),
            _row('Сахар', '${formatNumber(tuning.sugarKg, decimals: 3)} кг'),
            _row(
              material?.title ?? 'Сырьё',
              '${formatNumber(tuning.rawKg, decimals: 3)} кг '
              '(${tuning.rawGramsPerLitre.round()} г/л)',
            ),
            const Divider(height: 20),
            _row('Жидкость', formatVolume(tuning.liquidL)),
            _row('Закладка', formatVolume(tuning.fillL)),
            _row('Выход', formatVolume(tuning.estimatedFinalL)),
            if (tuning.warnings.isNotEmpty) ...[
              const SizedBox(height: 10),
              for (final warning in tuning.warnings)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 16,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          warning,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FormSpacing.resultRow / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _MashResult extends StatelessWidget {
  const _MashResult({
    required this.vesselL,
    required this.sugarKg,
    required this.hydromodule,
  });

  final double vesselL;
  final double sugarKg;
  final double hydromodule;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tuning = tuneMash(sugarKg: sugarKg, hydromodule: hydromodule);
    final fits = tuning.fitsIn(vesselL);
    final sugarForFullVessel = sugarForVessel(
      vesselVolumeL: vesselL,
      hydromodule: hydromodule,
    );

    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.primary.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Что получится', style: theme.textTheme.titleSmall),
            const SizedBox(height: FormSpacing.titleToField),
            _row('Вода', formatVolume(tuning.waterL)),
            _row('Объём браги', formatVolume(tuning.totalVolumeL)),
            _row('Влезает в ${formatVolume(vesselL)}', fits ? 'да' : 'нет'),
            const Divider(height: 20),
            _row(
              'Крепость браги',
              '${formatNumber(tuning.washAbv, decimals: 1)}%',
            ),
            _row('Выход АС (теория)', formatVolume(tuning.theoreticalAlcoholL)),
            _row('Выход АС (практика)', formatVolume(tuning.practicalAlcoholL)),
            const SizedBox(height: 8),
            Text(
              'Чтобы брага заняла ровно ${formatVolume(vesselL)}: '
              'сахара ${formatNumber(sugarForFullVessel, decimals: 2)} кг.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (!fits || tuning.warnings.isNotEmpty) ...[
              const SizedBox(height: 10),
              if (!fits)
                _warn(
                  theme,
                  'Не влезает: ${formatVolume(tuning.totalVolumeL)} при таре '
                  '${formatVolume(vesselL)}.',
                ),
              for (final warning in tuning.warnings) _warn(theme, warning),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: FormSpacing.resultRow / 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );

  Widget _warn(ThemeData theme, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          size: 16,
          color: theme.colorScheme.error,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Окно настройки: возвращает результат или null, если пользователь закрыл.
Future<TuningResult?> showRecipeTuneSheet({
  required BuildContext context,
  required Recipe recipe,
  required List<RecipeIngredient> ingredients,
}) {
  final seed = TuningSeed.fromRecipe(recipe, ingredients);
  return Navigator.of(context).push<TuningResult>(
    MaterialPageRoute<TuningResult>(
      fullscreenDialog: true,
      builder: (_) =>
          RecipeTuneSheet(recipe: recipe, ingredients: ingredients, seed: seed),
    ),
  );
}

/// Пресеты тары для быстрых чипов в других местах.
const List<double> kVesselPresets = [0.5, 1.0, 3.0, 5.0, 10.0, 20.0];

/// Ближайший пресет к произвольному объёму.
double nearestVesselPreset(double volumeL) {
  var best = kVesselPresets.first;
  var distance = (best - volumeL).abs();
  for (final preset in kVesselPresets) {
    final d = (preset - volumeL).abs();
    if (d < distance) {
      best = preset;
      distance = d;
    }
  }
  return best;
}

/// Максимум из двух чисел — мелкая утилита для UI-расчётов.
double maxOf(double a, double b) => math.max(a, b);
