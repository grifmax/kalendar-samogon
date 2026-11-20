import 'package:flutter/material.dart';

/// Форматирование дат и подписи — без intl, чтобы не зависеть от загрузки
/// символов локали: русские названия месяцев и дней заданы явно.

const List<String> kMonthsNominative = [
  'январь', 'февраль', 'март', 'апрель', 'май', 'июнь',
  'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь',
];

const List<String> kMonthsGenitive = [
  'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
  'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря',
];

/// Понедельник — первый день недели.
const List<String> kWeekdaysShort = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

/// «19 ноября»
String formatDayMonth(DateTime date) =>
    '${date.day} ${kMonthsGenitive[date.month - 1]}';

/// «19 ноября 2026»
String formatFullDate(DateTime date) =>
    '${date.day} ${kMonthsGenitive[date.month - 1]} ${date.year}';

/// «19.11.2026»
String formatNumeric(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}.'
    '${date.month.toString().padLeft(2, '0')}.${date.year}';

/// «10:00»
String formatTime(DateTime date) =>
    '${date.hour.toString().padLeft(2, '0')}:'
    '${date.minute.toString().padLeft(2, '0')}';

/// Склонение: 1 день, 2 дня, 5 дней.
String plural(int n, String one, String few, String many) {
  final abs = n.abs() % 100;
  if (abs >= 11 && abs <= 14) return many;
  switch (abs % 10) {
    case 1:
      return one;
    case 2:
    case 3:
    case 4:
      return few;
    default:
      return many;
  }
}

/// «сегодня», «завтра», «через 3 дня», «просрочено на 2 дня».
String relativeDay(DateTime date, {DateTime? now}) {
  final today = _dateOnly(now ?? DateTime.now());
  final target = _dateOnly(date);
  final diff = target.difference(today).inDays;
  if (diff == 0) return 'сегодня';
  if (diff == 1) return 'завтра';
  if (diff == 2) return 'послезавтра';
  if (diff > 2) return 'через $diff ${plural(diff, 'день', 'дня', 'дней')}';
  final overdue = -diff;
  if (overdue == 1) return 'просрочено на день';
  return 'просрочено на $overdue ${plural(overdue, 'день', 'дня', 'дней')}';
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Сколько дней партия в работе.
int daysSince(DateTime startedAt, {DateTime? now}) =>
    _dateOnly(now ?? DateTime.now()).difference(_dateOnly(startedAt)).inDays;

// ---------- подписи типов ----------

/// Названия типов рецептов.
const Map<String, String> kRecipeKindLabels = {
  'mash': 'Брага',
  'distillate': 'Перегонка',
  'tincture': 'Настойка',
  'liqueur': 'Ликёр',
  'aging': 'Выдержка',
  'gin': 'Джин',
  'rectification': 'Ректификация',
};

/// Названия статусов партии.
const Map<String, String> kBatchStatusLabels = {
  'planned': 'Запланирована',
  'fermenting': 'Бродит',
  'distilling': 'Перегонка',
  'aging': 'Настаивается',
  'ready': 'Готова',
  'bottled': 'В бутылках',
  'done': 'Завершена',
  'failed': 'Испорчена',
};

/// Иконки типов рецептов.
const Map<String, IconData> kRecipeKindIcons = {
  'mash': Icons.grain,
  'distillate': Icons.science,
  'tincture': Icons.local_drink,
  'liqueur': Icons.wine_bar,
  'aging': Icons.inventory_2,
  'gin': Icons.spa,
  'rectification': Icons.filter_alt,
};

/// Иконки видов событий.
const Map<String, IconData> kEventKindIcons = {
  'start': Icons.play_arrow,
  'check': Icons.check_circle_outline,
  'measurement': Icons.straighten,
  'rack': Icons.swap_vert,
  'distill': Icons.local_fire_department,
  'cut': Icons.content_cut,
  'macerate': Icons.hourglass_bottom,
  'strain': Icons.filter_alt_outlined,
  'sweeten': Icons.icecream,
  'barrel': Icons.inventory_2_outlined,
  'topup': Icons.add_circle_outline,
  'taste': Icons.wine_bar_outlined,
  'bottle': Icons.liquor,
  'custom': Icons.push_pin_outlined,
};

IconData eventIcon(String kind) => kEventKindIcons[kind] ?? Icons.event;

/// Число с разделителем и без лишних нулей: 4.0 → «4», 4.25 → «4,25».
String formatNumber(double value, {int decimals = 2}) {
  if (value == value.roundToDouble()) return value.round().toString();
  var s = value.toStringAsFixed(decimals);
  s = s.replaceAll(RegExp(r'0+$'), '');
  s = s.replaceAll(RegExp(r'\.$'), '');
  return s.replaceAll('.', ',');
}

/// «4,5 л», «250 мл».
String formatVolume(double litres) {
  if (litres <= 0) return '—';
  if (litres < 1) return '${(litres * 1000).round()} мл';
  return '${formatNumber(litres, decimals: 2)} л';
}
