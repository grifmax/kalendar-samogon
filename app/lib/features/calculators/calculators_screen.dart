import 'package:flutter/material.dart';

import '../../domain/calculators.dart';
import '../../utils/format.dart';

/// Хаб калькуляторов и сами калькуляторы.
class CalculatorsScreen extends StatelessWidget {
  const CalculatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(String, String, IconData, Widget)>[
      ('Сахарная брага', 'Вода, выход, крепость браги', Icons.grain,
          const _SugarWashCalculator()),
      ('Разбавление', 'Сколько воды до нужной крепости', Icons.water_drop,
          const _DilutionCalculator()),
      ('Фракции', 'Головы, тело, хвосты по АС', Icons.content_cut,
          const _FractionsCalculator()),
      ('Масштаб рецепта', 'Пересчёт под свой объём', Icons.aspect_ratio,
          const _ScaleCalculator()),
      ('Поправка ареометра', 'Показания к 20 °C', Icons.thermostat,
          const _HydrometerCalculator()),
      ('Щепа и бочка', 'Эквивалент щепы, ангельская доля', Icons.inventory_2,
          const _ChipsCalculator()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Калькуляторы')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (title, subtitle, icon, screen) = items[i];
          return Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Icon(icon),
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text(title)),
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: screen,
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

/// Общая обёртка калькулятора: поля и блок результата.
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
        if (result != null) ...[
          const SizedBox(height: 24),
          Card(
            margin: EdgeInsets.zero,
            color: theme.colorScheme.primary.withValues(alpha: 0.10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: result!,
            ),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (_) => onChanged?.call(),
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffix,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label, style: theme.textTheme.bodyMedium)),
          const SizedBox(width: 12),
          Text(
            value,
            style: (bold ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium)
                ?.copyWith(fontWeight: bold ? FontWeight.w700 : FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

double _parse(TextEditingController c) =>
    double.tryParse(c.text.replaceAll(',', '.')) ?? 0;

// ---------- сахарная брага ----------
class _SugarWashCalculator extends StatefulWidget {
  const _SugarWashCalculator();

  @override
  State<_SugarWashCalculator> createState() => _SugarWashCalculatorState();
}

class _SugarWashCalculatorState extends State<_SugarWashCalculator> {
  final _sugar = TextEditingController(text: '5');
  final _hydro = TextEditingController(text: '4');

  @override
  void dispose() {
    _sugar.dispose();
    _hydro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plan = sugarWashPlan(
      sugarKg: _parse(_sugar),
      hydromodule: _parse(_hydro) > 0 ? _parse(_hydro) : 4,
    );
    return _CalcBody(
      fields: [
        _NumberField(
          controller: _sugar,
          label: 'Сахар',
          suffix: 'кг',
          onChanged: () => setState(() {}),
        ),
        _NumberField(
          controller: _hydro,
          label: 'Гидромодуль (1 к N)',
          suffix: 'N',
          onChanged: () => setState(() {}),
        ),
        Text(
          'Гидромодуль 1:4 — стандарт. 1:5 бродит чище, но дольше.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(label: 'Вода', value: formatVolume(plan.waterL), bold: true),
          _ResultRow(
              label: 'Объём браги',
              value: formatVolume(plan.totalVolumeL)),
          _ResultRow(
              label: 'Крепость браги',
              value: '${formatNumber(plan.expectedWashAbv, decimals: 1)}%'),
          _ResultRow(
              label: 'Выход АС (теория)',
              value: formatVolume(plan.theoreticalAlcoholL)),
          _ResultRow(
              label: 'Выход АС (практика)',
              value: formatVolume(plan.practicalAlcoholL),
              bold: true),
          _ResultRow(
              label: 'Спирта 40% после разбавления',
              value: formatVolume(plan.practicalAlcoholL / 0.4)),
        ],
      ),
    );
  }
}

// ---------- разбавление ----------
class _DilutionCalculator extends StatefulWidget {
  const _DilutionCalculator();

  @override
  State<_DilutionCalculator> createState() => _DilutionCalculatorState();
}

class _DilutionCalculatorState extends State<_DilutionCalculator> {
  final _volume = TextEditingController(text: '5');
  final _from = TextEditingController(text: '70');
  final _to = TextEditingController(text: '40');

  @override
  void dispose() {
    _volume.dispose();
    _from.dispose();
    _to.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final water = dilutionWater(
      volumeL: _parse(_volume),
      fromAbv: _parse(_from),
      toAbv: _parse(_to),
    );
    final total = dilutedVolume(
      volumeL: _parse(_volume),
      fromAbv: _parse(_from),
      toAbv: _parse(_to),
    );
    return _CalcBody(
      fields: [
        _NumberField(
            controller: _volume,
            label: 'Объём спирта',
            suffix: 'л',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _from,
            label: 'Текущая крепость',
            suffix: '%',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _to,
            label: 'Нужная крепость',
            suffix: '%',
            onChanged: () => setState(() {})),
        Text(
          'Спирт вливать в воду, не наоборот. После разбавления дать отдохнуть '
          '3–7 дней.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(label: 'Добавить воды', value: formatVolume(water), bold: true),
          _ResultRow(label: 'Итоговый объём', value: formatVolume(total)),
        ],
      ),
    );
  }
}

// ---------- фракции ----------
class _FractionsCalculator extends StatefulWidget {
  const _FractionsCalculator();

  @override
  State<_FractionsCalculator> createState() => _FractionsCalculatorState();
}

class _FractionsCalculatorState extends State<_FractionsCalculator> {
  final _volume = TextEditingController(text: '20');
  final _abv = TextEditingController(text: '25');
  final _heads = TextEditingController(text: '9');

  @override
  void dispose() {
    _volume.dispose();
    _abv.dispose();
    _heads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plan = fractionsPlan(
      rawVolumeL: _parse(_volume),
      rawAbv: _parse(_abv),
      headsPercent: _parse(_heads) > 0 ? _parse(_heads) : 9,
    );
    return _CalcBody(
      fields: [
        _NumberField(
            controller: _volume,
            label: 'Объём спирта-сырца',
            suffix: 'л',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _abv,
            label: 'Крепость сырца',
            suffix: '%',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _heads,
            label: 'Головы, % от АС',
            suffix: '%',
            onChanged: () => setState(() {})),
        Text(
          'Сахар и зерно — 8–10%, фрукты — 10–15%. Тело отбирать до 45–50% '
          'в струе.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
              label: 'Абсолютный спирт',
              value: formatVolume(plan.absoluteAlcoholL)),
          _ResultRow(
              label: 'Головы', value: formatVolume(plan.headsL), bold: true),
          _ResultRow(
              label: 'Тело (АС)', value: formatVolume(plan.heartsL), bold: true),
          _ResultRow(label: 'Хвосты (АС)', value: formatVolume(plan.tailsL)),
        ],
      ),
    );
  }
}

// ---------- масштаб ----------
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
        _NumberField(
            controller: _recipe,
            label: 'Объём по рецепту',
            suffix: 'л',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _mine,
            label: 'Мой объём',
            suffix: 'л',
            onChanged: () => setState(() {})),
        Text(
          'Умножьте каждый ингредиент на коэффициент. Дрожжи и ферменты '
          'можно не масштабировать вверх — они работают с запасом.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
              label: 'Коэффициент',
              value: '× ${formatNumber(k, decimals: 3)}',
              bold: true),
          _ResultRow(
              label: 'Пример: 5 кг сахара',
              value: '${formatNumber(5 * k, decimals: 2)} кг'),
          _ResultRow(
              label: 'Пример: 100 г дрожжей',
              value: '${formatNumber(100 * k, decimals: 0)} г'),
        ],
      ),
    );
  }
}

// ---------- ареометр ----------
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
        _NumberField(
            controller: _reading,
            label: 'Показания спиртометра',
            suffix: '%',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _temp,
            label: 'Температура раствора',
            suffix: '°C',
            onChanged: () => setState(() {})),
        Text(
          'Приближение ±0,5% об. Для точных замеров нужны таблицы ГОСТ; '
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
              bold: true),
        ],
      ),
    );
  }
}

// ---------- щепа ----------
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
    return _CalcBody(
      fields: [
        _NumberField(
            controller: _volume,
            label: 'Объём дистиллята',
            suffix: 'л',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _months,
            label: 'Желаемый срок выдержки',
            suffix: 'мес',
            onChanged: () => setState(() {})),
        _NumberField(
            controller: _barrel,
            label: 'Объём бочки (для ангельской доли)',
            suffix: 'л',
            onChanged: () => setState(() {})),
        Text(
          'Малая бочка отдаёт дуб быстрее. Потери в год: 2–3% в прохладе, '
          'до 5% в жаре, 10–15% в бочках 5–10 л.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultRow(
              label: 'Щепы на весь объём',
              value: '${formatNumber(chips, decimals: 0)} г',
              bold: true),
          _ResultRow(
              label: 'На литр',
              value: '${formatNumber(chips / (_parse(_volume) > 0 ? _parse(_volume) : 1), decimals: 1)} г/л'),
          _ResultRow(
              label: 'Испарится за срок (3%/год)',
              value: formatVolume(loss)),
        ],
      ),
    );
  }
}
