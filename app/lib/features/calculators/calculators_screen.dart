import 'package:flutter/material.dart';

import '../../domain/calculators.dart';
import '../../domain/reference.dart';
import '../../domain/recipe_tuning.dart';
import '../../utils/format.dart';
import '../../widgets/form_fields.dart';

/// Хаб калькуляторов.
///
/// Во всех расчётах, где участвует крепость, есть поле температуры: ареометр
/// показывает крепость при фактической температуре, а считаем мы всегда при
/// 20 °C — иначе цифры расходятся на 1–3 %.
class CalculatorsScreen extends StatelessWidget {
  const CalculatorsScreen({super.key});

  static final List<_CalcEntry> _entries = [
    _CalcEntry(
      'Сахарная брага',
      'Вода, выход, крепость браги, влезает ли в ёмкость',
      Icons.grain,
      () => const _SugarWashCalculator(),
    ),
    _CalcEntry(
      'Разбавление',
      'Сколько воды добавить до нужной крепости',
      Icons.water_drop,
      () => const _DilutionCalculator(),
    ),
    _CalcEntry(
      'Сортировка на объём',
      'Сколько спирта и воды, чтобы получить ровно N литров',
      Icons.straighten,
      () => const _SortingCalculator(),
    ),
    _CalcEntry(
      'Фракции',
      'Головы, тело, хвосты и разбивка по банкам',
      Icons.content_cut,
      () => const _FractionsCalculator(),
    ),
    _CalcEntry(
      'Укрепление',
      'Сколько спирта долить, чтобы поднять крепость',
      Icons.trending_up,
      () => const _FortifyCalculator(),
    ),
    _CalcEntry(
      'Купаж',
      'Смешать два объёма разной крепости',
      Icons.merge_type,
      () => const _BlendCalculator(),
    ),
    _CalcEntry(
      'Сахар и крепость',
      'Как сахар разбавит напиток',
      Icons.icecream,
      () => const _SugarEffectCalculator(),
    ),
    _CalcEntry(
      'Выход из сырья',
      'Сколько спирта даст сахар, зерно или фрукты',
      Icons.agriculture,
      () => const _YieldCalculator(),
    ),
    _CalcEntry(
      'Масштаб рецепта',
      'Пересчёт под свой объём',
      Icons.aspect_ratio,
      () => const _ScaleCalculator(),
    ),
    _CalcEntry(
      'Поправка ареометра',
      'Показания при температуре → крепость при 20 °C',
      Icons.thermostat,
      () => const _HydrometerCalculator(),
    ),
    _CalcEntry(
      'Щепа и бочка',
      'Эквивалент щепы и ангельская доля',
      Icons.inventory_2,
      () => const _ChipsCalculator(),
    ),
    _CalcEntry(
      'Себестоимость',
      'Цена литра АС и литра продукта',
      Icons.payments,
      () => const _CostCalculator(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькуляторы')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        itemCount: _entries.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final entry = _entries[i];
          return Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Icon(entry.icon),
              title: Text(entry.title),
              subtitle: Text(entry.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text(entry.title)),
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: entry.builder(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CalcEntry {
  _CalcEntry(this.title, this.subtitle, this.icon, this.builder);

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget Function() builder;
}

// ---------- общие виджеты ----------

class _CalcBody extends StatelessWidget {
  const _CalcBody({required this.fields, this.result});

  final List<Widget> fields;
  final Widget? result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...fields,
        if (result != null)
          Card(
            margin: const EdgeInsets.only(top: FormSpacing.fieldToHint),
            color: theme.colorScheme.primary.withValues(alpha: 0.10),
            child: Padding(padding: const EdgeInsets.all(16), child: result!),
          ),
        const SizedBox(height: FormSpacing.section),
      ],
    );
  }
}

/// Обёртка над общим полем: в калькуляторах единица измерения всегда есть.
class _NumField extends StatelessWidget {
  const _NumField({
    required this.controller,
    required this.label,
    this.suffix,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String? suffix;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormNumberField(
      controller: controller,
      label: label,
      suffix: suffix ?? '',
      onChanged: onChanged,
    );
  }
}

/// Пара полей «крепость + температура» с приведением к 20 °C.
///
/// Используется везде, где крепость измерена ареометром: без поправки
/// расчёт уезжает на 1–3 % — при 25 °C показания завышены.
class _StrengthField extends StatelessWidget {
  const _StrengthField({
    required this.abvController,
    required this.tempController,
    required this.onChanged,
    this.label = 'Крепость по ареометру',
  });

  final TextEditingController abvController;
  final TextEditingController tempController;
  final VoidCallback onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reading = _parse(abvController);
    final temp = _parse(tempController);
    final corrected = hydrometerCorrection(reading: reading, tempC: temp);

    final hasCorrection = (temp - 20).abs() > 0.5;

    return Padding(
      padding: const EdgeInsets.only(bottom: FormSpacing.field),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: FormNumberField(
                  controller: abvController,
                  label: label,
                  suffix: '%',
                  onChanged: onChanged,
                  bottomPadding: 0,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FormNumberField(
                  controller: tempController,
                  label: 'Температура',
                  suffix: '°C',
                  onChanged: onChanged,
                  bottomPadding: 0,
                ),
              ),
            ],
          ),
          if (hasCorrection)
            Padding(
              padding: const EdgeInsets.only(top: FormSpacing.fieldToHint),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.thermostat,
                    size: 15,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'При 20 °C это ${formatNumber(corrected, decimals: 1)}% '
                      '(поправка ${corrected >= reading ? '+' : ''}'
                      '${formatNumber(corrected - reading, decimals: 1)})',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.warn = false,
  });

  final String label;
  final String value;
  final bool bold;
  final bool warn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FormSpacing.resultRow / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label, style: theme.textTheme.bodyMedium)),
          const SizedBox(width: 12),
          Text(
            value,
            style:
                (bold
                        ? theme.textTheme.titleMedium
                        : theme.textTheme.bodyMedium)
                    ?.copyWith(
                      fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                      color: warn ? theme.colorScheme.error : null,
                    ),
          ),
        ],
      ),
    );
  }
}

double _parse(TextEditingController c) =>
    double.tryParse(c.text.replaceAll(',', '.')) ?? 0;

/// Стандартная температура по умолчанию для новых полей.
TextEditingController _tempController() => TextEditingController(text: '20');

// ---------- 1. сахарная брага ----------

class _SugarWashCalculator extends StatefulWidget {
  const _SugarWashCalculator();

  @override
  State<_SugarWashCalculator> createState() => _SugarWashCalculatorState();
}

class _SugarWashCalculatorState extends State<_SugarWashCalculator> {
  final _sugar = TextEditingController(text: '5');
  final _hydro = TextEditingController(text: '4');
  final _vessel = TextEditingController(text: '25');

  @override
  void dispose() {
    _sugar.dispose();
    _hydro.dispose();
    _vessel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tuning = tuneMash(
      sugarKg: _parse(_sugar),
      hydromodule: _parse(_hydro) > 0 ? _parse(_hydro) : 4,
    );
    final vessel = _parse(_vessel);
    final fits = vessel <= 0 || tuning.fitsIn(vessel);
    final sugarForVessel = vessel > 0
        ? sugarForVesselCalc(vessel, _parse(_hydro))
        : 0.0;

    return _CalcBody(
      fields: [
        _NumField(
          controller: _sugar,
          label: 'Сахар',
          suffix: 'кг',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _hydro,
          label: 'Гидромодуль (1 к N)',
          suffix: 'N',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _vessel,
          label: 'Объём ёмкости',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Гидромодуль 1:4 — стандарт. 1:5 бродит чище, но дольше.',
          style: theme.textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Вода',
            value: formatVolume(tuning.waterL),
            bold: true,
          ),
          _ResultRow(
            label: 'Объём браги',
            value: formatVolume(tuning.totalVolumeL),
          ),
          if (vessel > 0)
            _ResultRow(
              label: 'Влезает в ${formatVolume(vessel)}',
              value: fits ? 'да' : 'нет',
              warn: !fits,
            ),
          const SizedBox(height: 6),
          _ResultRow(
            label: 'Крепость браги',
            value: '${formatNumber(tuning.washAbv, decimals: 1)}%',
          ),
          _ResultRow(
            label: 'Выход АС (теория)',
            value: formatVolume(tuning.theoreticalAlcoholL),
          ),
          _ResultRow(
            label: 'Выход АС (практика)',
            value: formatVolume(tuning.practicalAlcoholL),
            bold: true,
          ),
          _ResultRow(
            label: 'Сортировки 40%',
            value: formatVolume(tuning.practicalAlcoholL / 0.4),
          ),
          if (vessel > 0) ...[
            const SizedBox(height: 6),
            _ResultRow(
              label: 'Сахара ровно под ёмкость',
              value: '${formatNumber(sugarForVessel, decimals: 2)} кг',
            ),
          ],
          for (final warning in tuning.warnings)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                warning,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }

  double sugarForVesselCalc(double vessel, double hydro) =>
      sugarForVessel(vesselVolumeL: vessel, hydromodule: hydro);
}

// ---------- 2. разбавление ----------

class _DilutionCalculator extends StatefulWidget {
  const _DilutionCalculator();

  @override
  State<_DilutionCalculator> createState() => _DilutionCalculatorState();
}

class _DilutionCalculatorState extends State<_DilutionCalculator> {
  final _volume = TextEditingController(text: '5');
  final _from = TextEditingController(text: '70');
  final _temp = _tempController();
  final _to = TextEditingController(text: '40');

  @override
  void dispose() {
    _volume.dispose();
    _from.dispose();
    _temp.dispose();
    _to.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final from = hydrometerCorrection(
      reading: _parse(_from),
      tempC: _parse(_temp),
    );
    final water = dilutionWater(
      volumeL: _parse(_volume),
      fromAbv: from,
      toAbv: _parse(_to),
    );
    final total = dilutedVolume(
      volumeL: _parse(_volume),
      fromAbv: from,
      toAbv: _parse(_to),
    );

    return _CalcBody(
      fields: [
        _NumField(
          controller: _volume,
          label: 'Объём спирта',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _StrengthField(
          abvController: _from,
          tempController: _temp,
          onChanged: () => setState(() {}),
          label: 'Текущая крепость',
        ),
        _NumField(
          controller: _to,
          label: 'Нужная крепость',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Спирт вливать в воду, не наоборот. После разбавления дать '
          'отдохнуть 3–7 дней.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Добавить воды',
            value: formatVolume(water),
            bold: true,
          ),
          _ResultRow(label: 'Итоговый объём', value: formatVolume(total)),
        ],
      ),
    );
  }
}

// ---------- 3. сортировка на объём ----------

class _SortingCalculator extends StatefulWidget {
  const _SortingCalculator();

  @override
  State<_SortingCalculator> createState() => _SortingCalculatorState();
}

class _SortingCalculatorState extends State<_SortingCalculator> {
  final _volume = TextEditingController(text: '1');
  final _target = TextEditingController(text: '40');
  final _spirit = TextEditingController(text: '96');
  final _temp = _tempController();

  @override
  void dispose() {
    _volume.dispose();
    _target.dispose();
    _spirit.dispose();
    _temp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spiritAbv = hydrometerCorrection(
      reading: _parse(_spirit),
      tempC: _parse(_temp),
    );
    final plan = sortingForVolume(
      volumeL: _parse(_volume),
      targetAbv: _parse(_target),
      spiritAbv: spiritAbv,
    );
    final impossible = _parse(_target) > spiritAbv + 0.01;

    return _CalcBody(
      fields: [
        _NumField(
          controller: _volume,
          label: 'Нужно получить',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _target,
          label: 'Крепость сортировки',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        _StrengthField(
          abvController: _spirit,
          tempController: _temp,
          onChanged: () => setState(() {}),
          label: 'Крепость спирта',
        ),
        Text(
          'Обратная задача к разбавлению: считаем от нужного объёма, а не от '
          'того, что уже налито.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Спирта ${formatNumber(spiritAbv, decimals: 0)}%',
            value: formatVolume(plan.spiritL),
            bold: true,
          ),
          _ResultRow(
            label: 'Воды',
            value: formatVolume(plan.waterL),
            bold: true,
          ),
          _ResultRow(
            label: 'Всего',
            value: formatVolume(plan.spiritL + plan.waterL),
          ),
          if (impossible)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Крепость выше крепости спирта — так не получится.',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------- 4. фракции ----------

class _FractionsCalculator extends StatefulWidget {
  const _FractionsCalculator();

  @override
  State<_FractionsCalculator> createState() => _FractionsCalculatorState();
}

class _FractionsCalculatorState extends State<_FractionsCalculator> {
  final _volume = TextEditingController(text: '20');
  final _abv = TextEditingController(text: '25');
  final _temp = _tempController();
  final _heads = TextEditingController(text: '9');
  final _jar = TextEditingController(text: '500');

  @override
  void dispose() {
    _volume.dispose();
    _abv.dispose();
    _temp.dispose();
    _heads.dispose();
    _jar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final abv = hydrometerCorrection(
      reading: _parse(_abv),
      tempC: _parse(_temp),
    );
    final plan = fractionsPlan(
      rawVolumeL: _parse(_volume),
      rawAbv: abv,
      headsPercent: _parse(_heads) > 0 ? _parse(_heads) : 9,
    );
    final jarMl = _parse(_jar);
    final headsMl = plan.headsL * 1000;
    final jars = jarMl > 0
        ? headsIntoJars(headsMl: headsMl, jarMl: jarMl)
        : null;

    return _CalcBody(
      fields: [
        _NumField(
          controller: _volume,
          label: 'Объём спирта-сырца',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _StrengthField(
          abvController: _abv,
          tempController: _temp,
          onChanged: () => setState(() {}),
          label: 'Крепость сырца',
        ),
        _NumField(
          controller: _heads,
          label: 'Головы, % от АС',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _jar,
          label: 'Объём банки для голов',
          suffix: 'мл',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Сахар и зерно — 8–10%, фрукты — 10–15%. Тело отбирать до 45–50% '
          'в струе.',
          style: theme.textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Абсолютный спирт',
            value: formatVolume(plan.absoluteAlcoholL),
          ),
          _ResultRow(
            label: 'Головы',
            value: formatVolume(plan.headsL),
            bold: true,
          ),
          _ResultRow(
            label: 'Тело (АС)',
            value: formatVolume(plan.heartsL),
            bold: true,
          ),
          _ResultRow(label: 'Хвосты (АС)', value: formatVolume(plan.tailsL)),
          if (jars != null && jars.fullJars > 0) ...[
            const SizedBox(height: 6),
            _ResultRow(
              label: 'Головы по банкам ${formatNumber(jarMl, decimals: 0)} мл',
              value:
                  '${jars.fullJars} шт'
                  '${jars.restMl > 1 ? ' + ${jars.restMl.round()} мл' : ''}',
            ),
          ],
        ],
      ),
    );
  }
}

// ---------- 5. укрепление ----------

class _FortifyCalculator extends StatefulWidget {
  const _FortifyCalculator();

  @override
  State<_FortifyCalculator> createState() => _FortifyCalculatorState();
}

class _FortifyCalculatorState extends State<_FortifyCalculator> {
  final _volume = TextEditingController(text: '3');
  final _abv = TextEditingController(text: '25');
  final _temp = _tempController();
  final _target = TextEditingController(text: '40');
  final _spirit = TextEditingController(text: '70');

  @override
  void dispose() {
    _volume.dispose();
    _abv.dispose();
    _temp.dispose();
    _target.dispose();
    _spirit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final abv = hydrometerCorrection(
      reading: _parse(_abv),
      tempC: _parse(_temp),
    );
    final add = fortifyToTarget(
      volumeL: _parse(_volume),
      abv: abv,
      targetAbv: _parse(_target),
      spiritAbv: _parse(_spirit),
    );
    final finalVolume = _parse(_volume) + add;

    return _CalcBody(
      fields: [
        _NumField(
          controller: _volume,
          label: 'Объём напитка',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _StrengthField(
          abvController: _abv,
          tempController: _temp,
          onChanged: () => setState(() {}),
          label: 'Текущая крепость',
        ),
        _NumField(
          controller: _target,
          label: 'Хочу крепость',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _spirit,
          label: 'Крепость добавляемого спирта',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Если спирт слабее целевой крепости, поднять её нельзя — '
          'нужен спирт крепче.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Долить спирта',
            value: add > 0 ? formatVolume(add) : 'невозможно',
            bold: true,
            warn: add <= 0,
          ),
          if (add > 0)
            _ResultRow(
              label: 'Станет объёма',
              value: formatVolume(finalVolume),
            ),
        ],
      ),
    );
  }
}

// ---------- 6. купаж ----------

class _BlendCalculator extends StatefulWidget {
  const _BlendCalculator();

  @override
  State<_BlendCalculator> createState() => _BlendCalculatorState();
}

class _BlendCalculatorState extends State<_BlendCalculator> {
  final _v1 = TextEditingController(text: '3');
  final _a1 = TextEditingController(text: '40');
  final _t1 = _tempController();
  final _v2 = TextEditingController(text: '2');
  final _a2 = TextEditingController(text: '60');
  final _t2 = _tempController();

  @override
  void dispose() {
    for (final c in [_v1, _a1, _t1, _v2, _a2, _t2]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a1 = hydrometerCorrection(reading: _parse(_a1), tempC: _parse(_t1));
    final a2 = hydrometerCorrection(reading: _parse(_a2), tempC: _parse(_t2));
    final abv = blendAbv(
      volume1L: _parse(_v1),
      abv1: a1,
      volume2L: _parse(_v2),
      abv2: a2,
    );
    final total = _parse(_v1) + _parse(_v2);

    return _CalcBody(
      fields: [
        Text('Первый объём', style: Theme.of(context).textTheme.titleSmall),
        _NumField(
          controller: _v1,
          label: 'Объём',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _StrengthField(
          abvController: _a1,
          tempController: _t1,
          onChanged: () => setState(() {}),
          label: 'Крепость',
        ),
        const SizedBox(height: 8),
        Text('Второй объём', style: Theme.of(context).textTheme.titleSmall),
        _NumField(
          controller: _v2,
          label: 'Объём',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _StrengthField(
          abvController: _a2,
          tempController: _t2,
          onChanged: () => setState(() {}),
          label: 'Крепость',
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Крепость смеси',
            value: '${formatNumber(abv, decimals: 1)}%',
            bold: true,
          ),
          _ResultRow(label: 'Объём', value: formatVolume(total)),
          _ResultRow(
            label: 'Абсолютный спирт',
            value: formatVolume(absoluteAlcohol(volumeL: total, abv: abv)),
          ),
        ],
      ),
    );
  }
}

// ---------- 7. сахар и крепость ----------

class _SugarEffectCalculator extends StatefulWidget {
  const _SugarEffectCalculator();

  @override
  State<_SugarEffectCalculator> createState() => _SugarEffectCalculatorState();
}

class _SugarEffectCalculatorState extends State<_SugarEffectCalculator> {
  final _volume = TextEditingController(text: '3');
  final _abv = TextEditingController(text: '40');
  final _sugar = TextEditingController(text: '300');

  @override
  void dispose() {
    _volume.dispose();
    _abv.dispose();
    _sugar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final volume = _parse(_volume);
    final sugarGpl = _parse(_sugar);
    final sugarKg = sugarGpl * volume / 1000;
    final after = abvAfterSugar(
      volumeL: volume,
      abv: _parse(_abv),
      sugarKg: sugarKg,
    );
    final level = SweetnessLevel.bySugar(sugarGpl);

    return _CalcBody(
      fields: [
        _NumField(
          controller: _volume,
          label: 'Объём напитка',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _abv,
          label: 'Крепость до сахара',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _sugar,
          label: 'Сахар',
          suffix: 'г/л',
          onChanged: () => setState(() {}),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final level in sweetnessLevels)
              ActionChip(
                label: Text(level.title),
                onPressed: () {
                  _sugar.text = level.averageSugarGramsPerLitre
                      .round()
                      .toString();
                  setState(() {});
                },
              ),
          ],
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Сахар всего',
            value: '${formatNumber(sugarKg, decimals: 3)} кг',
          ),
          _ResultRow(
            label: 'Крепость после сахара',
            value: '${formatNumber(after, decimals: 1)}%',
            bold: true,
          ),
          _ResultRow(
            label: 'Потеря крепости',
            value: '${formatNumber(_parse(_abv) - after, decimals: 1)}%',
            warn: true,
          ),
          _ResultRow(label: 'Сладость', value: level?.title ?? 'выше ликёрной'),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Сахар не добавляет спирта, но занимает объём: 100 г/л '
              '«съедают» около 2–3 % крепости. Хотите и сладко, и крепко — '
              'считайте спирт от конечного объёма.',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- 8. выход из сырья ----------

class _YieldCalculator extends StatefulWidget {
  const _YieldCalculator();

  @override
  State<_YieldCalculator> createState() => _YieldCalculatorState();
}

class _YieldCalculatorState extends State<_YieldCalculator> {
  final _mass = TextEditingController(text: '10');
  final _fraction = TextEditingController(text: '100');
  bool _fromStarch = false;

  @override
  void dispose() {
    _mass.dispose();
    _fraction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final theoretical = alcoholFromRaw(
      massKg: _parse(_mass),
      sugarFraction: _parse(_fraction) / 100,
      fromStarch: _fromStarch,
    );
    final practical = theoretical * 0.93;

    return _CalcBody(
      fields: [
        _NumField(
          controller: _mass,
          label: 'Масса сырья',
          suffix: 'кг',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _fraction,
          label: _fromStarch ? 'Крахмал' : 'Сахар',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Считать по крахмалу'),
          subtitle: const Text('Зерно, картофель: 0,71 л АС на кг крахмала'),
          value: _fromStarch,
          onChanged: (value) => setState(() => _fromStarch = value),
        ),
        Text(
          'Быстрые подстановки — из справочника сырья:',
          style: theme.textTheme.bodySmall,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final material in rawMaterials.where(
              (m) => m.category == 'grain' || m.category == 'starch',
            ))
              ActionChip(
                label: Text(material.title.split(' ').first),
                onPressed: () {
                  _fraction.text = (material.sugarFraction * 100)
                      .round()
                      .toString();
                  setState(() => _fromStarch = true);
                },
              ),
          ],
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Теоретический выход',
            value: formatVolume(theoretical),
            bold: true,
          ),
          _ResultRow(
            label: 'Практический (≈93%)',
            value: formatVolume(practical),
          ),
          _ResultRow(
            label: 'Сортировки 40%',
            value: formatVolume(practical / 0.4),
          ),
        ],
      ),
    );
  }
}

// ---------- 9. масштаб рецепта ----------

class _ScaleCalculator extends StatefulWidget {
  const _ScaleCalculator();

  @override
  State<_ScaleCalculator> createState() => _ScaleCalculatorState();
}

class _ScaleCalculatorState extends State<_ScaleCalculator> {
  final _recipe = TextEditingController(text: '20');
  final _mine = TextEditingController(text: '25');

  @override
  void dispose() {
    _recipe.dispose();
    _mine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final k = scaleFactor(
      recipeVolumeL: _parse(_recipe),
      myVolumeL: _parse(_mine),
    );
    return _CalcBody(
      fields: [
        _NumField(
          controller: _recipe,
          label: 'Объём по рецепту',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _mine,
          label: 'Мой объём',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Дрожжи и ферменты можно не масштабировать вверх — они работают '
          'с запасом.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Коэффициент',
            value: '× ${formatNumber(k, decimals: 3)}',
            bold: true,
          ),
          _ResultRow(
            label: 'Пример: 5 кг сахара',
            value: '${formatNumber(5 * k, decimals: 2)} кг',
          ),
          _ResultRow(
            label: 'Пример: 100 г дрожжей',
            value: '${formatNumber(100 * k, decimals: 0)} г',
          ),
        ],
      ),
    );
  }
}

// ---------- 10. поправка ареометра ----------

class _HydrometerCalculator extends StatefulWidget {
  const _HydrometerCalculator();

  @override
  State<_HydrometerCalculator> createState() => _HydrometerCalculatorState();
}

class _HydrometerCalculatorState extends State<_HydrometerCalculator> {
  final _reading = TextEditingController(text: '40');
  final _temp = TextEditingController(text: '25');

  @override
  void dispose() {
    _reading.dispose();
    _temp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final corrected = hydrometerCorrection(
      reading: _parse(_reading),
      tempC: _parse(_temp),
    );
    return _CalcBody(
      fields: [
        _NumField(
          controller: _reading,
          label: 'Показания спиртометра',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _temp,
          label: 'Температура раствора',
          suffix: '°C',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Приближение ±0,5 % об. Для точных замеров нужны таблицы ГОСТ; '
          'для журнала достаточно.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Крепость при 20 °C',
            value: '${formatNumber(corrected, decimals: 1)}%',
            bold: true,
          ),
          _ResultRow(
            label: 'Поправка',
            value:
                '${corrected >= _parse(_reading) ? '+' : ''}'
                '${formatNumber(corrected - _parse(_reading), decimals: 1)}%',
          ),
        ],
      ),
    );
  }
}

// ---------- 11. щепа и бочка ----------

class _ChipsCalculator extends StatefulWidget {
  const _ChipsCalculator();

  @override
  State<_ChipsCalculator> createState() => _ChipsCalculatorState();
}

class _ChipsCalculatorState extends State<_ChipsCalculator> {
  final _volume = TextEditingController(text: '3');
  final _months = TextEditingController(text: '3');
  final _barrel = TextEditingController(text: '20');

  @override
  void dispose() {
    _volume.dispose();
    _months.dispose();
    _barrel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chips = chipsEquivalentGrams(
      volumeL: _parse(_volume),
      months: _parse(_months),
    );
    final loss = angelShareLoss(
      volumeL: _parse(_barrel),
      months: _parse(_months),
      annualPercent: 3,
    );
    final volume = _parse(_volume);

    return _CalcBody(
      fields: [
        _NumField(
          controller: _volume,
          label: 'Объём дистиллята',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _months,
          label: 'Срок выдержки',
          suffix: 'мес',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _barrel,
          label: 'Объём бочки (для ангельской доли)',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Малая бочка отдаёт дуб быстрее. Потери: 2–3 % в год в прохладе, '
          'до 5 % в жаре, 10–15 % в бочках 5–10 л.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Щепы на весь объём',
            value: '${formatNumber(chips, decimals: 0)} г',
            bold: true,
          ),
          _ResultRow(
            label: 'На литр',
            value:
                '${formatNumber(volume > 0 ? chips / volume : 0, decimals: 1)} г/л',
          ),
          _ResultRow(label: 'Испарится (3 %/год)', value: formatVolume(loss)),
        ],
      ),
    );
  }
}

// ---------- 12. себестоимость ----------

class _CostCalculator extends StatefulWidget {
  const _CostCalculator();

  @override
  State<_CostCalculator> createState() => _CostCalculatorState();
}

class _CostCalculatorState extends State<_CostCalculator> {
  final _cost = TextEditingController(text: '1500');
  final _volume = TextEditingController(text: '5');
  final _abv = TextEditingController(text: '40');

  @override
  void dispose() {
    _cost.dispose();
    _volume.dispose();
    _abv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final perLiter = costPerLiterOfAlcohol(
      totalCost: _parse(_cost),
      volumeL: _parse(_volume),
      abv: _parse(_abv),
    );
    return _CalcBody(
      fields: [
        _NumField(
          controller: _cost,
          label: 'Все затраты',
          suffix: '₽',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _volume,
          label: 'Получено напитка',
          suffix: 'л',
          onChanged: () => setState(() {}),
        ),
        _NumField(
          controller: _abv,
          label: 'Крепость',
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Считаем сырьё, дрожжи, энергию и воду. Труд не учитываем — '
          'это хобби.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
            label: 'Цена литра АС',
            value: '${formatNumber(perLiter, decimals: 0)} ₽',
            bold: true,
          ),
          _ResultRow(
            label: 'Цена литра напитка',
            value:
                '${formatNumber(perLiter * _parse(_abv) / 100, decimals: 0)} ₽',
          ),
          _ResultRow(
            label: 'Цена бутылки 0,5 л',
            value:
                '${formatNumber(perLiter * _parse(_abv) / 100 * 0.5, decimals: 0)} ₽',
          ),
        ],
      ),
    );
  }
}
