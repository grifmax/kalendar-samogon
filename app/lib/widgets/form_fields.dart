import 'package:flutter/material.dart';

/// Вертикальный ритм форм.
///
/// Отступы заданы в одном месте, чтобы поля, заголовки секций и подсказки
/// не «слипались» и не разъезжались между экранами: раньше в каждом виджете
/// был свой произвольный SizedBox.
class FormSpacing {
  FormSpacing._();

  /// Между полями ввода внутри одной группы.
  ///
  /// Больше обычных 8–12, потому что плавающая подпись outlined-поля живёт
  /// ВЫШЕ рамки: при меньшем зазоре подпись следующего поля визуально
  /// прилипает к предыдущему полю.
  static const double field = 18;

  /// От заголовка секции до первого поля.
  static const double titleToField = 12;

  /// Между заголовком секции и его пояснением.
  static const double titleToHint = 3;

  /// Между секциями.
  static const double section = 30;

  /// Дополнительный отступ перед новой секцией, когда предыдущий элемент —
  /// поле (оно уже дало [field] снизу): field + sectionAfterField = section.
  static const double sectionAfterField = section - field;

  /// Между рядом чипов и полем под ним.
  static const double chipsToField = 20;

  /// Между полем и подсказкой под ним (норма дозы, поправка).
  static const double fieldToHint = 6;

  /// Внутри блока результата.
  static const double resultRow = 4;

  /// Отступ карточки результата от полей.
  static const double toResult = 20;
}

/// Заголовок секции формы: название и необязательное пояснение.
class FormSectionTitle extends StatelessWidget {
  const FormSectionTitle({super.key, required this.title, this.hint});

  final String title;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: FormSpacing.titleToField),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleSmall),
          if (hint != null && hint!.isNotEmpty) ...[
            const SizedBox(height: FormSpacing.titleToHint),
            Text(
              hint!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Числовое поле формы с единицей измерения справа.
///
/// Подсказка под полем (норма дозы, поправка) живёт внутри того же отступа,
/// что и само поле: иначе между полем и подсказкой появляется лишний зазор,
/// а между подсказкой и следующим полем — слишком маленький.
class FormNumberField extends StatelessWidget {
  const FormNumberField({
    super.key,
    required this.controller,
    required this.label,
    required this.suffix,
    this.onChanged,
    this.hint,
    this.hintIcon,
    this.hintIsWarning = false,
    this.bottomPadding = FormSpacing.field,
  });

  final TextEditingController controller;
  final String label;
  final String suffix;
  final VoidCallback? onChanged;

  /// Строка под полем: норма, поправка, предупреждение.
  final String? hint;
  final IconData? hintIcon;

  /// Подсказка красным (предупреждение), иначе приглушённым.
  final bool hintIsWarning;

  /// Нижний отступ: 0, когда поле стоит в ряду с соседом и отступ даёт ряд.
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintText = hint;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onChanged?.call(),
            decoration: InputDecoration(
              labelText: label,
              suffixText: suffix,
              border: const OutlineInputBorder(),
              isDense: true,
              // Плавающая подпись не должна прилипать к рамке.
              contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
            ),
          ),
          if (hintText != null && hintText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: FormSpacing.fieldToHint),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hintIcon != null) ...[
                    Icon(
                      hintIcon,
                      size: 15,
                      color: hintIsWarning
                          ? theme.colorScheme.error
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      hintText,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: hintIsWarning
                            ? theme.colorScheme.error
                            : theme.colorScheme.onSurfaceVariant,
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
