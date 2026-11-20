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
