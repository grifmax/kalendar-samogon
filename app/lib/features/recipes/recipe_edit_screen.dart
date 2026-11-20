import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../utils/format.dart';
import '../../widgets/form_fields.dart';

/// Строка состава в редакторе.
class _IngredientRow {
  _IngredientRow({String name = '', String amount = '', this.unit = 'г'})
      : nameController = TextEditingController(text: name),
        amountController = TextEditingController(text: amount);

  final TextEditingController nameController;
  final TextEditingController amountController;
  String unit;

  double get amount =>
      double.tryParse(amountController.text.replaceAll(',', '.')) ?? 0;

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}

/// Строка шага в редакторе.
class _StepRow {
  _StepRow({
    String title = '',
    String description = '',
    String day = '0',
    String minutes = '',
    String temp = '',
    String repeatEvery = '',
    String repeatUntil = '',
    String repeatTitle = '',
    this.eventKind = 'check',
  })  : titleController = TextEditingController(text: title),
        descriptionController = TextEditingController(text: description),
        dayController = TextEditingController(text: day),
        minutesController = TextEditingController(text: minutes),
        tempController = TextEditingController(text: temp),
        repeatEveryController = TextEditingController(text: repeatEvery),
        repeatUntilController = TextEditingController(text: repeatUntil),
        repeatTitleController = TextEditingController(text: repeatTitle);

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dayController;
  final TextEditingController minutesController;
  final TextEditingController tempController;
  final TextEditingController repeatEveryController;
  final TextEditingController repeatUntilController;
  final TextEditingController repeatTitleController;
  String eventKind;

  int? get repeatEvery {
    final v = int.tryParse(repeatEveryController.text.trim());
    return v != null && v > 0 ? v : null;
  }

  int? get repeatUntil {
    final v = int.tryParse(repeatUntilController.text.trim());
    return v != null && v > 0 ? v : null;
  }

  /// Повтор задан, только если указаны и шаг, и последний день.
  bool get hasRepeat => repeatEvery != null && repeatUntil != null;

  int get day => int.tryParse(dayController.text.trim()) ?? 0;
  int? get minutes {
    final v = int.tryParse(minutesController.text.trim());
    return v != null && v > 0 ? v : null;
  }

  double? get temp {
    final v = double.tryParse(tempController.text.replaceAll(',', '.'));
    return v != null && v > 0 ? v : null;
  }

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dayController.dispose();
    minutesController.dispose();
    tempController.dispose();
    repeatEveryController.dispose();
    repeatUntilController.dispose();
    repeatTitleController.dispose();
  }
}

/// Редактор своего рецепта: создание и правка.
///
/// Встроенные рецепты не редактируются — их можно только скопировать
/// кнопкой «Сохранить как свой» в карточке рецепта.
class RecipeEditScreen extends StatefulWidget {
  const RecipeEditScreen({super.key, this.recipeId});

  /// null — создание нового рецепта.
  final String? recipeId;

  @override
  State<RecipeEditScreen> createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends State<RecipeEditScreen> {
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _volumeController = TextEditingController(text: '3');
  final _yieldController = TextEditingController();
  final _abvController = TextEditingController(text: '40');

  String _kind = 'tincture';
  final List<_IngredientRow> _ingredients = [];
  final List<_StepRow> _steps = [];
  bool _loading = true;
  bool _isBuiltIn = false;

  /// Объём, под который посчитан текущий состав. При смене объёма количества
  /// пересчитываются пропорционально: рецепт — это соотношения, а не
  /// абсолютные граммы, иначе «сделать 5 л вместо 3» даёт ту же закладку
  /// в большей банке и слабый напиток.
  double _amountsVolumeL = 3;

  static const _units = ['г', 'кг', 'мл', 'л', 'шт'];

  static const _eventKinds = {
    'start': 'Начало',
    'check': 'Проверка',
    'measurement': 'Замер',
    'rack': 'Слить с осадка',
    'distill': 'Перегонка',
    'cut': 'Отбор фракций',
    'macerate': 'Настаивание',
    'strain': 'Фильтрация',
    'sweeten': 'Сахар/сироп',
    'barrel': 'В тару',
    'topup': 'Доливка',
    'taste': 'Дегустация',
    'bottle': 'Розлив',
  };

  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // AppScope доступен только здесь: в initState обращение к InheritedWidget
    // запрещено — на этом падал экран правки в отладочной сборке.
    if (_started) return;
    _started = true;
    _load();
  }

  Future<void> _load() async {
    final id = widget.recipeId;
    if (id == null) {
      _ingredients.add(_IngredientRow());
      _steps.add(_StepRow());
      setState(() => _loading = false);
      return;
    }
    final scope = AppScope.of(context);
    final recipe = await scope.recipes.byId(id);
    final ingredients = await scope.recipes.ingredients(id);
    final steps = await scope.recipes.steps(id);
    if (!mounted) return;

    setState(() {
      if (recipe != null) {
        _titleController.text = recipe.title;
        _summaryController.text = recipe.summary;
        _volumeController.text = formatNumber(recipe.baseVolumeL);
        if (recipe.baseVolumeL > 0) _amountsVolumeL = recipe.baseVolumeL;
        _yieldController.text = recipe.expectedYieldL > 0
            ? formatNumber(recipe.expectedYieldL)
            : '';
        _abvController.text = formatNumber(recipe.expectedAbv, decimals: 0);
        _kind = recipe.kind;
        _isBuiltIn = recipe.isBuiltIn;
      }
      for (final ing in ingredients) {
        _ingredients.add(_IngredientRow(
          name: ing.name,
          amount: formatNumber(ing.amount),
          unit: ing.unit,
        ));
      }
      for (final step in steps) {
        _steps.add(_StepRow(
          title: step.title,
          description: step.description,
          day: step.offsetDays.toString(),
          minutes: step.durationMin?.toString() ?? '',
          temp: step.tempC == null ? '' : formatNumber(step.tempC!),
          repeatEvery: step.repeatEveryDays?.toString() ?? '',
          repeatUntil: step.repeatUntilDay?.toString() ?? '',
          repeatTitle: step.repeatTitle,
          eventKind: step.eventKind,
        ));
      }
      if (_ingredients.isEmpty) _ingredients.add(_IngredientRow());
      if (_steps.isEmpty) _steps.add(_StepRow());
      _loading = false;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    _volumeController.dispose();
    _yieldController.dispose();
    _abvController.dispose();
    for (final row in _ingredients) {
      row.dispose();
    }
    for (final row in _steps) {
      row.dispose();
    }
    super.dispose();
  }

  /// Пересчитать количества при смене объёма рецепта.
  ///
  /// Считаем от объёма, под который состав был посчитан в прошлый раз, и
  /// запоминаем новый: при наборе «3» → «3,5» пересчёт идёт один раз за
  /// нажатие, но произведение отношений даёт правильный итог.
  void _onVolumeChanged() {
    final next = double.tryParse(
      _volumeController.text.replaceAll(',', '.'),
    );
    if (next == null || next <= 0 || _isBuiltIn) {
      setState(() {});
      return;
    }
    if (_amountsVolumeL <= 0) {
      _amountsVolumeL = next;
      setState(() {});
      return;
    }
    if ((next - _amountsVolumeL).abs() < 0.0001) {
      setState(() {});
      return;
    }

    final ratio = next / _amountsVolumeL;
    for (final row in _ingredients) {
      final amount = double.tryParse(
        row.amountController.text.replaceAll(',', '.'),
      );
      if (amount == null || amount <= 0) continue;
      row.amountController.text = formatNumber(amount * ratio, decimals: 2);
    }
    _amountsVolumeL = next;
    setState(() {});
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Укажите название рецепта')),
      );
      return;
    }

    final scope = AppScope.of(context);
    final ingredients = [
      for (final row in _ingredients)
        if (row.nameController.text.trim().isNotEmpty && row.amount > 0)
          (
            name: row.nameController.text.trim(),
            amount: row.amount,
            unit: row.unit,
            note: '',
          ),
    ];
    final steps = [
      for (final row in _steps)
        if (row.titleController.text.trim().isNotEmpty)
          (
            title: row.titleController.text.trim(),
            description: row.descriptionController.text.trim(),
            offsetDays: row.day,
            durationMin: row.minutes,
            tempC: row.temp,
            eventKind: row.eventKind,
            repeatEveryDays: row.hasRepeat ? row.repeatEvery : null,
            repeatUntilDay: row.hasRepeat ? row.repeatUntil : null,
            repeatTitle: row.hasRepeat ? row.repeatTitleController.text.trim() : '',
          ),
    ];

    final volume = double.tryParse(
          _volumeController.text.replaceAll(',', '.'),
        ) ??
        0;
    final yieldL = double.tryParse(
          _yieldController.text.replaceAll(',', '.'),
        ) ??
        0;
    final abv = double.tryParse(
          _abvController.text.replaceAll(',', '.'),
        ) ??
        0;

    try {
      if (widget.recipeId == null) {
        await scope.recipes.createRecipe(
          title: title,
          kind: _kind,
          summary: _summaryController.text.trim(),
          baseVolumeL: volume,
          expectedYieldL: yieldL,
          expectedAbv: abv,
          ingredients: ingredients,
          steps: steps,
        );
      } else {
        await scope.recipes.updateRecipe(
          id: widget.recipeId!,
          title: title,
          kind: _kind,
          summary: _summaryController.text.trim(),
          baseVolumeL: volume,
          expectedYieldL: yieldL,
          expectedAbv: abv,
          ingredients: ingredients,
          steps: steps,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось сохранить: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeId == null ? 'Свой рецепт' : 'Правка рецепта'),
        actions: [
          IconButton(
            tooltip: 'Сохранить',
            icon: const Icon(Icons.check),
            onPressed: _isBuiltIn ? null : _save,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          if (_isBuiltIn)
            Padding(
              padding: const EdgeInsets.only(bottom: FormSpacing.field),
              child: Text(
                'Встроенный рецепт изменить нельзя. Создайте свой на его основе.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          FormNumberField(
            controller: _titleController,
            label: 'Название',
            suffix: '',
            onChanged: () => setState(() {}),
          ),
          FormSectionTitle(
            title: 'Тип',
            hint: 'Что это за рецепт',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final entry in kRecipeKindLabels.entries)
                ChoiceChip(
                  label: Text(entry.value),
                  selected: _kind == entry.key,
                  onSelected: (_) => setState(() => _kind = entry.key),
                ),
            ],
          ),
          const SizedBox(height: FormSpacing.chipsToField),
          FormNumberField(
            controller: _summaryController,
            label: 'Краткое описание',
            suffix: '',
            onChanged: () => setState(() {}),
          ),
          const SizedBox(height: FormSpacing.sectionAfterField),
          const FormSectionTitle(title: 'Объёмы'),
          FormNumberField(
            controller: _volumeController,
            label: 'Объём по рецепту',
            suffix: 'л',
            onChanged: _onVolumeChanged,
            hint: _amountsVolumeL > 0
                ? 'Состав пересчитан на '
                      '${formatNumber(_amountsVolumeL, decimals: 2)} л'
                : null,
          ),
          FormNumberField(
            controller: _yieldController,
            label: 'Ожидаемый выход',
            suffix: 'л',
            onChanged: () => setState(() {}),
          ),
          FormNumberField(
            controller: _abvController,
            label: 'Крепость',
            suffix: '%',
            onChanged: () => setState(() {}),
          ),
          const SizedBox(height: FormSpacing.sectionAfterField),
          Row(
            children: [
              Expanded(
                child: FormSectionTitle(
                  title: 'Состав',
                  hint: '${_ingredients.length} поз.',
                ),
              ),
              IconButton(
                tooltip: 'Добавить ингредиент',
                icon: const Icon(Icons.add_circle_outline),
                onPressed: _isBuiltIn
                    ? null
                    : () => setState(
                          () => _ingredients.add(_IngredientRow()),
                        ),
              ),
            ],
          ),
          for (var i = 0; i < _ingredients.length; i++)
            _IngredientEditor(
              row: _ingredients[i],
              units: _units,
              enabled: !_isBuiltIn,
              onChanged: () => setState(() {}),
              onRemove: _ingredients.length > 1
                  ? () => setState(() {
                        _ingredients.removeAt(i).dispose();
                      })
                  : null,
            ),
          const SizedBox(height: FormSpacing.sectionAfterField),
          Row(
            children: [
              Expanded(
                child: FormSectionTitle(
                  title: 'Шаги',
                  hint: 'Из них строятся события календаря',
                ),
              ),
              IconButton(
                tooltip: 'Добавить шаг',
                icon: const Icon(Icons.add_circle_outline),
                onPressed: _isBuiltIn
                    ? null
                    : () => setState(() => _steps.add(_StepRow())),
              ),
            ],
          ),
          for (var i = 0; i < _steps.length; i++)
            _StepEditor(
              row: _steps[i],
              eventKinds: _eventKinds,
              enabled: !_isBuiltIn,
              onChanged: () => setState(() {}),
              onRemove: _steps.length > 1
                  ? () => setState(() {
                        _steps.removeAt(i).dispose();
                      })
                  : null,
            ),
          if (_isBuiltIn) ...[
            const SizedBox(height: FormSpacing.section),
            FilledButton.tonalIcon(
              onPressed: _saveAsOwn,
              icon: const Icon(Icons.copy_all),
              label: const Text('Сохранить как свой'),
            ),
          ],
        ],
      ),
    );
  }

  /// Скопировать встроенный рецепт в свой и открыть его на правку.
  Future<void> _saveAsOwn() async {
    final scope = AppScope.of(context);
    final ingredients = [
      for (final row in _ingredients)
        if (row.nameController.text.trim().isNotEmpty && row.amount > 0)
          (
            name: row.nameController.text.trim(),
            amount: row.amount,
            unit: row.unit,
            note: '',
          ),
    ];
    final steps = [
      for (final row in _steps)
        if (row.titleController.text.trim().isNotEmpty)
          (
            title: row.titleController.text.trim(),
            description: row.descriptionController.text.trim(),
            offsetDays: row.day,
            durationMin: row.minutes,
            tempC: row.temp,
            eventKind: row.eventKind,
            repeatEveryDays: row.hasRepeat ? row.repeatEvery : null,
            repeatUntilDay: row.hasRepeat ? row.repeatUntil : null,
            repeatTitle: row.hasRepeat ? row.repeatTitleController.text.trim() : '',
          ),
    ];

    final newId = await scope.recipes.createRecipe(
      title: '${_titleController.text.trim()} (мой)',
      kind: _kind,
      summary: _summaryController.text.trim(),
      baseVolumeL: double.tryParse(
            _volumeController.text.replaceAll(',', '.'),
          ) ??
          0,
      expectedYieldL: double.tryParse(
            _yieldController.text.replaceAll(',', '.'),
          ) ??
          0,
      expectedAbv: double.tryParse(
            _abvController.text.replaceAll(',', '.'),
          ) ??
          0,
      ingredients: ingredients,
      steps: steps,
    );
    if (!mounted) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<bool>(
        builder: (_) => RecipeEditScreen(recipeId: newId),
      ),
    );
  }
}

/// Редактор одной строки состава.
class _IngredientEditor extends StatelessWidget {
  const _IngredientEditor({
    required this.row,
    required this.units,
    required this.enabled,
    required this.onChanged,
    this.onRemove,
  });

  final _IngredientRow row;
  final List<String> units;
  final bool enabled;
  final VoidCallback onChanged;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: FormSpacing.field),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: TextField(
              controller: row.nameController,
              enabled: enabled,
              onChanged: (_) => onChanged(),
              decoration: const InputDecoration(
                labelText: 'Ингредиент',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextField(
              controller: row.amountController,
              enabled: enabled,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => onChanged(),
              decoration: const InputDecoration(
                labelText: 'Кол-во',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            // 88 px и isExpanded: со стандартными отступами поля 72 px не
            // хватало, и строка состава переполнялась на узких экранах.
            width: 88,
            child: DropdownButtonFormField<String>(
              initialValue: units.contains(row.unit) ? row.unit : units.first,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Ед.',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 14, 4, 14),
              ),
              items: [
                for (final unit in units)
                  DropdownMenuItem(value: unit, child: Text(unit)),
              ],
              onChanged: enabled
                  ? (value) {
                      if (value != null) {
                        row.unit = value;
                        onChanged();
                      }
                    }
                  : null,
            ),
          ),
          if (onRemove != null)
            IconButton(
              tooltip: 'Убрать',
              icon: const Icon(Icons.close, size: 18),
              onPressed: enabled ? onRemove : null,
            ),
        ],
      ),
    );
  }
}

/// Редактор одного шага.
class _StepEditor extends StatelessWidget {
  const _StepEditor({
    required this.row,
    required this.eventKinds,
    required this.enabled,
    required this.onChanged,
    this.onRemove,
  });

  final _StepRow row;
  final Map<String, String> eventKinds;
  final bool enabled;
  final VoidCallback onChanged;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: FormSpacing.field),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: row.titleController,
                    enabled: enabled,
                    onChanged: (_) => onChanged(),
                    decoration: const InputDecoration(
                      labelText: 'Название шага',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                if (onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: enabled ? onRemove : null,
                  ),
              ],
            ),
            const SizedBox(height: FormSpacing.fieldToHint),
            TextField(
              controller: row.descriptionController,
              enabled: enabled,
              maxLines: 2,
              onChanged: (_) => onChanged(),
              decoration: const InputDecoration(
                labelText: 'Что делать',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: FormSpacing.fieldToHint),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: row.dayController,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => onChanged(),
                    decoration: const InputDecoration(
                      labelText: 'День',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: row.minutesController,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Минут',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: row.tempController,
                    enabled: enabled,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: '°C',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: FormSpacing.fieldToHint),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: row.repeatEveryController,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => onChanged(),
                    decoration: const InputDecoration(
                      labelText: 'Повтор, дн.',
                      helperText: 'пусто — без повтора',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: row.repeatUntilController,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => onChanged(),
                    decoration: const InputDecoration(
                      labelText: 'До дня',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            if (row.hasRepeat) ...[
              const SizedBox(height: FormSpacing.fieldToHint),
              TextField(
                controller: row.repeatTitleController,
                enabled: enabled,
                onChanged: (_) => onChanged(),
                decoration: const InputDecoration(
                  labelText: 'Название повтора',
                  hintText: 'Взболтать',
                  helperText: 'Так подпишутся повторные события, а не первое',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ],
            const SizedBox(height: FormSpacing.fieldToHint),
            DropdownButtonFormField<String>(
              initialValue:
                  eventKinds.containsKey(row.eventKind) ? row.eventKind : 'check',
              decoration: const InputDecoration(
                labelText: 'Тип события',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              items: [
                for (final entry in eventKinds.entries)
                  DropdownMenuItem(value: entry.key, child: Text(entry.value)),
              ],
              onChanged: enabled
                  ? (value) {
                      if (value != null) {
                        row.eventKind = value;
                        onChanged();
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
