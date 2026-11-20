import 'package:flutter/material.dart';

import '../../data/db/app_database.dart';
import '../../domain/recipe_seed.dart';
import '../../domain/recipe_tuning.dart';
import '../../domain/reference.dart';
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

/// Редактор рецепта перед запуском партии.
///
/// Один экран закрывает два сценария: «запустить как есть» и «подкрутить под
/// себя» — больше сырья, крепче, в другую тару. Стартовые значения берутся из
/// самого рецепта (его состав, объём и крепость), а не из констант, и всё
/// считается от требуемого объёма: меняешь объём — пересчитываются спирт,
/// вода, сахар и сырьё.
class RecipeTuneSheet extends StatefulWidget {
  const RecipeTuneSheet({
    super.key,
    required this.recipe,
    required this.ingredients,
    required this.seed,
  });

  final Recipe recipe;
  final List<RecipeIngredient> ingredients;
  final RecipeSeed seed;

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
  late final TextEditingController _water;
  late final TextEditingController _notes;

  late DateTime _startedAt;
  late double _spiritAbvValue;

  /// Объём, под который посчитан состав рецепта. Нужен, чтобы понимать,
  /// на сколько масштабировать «прочие» ингредиенты (дрожжи, травы).
  late final double _recipeVolumeL;

  @override
  void initState() {
    super.initState();
    final s = widget.seed;
    _recipeVolumeL = s.vesselL > 0 ? s.vesselL : 3.0;

    _vessel = TextEditingController(
      text: formatNumber(s.isDistillate ? s.chargeVolumeL : s.vesselL),
    );
    _abv = TextEditingController(
      text: formatNumber(
        s.isDistillate ? s.chargeAbv : s.targetAbv,
        decimals: 0,
      ),
    );
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
          : '',
    );
    _sugarKg = TextEditingController(
      text: s.sugarKg > 0 ? formatNumber(s.sugarKg, decimals: 2) : '',
    );
    _water = TextEditingController(
      text: formatNumber(
        s.waterL > 0
            ? s.waterL
            : (s.sugarKg > 0 ? s.sugarKg * 4.5 : 0),
        decimals: 2,
      ),
    );
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
      _water,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  double _v(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '.')) ?? 0;

  /// Во сколько раз меняется объём относительно рецепта.
  double get _scale {
    final current = _v(_vessel);
    if (_recipeVolumeL <= 0 || current <= 0) return 1;
    return current / _recipeVolumeL;
  }

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
    final seed = widget.seed;
    final vesselL = _v(_vessel);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          switch (seed.mode) {
            TuningMode.mash => 'Настроить брагу',
            TuningMode.tincture => 'Настроить рецепт',
            TuningMode.distillate => 'Настроить перегонку',
          },
        ),
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
            switch (seed.mode) {
              TuningMode.mash =>
                'Сахар, вода и объём браги считаются вместе: меняете сахар — '
                    'меняется вода и выход.',
              TuningMode.tincture =>
                'Крепость готового напитка — это спирт, делённый на весь '
                    'объём. Сырьё и сахар занимают место и «съедают» крепость.',
              TuningMode.distillate =>
                'Объём и крепость заливки в куб. Приложение посчитает спирт '
                    'в кубе и ожидаемый выход тела.',
            },
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: FormSpacing.section),

          // ---------- объём ----------
          FormSectionTitle(
            title: seed.isDistillate ? 'Заливка в куб' : 'Тара',
            hint: switch (seed.mode) {
              TuningMode.mash => 'Объём бродильной ёмкости',
              TuningMode.tincture => 'Куда закладываем',
              TuningMode.distillate => 'Сколько заливаем',
            },
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
            label: seed.isDistillate ? 'Объём заливки' : 'Свой объём',
            suffix: 'л',
            onChanged: () => setState(() {}),
          ),

          if (seed.isMash) ...[
            const SizedBox(height: FormSpacing.sectionAfterField),
            const FormSectionTitle(title: 'Сахар', hint: 'Сколько кладём'),
            FormNumberField(
              controller: _sugarKg,
              label: 'Сахар',
              suffix: 'кг',
              onChanged: () => setState(() {}),
            ),
            FormNumberField(
              controller: _water,
              label: 'Вода',
              suffix: 'л',
              onChanged: () => setState(() {}),
              hint: _v(_water) > 0 && _v(_sugarKg) > 0
                  ? 'Гидромодуль 1:'
                        '${formatNumber(_v(_water) / _v(_sugarKg), decimals: 1)}'
                  : null,
            ),
            const SizedBox(height: FormSpacing.fieldToHint),
            _MashResult(
              vesselL: vesselL,
              sugarKg: _v(_sugarKg),
              waterL: _v(_water),
              extraRaw: seed.rawMaterial,
              extraRawKg: seed.rawMaterial != null ? _extraRawKg(vesselL) : 0,
              warnAboutHydromodule:
                  (seed.rawMaterial?.waterFraction ?? 0) < 0.5,
            ),
          ] else if (seed.isDistillate) ...[
            const SizedBox(height: FormSpacing.sectionAfterField),
            const FormSectionTitle(
              title: 'Заливка',
              hint: 'Крепость того, что уже в кубе',
            ),
            FormNumberField(
              controller: _abv,
              label: 'Крепость заливки',
              suffix: '%',
              onChanged: () => setState(() {}),
            ),
            const SizedBox(height: FormSpacing.fieldToHint),
            _DistillateResult(volumeL: vesselL, chargeAbv: _v(_abv)),
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
              title: seed.rawName ?? seed.rawMaterial?.title ?? 'Сырьё',
              hint: seed.rawMaterial?.note,
            ),
            FormNumberField(
              controller: _rawGpl,
              label: 'Сырьё',
              suffix: 'г/л',
              onChanged: () => setState(() {}),
              hint: _rawHint(),
              hintIcon:
                  seed.rawMaterial != null &&
                      !seed.rawMaterial!.isInRange(_v(_rawGpl))
                  ? Icons.info_outline
                  : Icons.check_circle_outline,
              hintIsWarning:
                  seed.rawMaterial != null &&
                  !seed.rawMaterial!.isInRange(_v(_rawGpl)),
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
              material: seed.rawMaterial,
              rawTitle: seed.rawName,
              seedRawGpl: seed.rawGramsPerLitre,
            ),
          ],

          if (seed.carried.isNotEmpty) ...[
            const SizedBox(height: FormSpacing.section),
            FormSectionTitle(
              title: 'Из рецепта',
              hint: 'Пересчитается под объём',
            ),
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  for (final ing in seed.carried)
                    ListTile(
                      dense: true,
                      title: Text(ing.name),
                      trailing: Text(
                        _scaledAmountLabel(ing),
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
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

  /// Сырьё браги (варенье, мёд, зерно), кг — по объёму тары.
  double _extraRawKg(double vesselL) {
    final gpl = widget.seed.rawGramsPerLitre;
    if (gpl <= 0) return 0;
    return gpl * vesselL / 1000;
  }

  /// Как изменится количество «прочего» ингредиента при текущем объёме.
  String _scaledAmountLabel(SeedIngredient ing) {
    final scaled = ing.amount * _scale;
    return '${formatNumber(scaled, decimals: 2)} ${ing.unit}';
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

  /// Ингредиенты рецепта, которые не считаются формулой, под текущий объём.
  List<({String name, double amount, String unit, String note})> _carriedList() {
    final scale = _scale;
    return [
      for (final ing in widget.seed.carried)
        (
          name: ing.name,
          amount: ing.amount * scale,
          unit: ing.unit,
          note: scale != 1
              ? 'пересчитано с ${formatVolume(_recipeVolumeL)}'
              : '',
        ),
    ];
  }

  TuningResult _buildResult() {
    final seed = widget.seed;
    final vesselL = _v(_vessel);

    if (seed.isMash) {
      final tuning = tuneMash(
        sugarKg: _v(_sugarKg),
        hydromodule: _v(_sugarKg) > 0 ? _v(_water) / _v(_sugarKg) : 0,
        waterL: _v(_water),
        extraRawKg: seed.rawMaterial != null ? _extraRawKg(vesselL) : 0,
        extraRaw: seed.rawMaterial,
        warnAboutHydromodule: (seed.rawMaterial?.waterFraction ?? 0) < 0.5,
      );
      return TuningResult(
        startedAt: _startedAt,
        // Объём партии — это объём браги, а не тары: иначе выход считается
        // от пустого места в ёмкости.
        volumeL: tuning.totalVolumeL > 0 ? tuning.totalVolumeL : vesselL,
        ingredients: [
          (name: 'Сахар', amount: _v(_sugarKg), unit: 'кг', note: ''),
          if (seed.rawMaterial != null && _extraRawKg(vesselL) > 0)
            (
              name: seed.rawName ?? seed.rawMaterial!.title,
              amount: _extraRawKg(vesselL),
              unit: 'кг',
              note: '${seed.rawGramsPerLitre.round()} г/л',
            ),
          (
            name: 'Вода',
            amount: tuning.waterL,
            unit: 'л',
            note: 'гидромодуль 1:${formatNumber(tuning.hydromodule)}',
          ),
          ..._carriedList(),
        ],
        notes: _notes.text.trim(),
        summary:
            'Брага ${formatVolume(tuning.totalVolumeL)}, '
            'вода ${formatVolume(tuning.waterL)}, '
            'ожидаемый выход ${formatVolume(tuning.practicalAlcoholL)} АС',
      );
    }

    if (seed.isDistillate) {
      final volume = vesselL > 0 ? vesselL : seed.chargeVolumeL;
      final abv = _v(_abv);
      final alcohol = volume * abv / 100;
      return TuningResult(
        startedAt: _startedAt,
        volumeL: volume,
        ingredients: _carriedList(),
        notes: _notes.text.trim(),
        summary:
            'Заливка ${formatVolume(volume)} крепостью '
            '${formatNumber(abv, decimals: 0)}%, '
            'в кубе ${formatNumber(alcohol, decimals: 2)} л АС',
      );
    }

    final tuning = tuneTincture(
      vesselVolumeL: vesselL,
      targetAbv: _v(_abv),
      spiritAbv: _v(_spiritAbv),
      rawKg: _v(_rawGpl) * vesselL / 1000,
      sugarKg: _v(_sugarGpl) * vesselL / 1000,
      rawMaterial: seed.rawMaterial,
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
              name: seed.rawName ?? seed.rawMaterial?.title ?? 'Сырьё',
              amount: tuning.rawKg,
              unit: 'кг',
              note: '${tuning.rawGramsPerLitre.round()} г/л',
            ),
          ..._carriedList(),
        ];

    return TuningResult(
      startedAt: _startedAt,
      // Объём партии — фактическая закладка, а не весь объём тары.
      volumeL: tuning.fillL > 0 ? tuning.fillL : vesselL,
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

/// Общая карточка результата с полосой заполнения тары.
class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.title,
    required this.children,
    this.fill,
    this.fillLabel,
    this.over = false,
  });

  final String title;
  final List<Widget> children;
  final double? fill;
  final String? fillLabel;
  final bool over;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.primary.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall),
            const SizedBox(height: FormSpacing.titleToField),
            if (fill != null) ...[
              // Рамка вокруг шкалы: при 100 % заполнения трек не виден, и без
              // контура полоса читается как декоративная линия.
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: fill!.clamp(0.0, 1.0),
                    minHeight: 10,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(
                      over ? theme.colorScheme.error : theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              if (fillLabel != null)
                Text(
                  fillLabel!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: over
                        ? theme.colorScheme.error
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              const Divider(height: 20),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}

class _TinctureResult extends StatelessWidget {
  const _TinctureResult({
    required this.vesselL,
    required this.targetAbv,
    required this.spiritAbv,
    required this.rawGpl,
    required this.sugarGpl,
    required this.material,
    this.rawTitle,
    this.seedRawGpl = 0,
  });

  final double vesselL;
  final double targetAbv;
  final double spiritAbv;
  final double rawGpl;
  final double sugarGpl;
  final RawMaterial? material;
  final String? rawTitle;

  /// Доза из рецепта: если её не меняли, о норме не предупреждаем.
  final double seedRawGpl;

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
      warnAboutDose: (rawGpl - seedRawGpl).abs() > 0.5,
    );

    return _ResultCard(
      title: 'Что получится',
      fill: tuning.fillFraction,
      fillLabel: vesselFitLabel(tuning.fillL, vesselL),
      over: tuning.fillFraction > 1.0,
      children: [
        _row('Спирт ${spiritAbv.round()}%', formatVolume(tuning.spiritL)),
        _row('Вода', formatVolume(tuning.waterL)),
        if (tuning.sugarKg > 0.0005)
          _row('Сахар', '${formatNumber(tuning.sugarKg, decimals: 3)} кг'),
        if (tuning.rawKg > 0.0005)
          _row(
            rawTitle ?? material?.title ?? 'Сырьё',
            '${formatNumber(tuning.rawKg, decimals: 3)} кг '
                '(${tuning.rawGramsPerLitre.round()} г/л)',
          ),
        const Divider(height: 20),
        _row('Жидкость', formatVolume(tuning.liquidL)),
        _row('Закладка', formatVolume(tuning.fillL)),
        _row('Крепость', '${formatNumber(tuning.actualAbv, decimals: 1)}%'),
        _row('Выход', formatVolume(tuning.estimatedFinalL)),
        ..._warnings(theme, tuning.warnings),
      ],
    );
  }
}

class _MashResult extends StatelessWidget {
  const _MashResult({
    required this.vesselL,
    required this.sugarKg,
    this.waterL,
    this.extraRaw,
    this.extraRawKg = 0,
    this.warnAboutHydromodule = true,
  });

  final double vesselL;
  final double sugarKg;
  final double? waterL;
  final RawMaterial? extraRaw;
  final double extraRawKg;
  final bool warnAboutHydromodule;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hydromodule = sugarKg > 0 && (waterL ?? 0) > 0
        ? waterL! / sugarKg
        : 4.5;
    final tuning = tuneMash(
      sugarKg: sugarKg,
      hydromodule: hydromodule,
      waterL: waterL,
      extraRawKg: extraRawKg,
      extraRaw: extraRaw,
      warnAboutHydromodule: warnAboutHydromodule,
    );
    final fits = tuning.fitsIn(vesselL);
    final sugarForFullVessel = sugarForVessel(
      vesselVolumeL: vesselL,
      hydromodule: hydromodule,
      extraRawKg: extraRawKg,
      extraRaw: extraRaw,
    );

    return _ResultCard(
      title: 'Что получится',
      fill: vesselL > 0 ? tuning.totalVolumeL / vesselL : 0,
      fillLabel: fits
          ? 'Заполнит ${(tuning.totalVolumeL / vesselL * 100).round()} % тары'
          : 'Не влезает: не хватает '
                '${formatNumber(tuning.totalVolumeL - vesselL, decimals: 1)} л',
      over: !fits,
      children: [
        _row('Сахар', '${formatNumber(sugarKg, decimals: 2)} кг'),
        if (extraRawKg > 0)
          _row(
            extraRaw?.title ?? 'Сырьё',
            '${formatNumber(extraRawKg, decimals: 2)} кг',
          ),
        _row('Вода', formatVolume(tuning.waterL)),
        _row('Объём браги', formatVolume(tuning.totalVolumeL)),
        const Divider(height: 20),
        _row('Крепость браги', '${formatNumber(tuning.washAbv, decimals: 1)}%'),
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
        ..._warnings(theme, tuning.warnings),
      ],
    );
  }
}

/// Перегонка: сколько спирта в кубе и сколько ждать тела.
class _DistillateResult extends StatelessWidget {
  const _DistillateResult({required this.volumeL, required this.chargeAbv});

  final double volumeL;
  final double chargeAbv;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final alcohol = volumeL > 0 ? volumeL * chargeAbv / 100 : 0.0;
    // Практика домашней дробной перегонки: 80–85 % спирта уходит в тело.
    final hearts = alcohol * 0.82;
    final heads = alcohol * 0.05;
    final tails = alcohol * 0.10;

    return _ResultCard(
      title: 'Что получится',
      children: [
        _row('Заливка', formatVolume(volumeL)),
        _row('Крепость заливки', '${formatNumber(chargeAbv, decimals: 0)}%'),
        _row('Спирта в кубе', '${formatNumber(alcohol, decimals: 2)} л АС'),
        const Divider(height: 20),
        _row('Головы (≈5 %)', '${formatNumber(heads, decimals: 2)} л АС'),
        _row('Тело (≈82 %)', '${formatNumber(hearts, decimals: 2)} л АС'),
        _row('Хвосты (≈10 %)', '${formatNumber(tails, decimals: 2)} л АС'),
        const SizedBox(height: 8),
        Text(
          'Тело в пересчёте на 40 % — около '
          '${formatVolume(hearts / 0.4)} напитка.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        ..._warnings(theme, [
          if (volumeL <= 0) 'Не задан объём заливки.',
          if (chargeAbv > 96)
            'Крепость заливки выше 96 % — так не бывает: спирт-сырец крепче '
                '96 % не получить.',
          if (chargeAbv > 0 && chargeAbv < 5)
            'Заливка крепостью ниже 5 % — спирта в кубе почти нет, гнать '
                'нечего.',
        ]),
      ],
    );
  }
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

List<Widget> _warnings(ThemeData theme, List<String> warnings) {
  if (warnings.isEmpty) return const [];
  return [
    const SizedBox(height: 10),
    for (final warning in warnings)
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
  ];
}

/// Окно настройки: возвращает результат или null, если пользователь закрыл.
Future<TuningResult?> showRecipeTuneSheet({
  required BuildContext context,
  required Recipe recipe,
  required List<RecipeIngredient> ingredients,
}) {
  final seed = seedFromRecipe(
    kind: recipe.kind,
    baseVolumeL: recipe.baseVolumeL,
    expectedAbv: recipe.expectedAbv,
    ingredients: [
      for (final ing in ingredients)
        SeedIngredient(name: ing.name, amount: ing.amount, unit: ing.unit),
    ],
  );
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
  for (final preset in kVesselPresets) {
    if ((preset - volumeL).abs() < (best - volumeL).abs()) best = preset;
  }
  return best;
}
