import 'package:drift/drift.dart';

/// Таблицы локальной базы. Полная схема — docs/DATA_MODEL.md.
///
/// M1 содержит ядро: рецепты, партии, события календаря, замеры.
/// Перегонки, тара, выдержка и дегустации добавятся в M2 отдельной миграцией.

/// Рецепт — шаблон процесса.
class Recipes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get kind => text()();

  /// Теги стиля в JSON-массиве: ["сахарная", "быстрая"].
  TextColumn get styleTags => text().withDefault(const Constant('[]'))();
  RealColumn get baseVolumeL => real().withDefault(const Constant(0))();
  RealColumn get expectedYieldL => real().withDefault(const Constant(0))();
  RealColumn get expectedAbv => real().withDefault(const Constant(0))();
  TextColumn get summary => text().withDefault(const Constant(''))();
  TextColumn get source => text().withDefault(const Constant(''))();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Состав рецепта.
class RecipeIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recipeId =>
      text().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get name => text()();
  RealColumn get amount => real()();
  TextColumn get unit => text()();
  TextColumn get note => text().withDefault(const Constant(''))();
}

/// Шаг рецепта. `offsetDays` — день от старта партии, из него строятся события.
class RecipeSteps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recipeId =>
      text().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get offsetDays => integer().withDefault(const Constant(0))();
  IntColumn get durationMin => integer().nullable()();
  RealColumn get tempC => real().nullable()();
  TextColumn get eventKind => text().withDefault(const Constant('check'))();

  /// Повторяющийся шаг: каждые N дней до дня `repeatUntilDay`.
  IntColumn get repeatEveryDays => integer().nullable()();
  IntColumn get repeatUntilDay => integer().nullable()();
}

/// Партия — конкретное воплощение рецепта.
@DataClassName('Batch')
class Batches extends Table {
  TextColumn get id => text()();
  TextColumn get recipeId => text().references(Recipes, #id)();

  /// Человекочитаемый номер: «Б-01».
  TextColumn get code => text().withDefault(const Constant(''))();
  TextColumn get title => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  RealColumn get volumeL => real().withDefault(const Constant(0))();
  RealColumn get abv => real().withDefault(const Constant(0))();

  /// planned | fermenting | distilling | aging | ready | bottled | done | failed
  TextColumn get status => text().withDefault(const Constant('fermenting'))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Событие календаря: плановое или фактическое действие по партии.
class BatchEvents extends Table {
  TextColumn get id => text()();
  TextColumn get batchId =>
      text().references(Batches, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get plannedAt => dateTime()();
  DateTimeColumn get actualAt => dateTime().nullable()();

  /// planned | done | skipped
  TextColumn get status => text().withDefault(const Constant('planned'))();
  IntColumn get remindBeforeMin => integer().withDefault(const Constant(0))();
  IntColumn get notificationId => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Замер: плотность, температура, крепость и т.п.
class Measurements extends Table {
  TextColumn get id => text()();
  TextColumn get batchId =>
      text().references(Batches, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get at => dateTime()();

  /// sg | brix | temp | abv | ph | sugar
  TextColumn get kind => text()();
  RealColumn get value => real()();
  TextColumn get note => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Служебные значения: версия схемы, дата бэкапа, признак сида.
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

/// Состав конкретной партии — снимок рецепта с правками пользователя.
///
/// Нужен, чтобы правка рецепта перед запуском не терялась: в партии хранится
/// то, что реально заложено, а не то, что написано в шаблоне.
@DataClassName('BatchIngredient')
class BatchIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get batchId =>
      text().references(Batches, #id, onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get name => text()();
  RealColumn get amount => real()();
  TextColumn get unit => text()();
  TextColumn get note => text().withDefault(const Constant(''))();
}

/// Перегонка партии: один прогон куба.
@DataClassName('Run')
class Runs extends Table {
  TextColumn get id => text()();
  TextColumn get batchId =>
      text().references(Batches, #id, onDelete: KeyAction.cascade)();

  /// strip | spirit | rectification | gin | steam
  TextColumn get kind => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();

  /// Залито в куб: объём и крепость.
  RealColumn get chargeVolumeL => real().withDefault(const Constant(0))();
  RealColumn get chargeAbv => real().withDefault(const Constant(0))();

  /// Температура в кубе на старте и на финише, °C.
  RealColumn get cubeTempStartC => real().nullable()();
  RealColumn get cubeTempEndC => real().nullable()();

  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Фракция перегонки по банкам: голова/тело/хвост.
@DataClassName('RunFraction')
class RunFractions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get runId =>
      text().references(Runs, #id, onDelete: KeyAction.cascade)();
  IntColumn get jarNo => integer().withDefault(const Constant(1))();

  /// foreshots | heads | hearts | tails | feints
  TextColumn get kind => text()();
  RealColumn get volumeMl => real()();
  RealColumn get abv => real()();
  RealColumn get tempC => real().nullable()();
  TextColumn get note => text().withDefault(const Constant(''))();
}

/// Тара: бочка, бутыль, банка, нерж.
@DataClassName('Vessel')
class Vessels extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// barrel | glass | steel | jar | bottle | fermenter
  TextColumn get kind => text()();
  RealColumn get volumeL => real()();
  TextColumn get material => text().withDefault(const Constant(''))();

  /// Обжиг бочки: 1 — лёгкий, 2 — средний, 3 — сильный.
  IntColumn get charLevel => integer().nullable()();
  TextColumn get location => text().withDefault(const Constant(''))();
  BoolColumn get isOccupied => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Выдержка партии в таре.
@DataClassName('AgingEntry')
class Aging extends Table {
  TextColumn get id => text()();
  TextColumn get batchId =>
      text().references(Batches, #id, onDelete: KeyAction.cascade)();
  TextColumn get vesselId => text().nullable().references(Vessels, #id)();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get plannedEndAt => dateTime().nullable()();

  /// Потери на испарение, % в год.
  RealColumn get angelSharePctYear => real().withDefault(const Constant(3))();
  DateTimeColumn get lastToppedAt => dateTime().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Настаивание: партия стоит на сырье, её надо периодически взбалтывать,
/// а потом снять с осадка. Отдельно от выдержки: там тара и доля ангела,
/// здесь — сырьё, срок мацерации и взбалтывания.
@DataClassName('Maceration')
class Macerations extends Table {
  TextColumn get id => text()();
  TextColumn get batchId =>
      text().references(Batches, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get startedAt => dateTime()();

  /// Плановое снятие с осадка. null — срок не задан.
  DateTimeColumn get plannedEndAt => dateTime().nullable()();

  /// Взбалтывать каждые N дней. 0 — не взбалтываем.
  IntColumn get shakeEveryDays => integer().withDefault(const Constant(3))();
  DateTimeColumn get lastShakenAt => dateTime().nullable()();
  IntColumn get shakenCount => integer().withDefault(const Constant(0))();

  /// Крепость спирта, на котором стоит сырьё, %.
  RealColumn get strengthAbv => real().withDefault(const Constant(0))();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Дегустация: оценка и выводы.
@DataClassName('Tasting')
class Tastings extends Table {
  TextColumn get id => text()();
  TextColumn get batchId =>
      text().references(Batches, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get at => dateTime()();

  /// 1..5
  IntColumn get rating => integer().withDefault(const Constant(0))();
  TextColumn get aroma => text().withDefault(const Constant(''))();
  TextColumn get taste => text().withDefault(const Constant(''))();
  TextColumn get finish => text().withDefault(const Constant(''))();
  TextColumn get verdict => text().withDefault(const Constant(''))();
  TextColumn get photoPath => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
