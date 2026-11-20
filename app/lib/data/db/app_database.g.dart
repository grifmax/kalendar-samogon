// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _styleTagsMeta = const VerificationMeta(
    'styleTags',
  );
  @override
  late final GeneratedColumn<String> styleTags = GeneratedColumn<String>(
    'style_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _baseVolumeLMeta = const VerificationMeta(
    'baseVolumeL',
  );
  @override
  late final GeneratedColumn<double> baseVolumeL = GeneratedColumn<double>(
    'base_volume_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _expectedYieldLMeta = const VerificationMeta(
    'expectedYieldL',
  );
  @override
  late final GeneratedColumn<double> expectedYieldL = GeneratedColumn<double>(
    'expected_yield_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _expectedAbvMeta = const VerificationMeta(
    'expectedAbv',
  );
  @override
  late final GeneratedColumn<double> expectedAbv = GeneratedColumn<double>(
    'expected_abv',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    kind,
    styleTags,
    baseVolumeL,
    expectedYieldL,
    expectedAbv,
    summary,
    source,
    isBuiltIn,
    isFavorite,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('style_tags')) {
      context.handle(
        _styleTagsMeta,
        styleTags.isAcceptableOrUnknown(data['style_tags']!, _styleTagsMeta),
      );
    }
    if (data.containsKey('base_volume_l')) {
      context.handle(
        _baseVolumeLMeta,
        baseVolumeL.isAcceptableOrUnknown(
          data['base_volume_l']!,
          _baseVolumeLMeta,
        ),
      );
    }
    if (data.containsKey('expected_yield_l')) {
      context.handle(
        _expectedYieldLMeta,
        expectedYieldL.isAcceptableOrUnknown(
          data['expected_yield_l']!,
          _expectedYieldLMeta,
        ),
      );
    }
    if (data.containsKey('expected_abv')) {
      context.handle(
        _expectedAbvMeta,
        expectedAbv.isAcceptableOrUnknown(
          data['expected_abv']!,
          _expectedAbvMeta,
        ),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      styleTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}style_tags'],
      )!,
      baseVolumeL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}base_volume_l'],
      )!,
      expectedYieldL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_yield_l'],
      )!,
      expectedAbv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_abv'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final String id;
  final String title;
  final String kind;

  /// Теги стиля в JSON-массиве: ["сахарная", "быстрая"].
  final String styleTags;
  final double baseVolumeL;
  final double expectedYieldL;
  final double expectedAbv;
  final String summary;
  final String source;
  final bool isBuiltIn;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Recipe({
    required this.id,
    required this.title,
    required this.kind,
    required this.styleTags,
    required this.baseVolumeL,
    required this.expectedYieldL,
    required this.expectedAbv,
    required this.summary,
    required this.source,
    required this.isBuiltIn,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['kind'] = Variable<String>(kind);
    map['style_tags'] = Variable<String>(styleTags);
    map['base_volume_l'] = Variable<double>(baseVolumeL);
    map['expected_yield_l'] = Variable<double>(expectedYieldL);
    map['expected_abv'] = Variable<double>(expectedAbv);
    map['summary'] = Variable<String>(summary);
    map['source'] = Variable<String>(source);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      title: Value(title),
      kind: Value(kind),
      styleTags: Value(styleTags),
      baseVolumeL: Value(baseVolumeL),
      expectedYieldL: Value(expectedYieldL),
      expectedAbv: Value(expectedAbv),
      summary: Value(summary),
      source: Value(source),
      isBuiltIn: Value(isBuiltIn),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      kind: serializer.fromJson<String>(json['kind']),
      styleTags: serializer.fromJson<String>(json['styleTags']),
      baseVolumeL: serializer.fromJson<double>(json['baseVolumeL']),
      expectedYieldL: serializer.fromJson<double>(json['expectedYieldL']),
      expectedAbv: serializer.fromJson<double>(json['expectedAbv']),
      summary: serializer.fromJson<String>(json['summary']),
      source: serializer.fromJson<String>(json['source']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'kind': serializer.toJson<String>(kind),
      'styleTags': serializer.toJson<String>(styleTags),
      'baseVolumeL': serializer.toJson<double>(baseVolumeL),
      'expectedYieldL': serializer.toJson<double>(expectedYieldL),
      'expectedAbv': serializer.toJson<double>(expectedAbv),
      'summary': serializer.toJson<String>(summary),
      'source': serializer.toJson<String>(source),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Recipe copyWith({
    String? id,
    String? title,
    String? kind,
    String? styleTags,
    double? baseVolumeL,
    double? expectedYieldL,
    double? expectedAbv,
    String? summary,
    String? source,
    bool? isBuiltIn,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Recipe(
    id: id ?? this.id,
    title: title ?? this.title,
    kind: kind ?? this.kind,
    styleTags: styleTags ?? this.styleTags,
    baseVolumeL: baseVolumeL ?? this.baseVolumeL,
    expectedYieldL: expectedYieldL ?? this.expectedYieldL,
    expectedAbv: expectedAbv ?? this.expectedAbv,
    summary: summary ?? this.summary,
    source: source ?? this.source,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      kind: data.kind.present ? data.kind.value : this.kind,
      styleTags: data.styleTags.present ? data.styleTags.value : this.styleTags,
      baseVolumeL: data.baseVolumeL.present
          ? data.baseVolumeL.value
          : this.baseVolumeL,
      expectedYieldL: data.expectedYieldL.present
          ? data.expectedYieldL.value
          : this.expectedYieldL,
      expectedAbv: data.expectedAbv.present
          ? data.expectedAbv.value
          : this.expectedAbv,
      summary: data.summary.present ? data.summary.value : this.summary,
      source: data.source.present ? data.source.value : this.source,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('styleTags: $styleTags, ')
          ..write('baseVolumeL: $baseVolumeL, ')
          ..write('expectedYieldL: $expectedYieldL, ')
          ..write('expectedAbv: $expectedAbv, ')
          ..write('summary: $summary, ')
          ..write('source: $source, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    kind,
    styleTags,
    baseVolumeL,
    expectedYieldL,
    expectedAbv,
    summary,
    source,
    isBuiltIn,
    isFavorite,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.title == this.title &&
          other.kind == this.kind &&
          other.styleTags == this.styleTags &&
          other.baseVolumeL == this.baseVolumeL &&
          other.expectedYieldL == this.expectedYieldL &&
          other.expectedAbv == this.expectedAbv &&
          other.summary == this.summary &&
          other.source == this.source &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> kind;
  final Value<String> styleTags;
  final Value<double> baseVolumeL;
  final Value<double> expectedYieldL;
  final Value<double> expectedAbv;
  final Value<String> summary;
  final Value<String> source;
  final Value<bool> isBuiltIn;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.kind = const Value.absent(),
    this.styleTags = const Value.absent(),
    this.baseVolumeL = const Value.absent(),
    this.expectedYieldL = const Value.absent(),
    this.expectedAbv = const Value.absent(),
    this.summary = const Value.absent(),
    this.source = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipesCompanion.insert({
    required String id,
    required String title,
    required String kind,
    this.styleTags = const Value.absent(),
    this.baseVolumeL = const Value.absent(),
    this.expectedYieldL = const Value.absent(),
    this.expectedAbv = const Value.absent(),
    this.summary = const Value.absent(),
    this.source = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       kind = Value(kind);
  static Insertable<Recipe> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? kind,
    Expression<String>? styleTags,
    Expression<double>? baseVolumeL,
    Expression<double>? expectedYieldL,
    Expression<double>? expectedAbv,
    Expression<String>? summary,
    Expression<String>? source,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (kind != null) 'kind': kind,
      if (styleTags != null) 'style_tags': styleTags,
      if (baseVolumeL != null) 'base_volume_l': baseVolumeL,
      if (expectedYieldL != null) 'expected_yield_l': expectedYieldL,
      if (expectedAbv != null) 'expected_abv': expectedAbv,
      if (summary != null) 'summary': summary,
      if (source != null) 'source': source,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? kind,
    Value<String>? styleTags,
    Value<double>? baseVolumeL,
    Value<double>? expectedYieldL,
    Value<double>? expectedAbv,
    Value<String>? summary,
    Value<String>? source,
    Value<bool>? isBuiltIn,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      styleTags: styleTags ?? this.styleTags,
      baseVolumeL: baseVolumeL ?? this.baseVolumeL,
      expectedYieldL: expectedYieldL ?? this.expectedYieldL,
      expectedAbv: expectedAbv ?? this.expectedAbv,
      summary: summary ?? this.summary,
      source: source ?? this.source,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (styleTags.present) {
      map['style_tags'] = Variable<String>(styleTags.value);
    }
    if (baseVolumeL.present) {
      map['base_volume_l'] = Variable<double>(baseVolumeL.value);
    }
    if (expectedYieldL.present) {
      map['expected_yield_l'] = Variable<double>(expectedYieldL.value);
    }
    if (expectedAbv.present) {
      map['expected_abv'] = Variable<double>(expectedAbv.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('styleTags: $styleTags, ')
          ..write('baseVolumeL: $baseVolumeL, ')
          ..write('expectedYieldL: $expectedYieldL, ')
          ..write('expectedAbv: $expectedAbv, ')
          ..write('summary: $summary, ')
          ..write('source: $source, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipeIngredientsTable extends RecipeIngredients
    with TableInfo<$RecipeIngredientsTable, RecipeIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    sortOrder,
    name,
    amount,
    unit,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeIngredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $RecipeIngredientsTable createAlias(String alias) {
    return $RecipeIngredientsTable(attachedDatabase, alias);
  }
}

class RecipeIngredient extends DataClass
    implements Insertable<RecipeIngredient> {
  final int id;
  final String recipeId;
  final int sortOrder;
  final String name;
  final double amount;
  final String unit;
  final String note;
  const RecipeIngredient({
    required this.id,
    required this.recipeId,
    required this.sortOrder,
    required this.name,
    required this.amount,
    required this.unit,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['unit'] = Variable<String>(unit);
    map['note'] = Variable<String>(note);
    return map;
  }

  RecipeIngredientsCompanion toCompanion(bool nullToAbsent) {
    return RecipeIngredientsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      sortOrder: Value(sortOrder),
      name: Value(name),
      amount: Value(amount),
      unit: Value(unit),
      note: Value(note),
    );
  }

  factory RecipeIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeIngredient(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      unit: serializer.fromJson<String>(json['unit']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'unit': serializer.toJson<String>(unit),
      'note': serializer.toJson<String>(note),
    };
  }

  RecipeIngredient copyWith({
    int? id,
    String? recipeId,
    int? sortOrder,
    String? name,
    double? amount,
    String? unit,
    String? note,
  }) => RecipeIngredient(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    sortOrder: sortOrder ?? this.sortOrder,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    unit: unit ?? this.unit,
    note: note ?? this.note,
  );
  RecipeIngredient copyWithCompanion(RecipeIngredientsCompanion data) {
    return RecipeIngredient(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredient(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, recipeId, sortOrder, name, amount, unit, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeIngredient &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.sortOrder == this.sortOrder &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.note == this.note);
}

class RecipeIngredientsCompanion extends UpdateCompanion<RecipeIngredient> {
  final Value<int> id;
  final Value<String> recipeId;
  final Value<int> sortOrder;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> unit;
  final Value<String> note;
  const RecipeIngredientsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.note = const Value.absent(),
  });
  RecipeIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String recipeId,
    this.sortOrder = const Value.absent(),
    required String name,
    required double amount,
    required String unit,
    this.note = const Value.absent(),
  }) : recipeId = Value(recipeId),
       name = Value(name),
       amount = Value(amount),
       unit = Value(unit);
  static Insertable<RecipeIngredient> custom({
    Expression<int>? id,
    Expression<String>? recipeId,
    Expression<int>? sortOrder,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? unit,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (note != null) 'note': note,
    });
  }

  RecipeIngredientsCompanion copyWith({
    Value<int>? id,
    Value<String>? recipeId,
    Value<int>? sortOrder,
    Value<String>? name,
    Value<double>? amount,
    Value<String>? unit,
    Value<String>? note,
  }) {
    return RecipeIngredientsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      sortOrder: sortOrder ?? this.sortOrder,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $RecipeStepsTable extends RecipeSteps
    with TableInfo<$RecipeStepsTable, RecipeStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _offsetDaysMeta = const VerificationMeta(
    'offsetDays',
  );
  @override
  late final GeneratedColumn<int> offsetDays = GeneratedColumn<int>(
    'offset_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
    'duration_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eventKindMeta = const VerificationMeta(
    'eventKind',
  );
  @override
  late final GeneratedColumn<String> eventKind = GeneratedColumn<String>(
    'event_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('check'),
  );
  static const VerificationMeta _repeatEveryDaysMeta = const VerificationMeta(
    'repeatEveryDays',
  );
  @override
  late final GeneratedColumn<int> repeatEveryDays = GeneratedColumn<int>(
    'repeat_every_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repeatUntilDayMeta = const VerificationMeta(
    'repeatUntilDay',
  );
  @override
  late final GeneratedColumn<int> repeatUntilDay = GeneratedColumn<int>(
    'repeat_until_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    sortOrder,
    title,
    description,
    offsetDays,
    durationMin,
    tempC,
    eventKind,
    repeatEveryDays,
    repeatUntilDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('offset_days')) {
      context.handle(
        _offsetDaysMeta,
        offsetDays.isAcceptableOrUnknown(data['offset_days']!, _offsetDaysMeta),
      );
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    }
    if (data.containsKey('event_kind')) {
      context.handle(
        _eventKindMeta,
        eventKind.isAcceptableOrUnknown(data['event_kind']!, _eventKindMeta),
      );
    }
    if (data.containsKey('repeat_every_days')) {
      context.handle(
        _repeatEveryDaysMeta,
        repeatEveryDays.isAcceptableOrUnknown(
          data['repeat_every_days']!,
          _repeatEveryDaysMeta,
        ),
      );
    }
    if (data.containsKey('repeat_until_day')) {
      context.handle(
        _repeatUntilDayMeta,
        repeatUntilDay.isAcceptableOrUnknown(
          data['repeat_until_day']!,
          _repeatUntilDayMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      offsetDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offset_days'],
      )!,
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_min'],
      ),
      tempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temp_c'],
      ),
      eventKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_kind'],
      )!,
      repeatEveryDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_every_days'],
      ),
      repeatUntilDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_until_day'],
      ),
    );
  }

  @override
  $RecipeStepsTable createAlias(String alias) {
    return $RecipeStepsTable(attachedDatabase, alias);
  }
}

class RecipeStep extends DataClass implements Insertable<RecipeStep> {
  final int id;
  final String recipeId;
  final int sortOrder;
  final String title;
  final String description;
  final int offsetDays;
  final int? durationMin;
  final double? tempC;
  final String eventKind;

  /// Повторяющийся шаг: каждые N дней до дня `repeatUntilDay`.
  final int? repeatEveryDays;
  final int? repeatUntilDay;
  const RecipeStep({
    required this.id,
    required this.recipeId,
    required this.sortOrder,
    required this.title,
    required this.description,
    required this.offsetDays,
    this.durationMin,
    this.tempC,
    required this.eventKind,
    this.repeatEveryDays,
    this.repeatUntilDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['offset_days'] = Variable<int>(offsetDays);
    if (!nullToAbsent || durationMin != null) {
      map['duration_min'] = Variable<int>(durationMin);
    }
    if (!nullToAbsent || tempC != null) {
      map['temp_c'] = Variable<double>(tempC);
    }
    map['event_kind'] = Variable<String>(eventKind);
    if (!nullToAbsent || repeatEveryDays != null) {
      map['repeat_every_days'] = Variable<int>(repeatEveryDays);
    }
    if (!nullToAbsent || repeatUntilDay != null) {
      map['repeat_until_day'] = Variable<int>(repeatUntilDay);
    }
    return map;
  }

  RecipeStepsCompanion toCompanion(bool nullToAbsent) {
    return RecipeStepsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      sortOrder: Value(sortOrder),
      title: Value(title),
      description: Value(description),
      offsetDays: Value(offsetDays),
      durationMin: durationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMin),
      tempC: tempC == null && nullToAbsent
          ? const Value.absent()
          : Value(tempC),
      eventKind: Value(eventKind),
      repeatEveryDays: repeatEveryDays == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatEveryDays),
      repeatUntilDay: repeatUntilDay == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatUntilDay),
    );
  }

  factory RecipeStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeStep(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      offsetDays: serializer.fromJson<int>(json['offsetDays']),
      durationMin: serializer.fromJson<int?>(json['durationMin']),
      tempC: serializer.fromJson<double?>(json['tempC']),
      eventKind: serializer.fromJson<String>(json['eventKind']),
      repeatEveryDays: serializer.fromJson<int?>(json['repeatEveryDays']),
      repeatUntilDay: serializer.fromJson<int?>(json['repeatUntilDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'offsetDays': serializer.toJson<int>(offsetDays),
      'durationMin': serializer.toJson<int?>(durationMin),
      'tempC': serializer.toJson<double?>(tempC),
      'eventKind': serializer.toJson<String>(eventKind),
      'repeatEveryDays': serializer.toJson<int?>(repeatEveryDays),
      'repeatUntilDay': serializer.toJson<int?>(repeatUntilDay),
    };
  }

  RecipeStep copyWith({
    int? id,
    String? recipeId,
    int? sortOrder,
    String? title,
    String? description,
    int? offsetDays,
    Value<int?> durationMin = const Value.absent(),
    Value<double?> tempC = const Value.absent(),
    String? eventKind,
    Value<int?> repeatEveryDays = const Value.absent(),
    Value<int?> repeatUntilDay = const Value.absent(),
  }) => RecipeStep(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    sortOrder: sortOrder ?? this.sortOrder,
    title: title ?? this.title,
    description: description ?? this.description,
    offsetDays: offsetDays ?? this.offsetDays,
    durationMin: durationMin.present ? durationMin.value : this.durationMin,
    tempC: tempC.present ? tempC.value : this.tempC,
    eventKind: eventKind ?? this.eventKind,
    repeatEveryDays: repeatEveryDays.present
        ? repeatEveryDays.value
        : this.repeatEveryDays,
    repeatUntilDay: repeatUntilDay.present
        ? repeatUntilDay.value
        : this.repeatUntilDay,
  );
  RecipeStep copyWithCompanion(RecipeStepsCompanion data) {
    return RecipeStep(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      offsetDays: data.offsetDays.present
          ? data.offsetDays.value
          : this.offsetDays,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      tempC: data.tempC.present ? data.tempC.value : this.tempC,
      eventKind: data.eventKind.present ? data.eventKind.value : this.eventKind,
      repeatEveryDays: data.repeatEveryDays.present
          ? data.repeatEveryDays.value
          : this.repeatEveryDays,
      repeatUntilDay: data.repeatUntilDay.present
          ? data.repeatUntilDay.value
          : this.repeatUntilDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStep(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('offsetDays: $offsetDays, ')
          ..write('durationMin: $durationMin, ')
          ..write('tempC: $tempC, ')
          ..write('eventKind: $eventKind, ')
          ..write('repeatEveryDays: $repeatEveryDays, ')
          ..write('repeatUntilDay: $repeatUntilDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    sortOrder,
    title,
    description,
    offsetDays,
    durationMin,
    tempC,
    eventKind,
    repeatEveryDays,
    repeatUntilDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeStep &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.sortOrder == this.sortOrder &&
          other.title == this.title &&
          other.description == this.description &&
          other.offsetDays == this.offsetDays &&
          other.durationMin == this.durationMin &&
          other.tempC == this.tempC &&
          other.eventKind == this.eventKind &&
          other.repeatEveryDays == this.repeatEveryDays &&
          other.repeatUntilDay == this.repeatUntilDay);
}

class RecipeStepsCompanion extends UpdateCompanion<RecipeStep> {
  final Value<int> id;
  final Value<String> recipeId;
  final Value<int> sortOrder;
  final Value<String> title;
  final Value<String> description;
  final Value<int> offsetDays;
  final Value<int?> durationMin;
  final Value<double?> tempC;
  final Value<String> eventKind;
  final Value<int?> repeatEveryDays;
  final Value<int?> repeatUntilDay;
  const RecipeStepsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.offsetDays = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.tempC = const Value.absent(),
    this.eventKind = const Value.absent(),
    this.repeatEveryDays = const Value.absent(),
    this.repeatUntilDay = const Value.absent(),
  });
  RecipeStepsCompanion.insert({
    this.id = const Value.absent(),
    required String recipeId,
    this.sortOrder = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.offsetDays = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.tempC = const Value.absent(),
    this.eventKind = const Value.absent(),
    this.repeatEveryDays = const Value.absent(),
    this.repeatUntilDay = const Value.absent(),
  }) : recipeId = Value(recipeId),
       title = Value(title);
  static Insertable<RecipeStep> custom({
    Expression<int>? id,
    Expression<String>? recipeId,
    Expression<int>? sortOrder,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? offsetDays,
    Expression<int>? durationMin,
    Expression<double>? tempC,
    Expression<String>? eventKind,
    Expression<int>? repeatEveryDays,
    Expression<int>? repeatUntilDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (offsetDays != null) 'offset_days': offsetDays,
      if (durationMin != null) 'duration_min': durationMin,
      if (tempC != null) 'temp_c': tempC,
      if (eventKind != null) 'event_kind': eventKind,
      if (repeatEveryDays != null) 'repeat_every_days': repeatEveryDays,
      if (repeatUntilDay != null) 'repeat_until_day': repeatUntilDay,
    });
  }

  RecipeStepsCompanion copyWith({
    Value<int>? id,
    Value<String>? recipeId,
    Value<int>? sortOrder,
    Value<String>? title,
    Value<String>? description,
    Value<int>? offsetDays,
    Value<int?>? durationMin,
    Value<double?>? tempC,
    Value<String>? eventKind,
    Value<int?>? repeatEveryDays,
    Value<int?>? repeatUntilDay,
  }) {
    return RecipeStepsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      sortOrder: sortOrder ?? this.sortOrder,
      title: title ?? this.title,
      description: description ?? this.description,
      offsetDays: offsetDays ?? this.offsetDays,
      durationMin: durationMin ?? this.durationMin,
      tempC: tempC ?? this.tempC,
      eventKind: eventKind ?? this.eventKind,
      repeatEveryDays: repeatEveryDays ?? this.repeatEveryDays,
      repeatUntilDay: repeatUntilDay ?? this.repeatUntilDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (offsetDays.present) {
      map['offset_days'] = Variable<int>(offsetDays.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (tempC.present) {
      map['temp_c'] = Variable<double>(tempC.value);
    }
    if (eventKind.present) {
      map['event_kind'] = Variable<String>(eventKind.value);
    }
    if (repeatEveryDays.present) {
      map['repeat_every_days'] = Variable<int>(repeatEveryDays.value);
    }
    if (repeatUntilDay.present) {
      map['repeat_until_day'] = Variable<int>(repeatUntilDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStepsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('offsetDays: $offsetDays, ')
          ..write('durationMin: $durationMin, ')
          ..write('tempC: $tempC, ')
          ..write('eventKind: $eventKind, ')
          ..write('repeatEveryDays: $repeatEveryDays, ')
          ..write('repeatUntilDay: $repeatUntilDay')
          ..write(')'))
        .toString();
  }
}

class $BatchesTable extends Batches with TableInfo<$BatchesTable, Batch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id)',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeLMeta = const VerificationMeta(
    'volumeL',
  );
  @override
  late final GeneratedColumn<double> volumeL = GeneratedColumn<double>(
    'volume_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _abvMeta = const VerificationMeta('abv');
  @override
  late final GeneratedColumn<double> abv = GeneratedColumn<double>(
    'abv',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('fermenting'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    code,
    title,
    startedAt,
    finishedAt,
    volumeL,
    abv,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Batch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('volume_l')) {
      context.handle(
        _volumeLMeta,
        volumeL.isAcceptableOrUnknown(data['volume_l']!, _volumeLMeta),
      );
    }
    if (data.containsKey('abv')) {
      context.handle(
        _abvMeta,
        abv.isAcceptableOrUnknown(data['abv']!, _abvMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Batch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Batch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      volumeL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_l'],
      )!,
      abv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}abv'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BatchesTable createAlias(String alias) {
    return $BatchesTable(attachedDatabase, alias);
  }
}

class Batch extends DataClass implements Insertable<Batch> {
  final String id;
  final String recipeId;

  /// Человекочитаемый номер: «Б-01».
  final String code;
  final String title;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final double volumeL;
  final double abv;

  /// planned | fermenting | distilling | aging | ready | bottled | done | failed
  final String status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Batch({
    required this.id,
    required this.recipeId,
    required this.code,
    required this.title,
    required this.startedAt,
    this.finishedAt,
    required this.volumeL,
    required this.abv,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    map['volume_l'] = Variable<double>(volumeL);
    map['abv'] = Variable<double>(abv);
    map['status'] = Variable<String>(status);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BatchesCompanion toCompanion(bool nullToAbsent) {
    return BatchesCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      code: Value(code),
      title: Value(title),
      startedAt: Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      volumeL: Value(volumeL),
      abv: Value(abv),
      status: Value(status),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Batch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Batch(
      id: serializer.fromJson<String>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      volumeL: serializer.fromJson<double>(json['volumeL']),
      abv: serializer.fromJson<double>(json['abv']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'volumeL': serializer.toJson<double>(volumeL),
      'abv': serializer.toJson<double>(abv),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Batch copyWith({
    String? id,
    String? recipeId,
    String? code,
    String? title,
    DateTime? startedAt,
    Value<DateTime?> finishedAt = const Value.absent(),
    double? volumeL,
    double? abv,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Batch(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    code: code ?? this.code,
    title: title ?? this.title,
    startedAt: startedAt ?? this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    volumeL: volumeL ?? this.volumeL,
    abv: abv ?? this.abv,
    status: status ?? this.status,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Batch copyWithCompanion(BatchesCompanion data) {
    return Batch(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      volumeL: data.volumeL.present ? data.volumeL.value : this.volumeL,
      abv: data.abv.present ? data.abv.value : this.abv,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Batch(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('volumeL: $volumeL, ')
          ..write('abv: $abv, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    code,
    title,
    startedAt,
    finishedAt,
    volumeL,
    abv,
    status,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Batch &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.code == this.code &&
          other.title == this.title &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt &&
          other.volumeL == this.volumeL &&
          other.abv == this.abv &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BatchesCompanion extends UpdateCompanion<Batch> {
  final Value<String> id;
  final Value<String> recipeId;
  final Value<String> code;
  final Value<String> title;
  final Value<DateTime> startedAt;
  final Value<DateTime?> finishedAt;
  final Value<double> volumeL;
  final Value<double> abv;
  final Value<String> status;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BatchesCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.volumeL = const Value.absent(),
    this.abv = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatchesCompanion.insert({
    required String id,
    required String recipeId,
    this.code = const Value.absent(),
    required String title,
    required DateTime startedAt,
    this.finishedAt = const Value.absent(),
    this.volumeL = const Value.absent(),
    this.abv = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recipeId = Value(recipeId),
       title = Value(title),
       startedAt = Value(startedAt);
  static Insertable<Batch> custom({
    Expression<String>? id,
    Expression<String>? recipeId,
    Expression<String>? code,
    Expression<String>? title,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? finishedAt,
    Expression<double>? volumeL,
    Expression<double>? abv,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (volumeL != null) 'volume_l': volumeL,
      if (abv != null) 'abv': abv,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatchesCompanion copyWith({
    Value<String>? id,
    Value<String>? recipeId,
    Value<String>? code,
    Value<String>? title,
    Value<DateTime>? startedAt,
    Value<DateTime?>? finishedAt,
    Value<double>? volumeL,
    Value<double>? abv,
    Value<String>? status,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BatchesCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      code: code ?? this.code,
      title: title ?? this.title,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      volumeL: volumeL ?? this.volumeL,
      abv: abv ?? this.abv,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (volumeL.present) {
      map['volume_l'] = Variable<double>(volumeL.value);
    }
    if (abv.present) {
      map['abv'] = Variable<double>(abv.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchesCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('volumeL: $volumeL, ')
          ..write('abv: $abv, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatchEventsTable extends BatchEvents
    with TableInfo<$BatchEventsTable, BatchEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _plannedAtMeta = const VerificationMeta(
    'plannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> plannedAt = GeneratedColumn<DateTime>(
    'planned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualAtMeta = const VerificationMeta(
    'actualAt',
  );
  @override
  late final GeneratedColumn<DateTime> actualAt = GeneratedColumn<DateTime>(
    'actual_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('planned'),
  );
  static const VerificationMeta _remindBeforeMinMeta = const VerificationMeta(
    'remindBeforeMin',
  );
  @override
  late final GeneratedColumn<int> remindBeforeMin = GeneratedColumn<int>(
    'remind_before_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    kind,
    title,
    description,
    plannedAt,
    actualAt,
    status,
    remindBeforeMin,
    notificationId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batch_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatchEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('planned_at')) {
      context.handle(
        _plannedAtMeta,
        plannedAt.isAcceptableOrUnknown(data['planned_at']!, _plannedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_plannedAtMeta);
    }
    if (data.containsKey('actual_at')) {
      context.handle(
        _actualAtMeta,
        actualAt.isAcceptableOrUnknown(data['actual_at']!, _actualAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('remind_before_min')) {
      context.handle(
        _remindBeforeMinMeta,
        remindBeforeMin.isAcceptableOrUnknown(
          data['remind_before_min']!,
          _remindBeforeMinMeta,
        ),
      );
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatchEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatchEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      plannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planned_at'],
      )!,
      actualAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actual_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      remindBeforeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remind_before_min'],
      )!,
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      ),
    );
  }

  @override
  $BatchEventsTable createAlias(String alias) {
    return $BatchEventsTable(attachedDatabase, alias);
  }
}

class BatchEvent extends DataClass implements Insertable<BatchEvent> {
  final String id;
  final String batchId;
  final String kind;
  final String title;
  final String description;
  final DateTime plannedAt;
  final DateTime? actualAt;

  /// planned | done | skipped
  final String status;
  final int remindBeforeMin;
  final int? notificationId;
  const BatchEvent({
    required this.id,
    required this.batchId,
    required this.kind,
    required this.title,
    required this.description,
    required this.plannedAt,
    this.actualAt,
    required this.status,
    required this.remindBeforeMin,
    this.notificationId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['kind'] = Variable<String>(kind);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['planned_at'] = Variable<DateTime>(plannedAt);
    if (!nullToAbsent || actualAt != null) {
      map['actual_at'] = Variable<DateTime>(actualAt);
    }
    map['status'] = Variable<String>(status);
    map['remind_before_min'] = Variable<int>(remindBeforeMin);
    if (!nullToAbsent || notificationId != null) {
      map['notification_id'] = Variable<int>(notificationId);
    }
    return map;
  }

  BatchEventsCompanion toCompanion(bool nullToAbsent) {
    return BatchEventsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      kind: Value(kind),
      title: Value(title),
      description: Value(description),
      plannedAt: Value(plannedAt),
      actualAt: actualAt == null && nullToAbsent
          ? const Value.absent()
          : Value(actualAt),
      status: Value(status),
      remindBeforeMin: Value(remindBeforeMin),
      notificationId: notificationId == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationId),
    );
  }

  factory BatchEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatchEvent(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      kind: serializer.fromJson<String>(json['kind']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      plannedAt: serializer.fromJson<DateTime>(json['plannedAt']),
      actualAt: serializer.fromJson<DateTime?>(json['actualAt']),
      status: serializer.fromJson<String>(json['status']),
      remindBeforeMin: serializer.fromJson<int>(json['remindBeforeMin']),
      notificationId: serializer.fromJson<int?>(json['notificationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'kind': serializer.toJson<String>(kind),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'plannedAt': serializer.toJson<DateTime>(plannedAt),
      'actualAt': serializer.toJson<DateTime?>(actualAt),
      'status': serializer.toJson<String>(status),
      'remindBeforeMin': serializer.toJson<int>(remindBeforeMin),
      'notificationId': serializer.toJson<int?>(notificationId),
    };
  }

  BatchEvent copyWith({
    String? id,
    String? batchId,
    String? kind,
    String? title,
    String? description,
    DateTime? plannedAt,
    Value<DateTime?> actualAt = const Value.absent(),
    String? status,
    int? remindBeforeMin,
    Value<int?> notificationId = const Value.absent(),
  }) => BatchEvent(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    description: description ?? this.description,
    plannedAt: plannedAt ?? this.plannedAt,
    actualAt: actualAt.present ? actualAt.value : this.actualAt,
    status: status ?? this.status,
    remindBeforeMin: remindBeforeMin ?? this.remindBeforeMin,
    notificationId: notificationId.present
        ? notificationId.value
        : this.notificationId,
  );
  BatchEvent copyWithCompanion(BatchEventsCompanion data) {
    return BatchEvent(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      plannedAt: data.plannedAt.present ? data.plannedAt.value : this.plannedAt,
      actualAt: data.actualAt.present ? data.actualAt.value : this.actualAt,
      status: data.status.present ? data.status.value : this.status,
      remindBeforeMin: data.remindBeforeMin.present
          ? data.remindBeforeMin.value
          : this.remindBeforeMin,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatchEvent(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('plannedAt: $plannedAt, ')
          ..write('actualAt: $actualAt, ')
          ..write('status: $status, ')
          ..write('remindBeforeMin: $remindBeforeMin, ')
          ..write('notificationId: $notificationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    kind,
    title,
    description,
    plannedAt,
    actualAt,
    status,
    remindBeforeMin,
    notificationId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatchEvent &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.description == this.description &&
          other.plannedAt == this.plannedAt &&
          other.actualAt == this.actualAt &&
          other.status == this.status &&
          other.remindBeforeMin == this.remindBeforeMin &&
          other.notificationId == this.notificationId);
}

class BatchEventsCompanion extends UpdateCompanion<BatchEvent> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<String> kind;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> plannedAt;
  final Value<DateTime?> actualAt;
  final Value<String> status;
  final Value<int> remindBeforeMin;
  final Value<int?> notificationId;
  final Value<int> rowid;
  const BatchEventsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.plannedAt = const Value.absent(),
    this.actualAt = const Value.absent(),
    this.status = const Value.absent(),
    this.remindBeforeMin = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatchEventsCompanion.insert({
    required String id,
    required String batchId,
    required String kind,
    required String title,
    this.description = const Value.absent(),
    required DateTime plannedAt,
    this.actualAt = const Value.absent(),
    this.status = const Value.absent(),
    this.remindBeforeMin = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       kind = Value(kind),
       title = Value(title),
       plannedAt = Value(plannedAt);
  static Insertable<BatchEvent> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<String>? kind,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? plannedAt,
    Expression<DateTime>? actualAt,
    Expression<String>? status,
    Expression<int>? remindBeforeMin,
    Expression<int>? notificationId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (plannedAt != null) 'planned_at': plannedAt,
      if (actualAt != null) 'actual_at': actualAt,
      if (status != null) 'status': status,
      if (remindBeforeMin != null) 'remind_before_min': remindBeforeMin,
      if (notificationId != null) 'notification_id': notificationId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatchEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<String>? kind,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? plannedAt,
    Value<DateTime?>? actualAt,
    Value<String>? status,
    Value<int>? remindBeforeMin,
    Value<int?>? notificationId,
    Value<int>? rowid,
  }) {
    return BatchEventsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      description: description ?? this.description,
      plannedAt: plannedAt ?? this.plannedAt,
      actualAt: actualAt ?? this.actualAt,
      status: status ?? this.status,
      remindBeforeMin: remindBeforeMin ?? this.remindBeforeMin,
      notificationId: notificationId ?? this.notificationId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (plannedAt.present) {
      map['planned_at'] = Variable<DateTime>(plannedAt.value);
    }
    if (actualAt.present) {
      map['actual_at'] = Variable<DateTime>(actualAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (remindBeforeMin.present) {
      map['remind_before_min'] = Variable<int>(remindBeforeMin.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchEventsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('plannedAt: $plannedAt, ')
          ..write('actualAt: $actualAt, ')
          ..write('status: $status, ')
          ..write('remindBeforeMin: $remindBeforeMin, ')
          ..write('notificationId: $notificationId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeasurementsTable extends Measurements
    with TableInfo<$MeasurementsTable, Measurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [id, batchId, at, kind, value, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Measurement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Measurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Measurement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $MeasurementsTable createAlias(String alias) {
    return $MeasurementsTable(attachedDatabase, alias);
  }
}

class Measurement extends DataClass implements Insertable<Measurement> {
  final String id;
  final String batchId;
  final DateTime at;

  /// sg | brix | temp | abv | ph | sugar
  final String kind;
  final double value;
  final String note;
  const Measurement({
    required this.id,
    required this.batchId,
    required this.at,
    required this.kind,
    required this.value,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['at'] = Variable<DateTime>(at);
    map['kind'] = Variable<String>(kind);
    map['value'] = Variable<double>(value);
    map['note'] = Variable<String>(note);
    return map;
  }

  MeasurementsCompanion toCompanion(bool nullToAbsent) {
    return MeasurementsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      at: Value(at),
      kind: Value(kind),
      value: Value(value),
      note: Value(note),
    );
  }

  factory Measurement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Measurement(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      at: serializer.fromJson<DateTime>(json['at']),
      kind: serializer.fromJson<String>(json['kind']),
      value: serializer.fromJson<double>(json['value']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'at': serializer.toJson<DateTime>(at),
      'kind': serializer.toJson<String>(kind),
      'value': serializer.toJson<double>(value),
      'note': serializer.toJson<String>(note),
    };
  }

  Measurement copyWith({
    String? id,
    String? batchId,
    DateTime? at,
    String? kind,
    double? value,
    String? note,
  }) => Measurement(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    at: at ?? this.at,
    kind: kind ?? this.kind,
    value: value ?? this.value,
    note: note ?? this.note,
  );
  Measurement copyWithCompanion(MeasurementsCompanion data) {
    return Measurement(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      at: data.at.present ? data.at.value : this.at,
      kind: data.kind.present ? data.kind.value : this.kind,
      value: data.value.present ? data.value.value : this.value,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Measurement(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('at: $at, ')
          ..write('kind: $kind, ')
          ..write('value: $value, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, batchId, at, kind, value, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Measurement &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.at == this.at &&
          other.kind == this.kind &&
          other.value == this.value &&
          other.note == this.note);
}

class MeasurementsCompanion extends UpdateCompanion<Measurement> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<DateTime> at;
  final Value<String> kind;
  final Value<double> value;
  final Value<String> note;
  final Value<int> rowid;
  const MeasurementsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.at = const Value.absent(),
    this.kind = const Value.absent(),
    this.value = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeasurementsCompanion.insert({
    required String id,
    required String batchId,
    required DateTime at,
    required String kind,
    required double value,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       at = Value(at),
       kind = Value(kind),
       value = Value(value);
  static Insertable<Measurement> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<DateTime>? at,
    Expression<String>? kind,
    Expression<double>? value,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (at != null) 'at': at,
      if (kind != null) 'kind': kind,
      if (value != null) 'value': value,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeasurementsCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<DateTime>? at,
    Value<String>? kind,
    Value<double>? value,
    Value<String>? note,
    Value<int>? rowid,
  }) {
    return MeasurementsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      at: at ?? this.at,
      kind: kind ?? this.kind,
      value: value ?? this.value,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('at: $at, ')
          ..write('kind: $kind, ')
          ..write('value: $value, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaData extends DataClass implements Insertable<AppMetaData> {
  final String key;
  final String value;
  const AppMetaData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetaData copyWith({String? key, String? value}) =>
      AppMetaData(key: key ?? this.key, value: value ?? this.value);
  AppMetaData copyWithCompanion(AppMetaCompanion data) {
    return AppMetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaData &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatchIngredientsTable extends BatchIngredients
    with TableInfo<$BatchIngredientsTable, BatchIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    sortOrder,
    name,
    amount,
    unit,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batch_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatchIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatchIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatchIngredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $BatchIngredientsTable createAlias(String alias) {
    return $BatchIngredientsTable(attachedDatabase, alias);
  }
}

class BatchIngredient extends DataClass implements Insertable<BatchIngredient> {
  final int id;
  final String batchId;
  final int sortOrder;
  final String name;
  final double amount;
  final String unit;
  final String note;
  const BatchIngredient({
    required this.id,
    required this.batchId,
    required this.sortOrder,
    required this.name,
    required this.amount,
    required this.unit,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['unit'] = Variable<String>(unit);
    map['note'] = Variable<String>(note);
    return map;
  }

  BatchIngredientsCompanion toCompanion(bool nullToAbsent) {
    return BatchIngredientsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      sortOrder: Value(sortOrder),
      name: Value(name),
      amount: Value(amount),
      unit: Value(unit),
      note: Value(note),
    );
  }

  factory BatchIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatchIngredient(
      id: serializer.fromJson<int>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      unit: serializer.fromJson<String>(json['unit']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'batchId': serializer.toJson<String>(batchId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'unit': serializer.toJson<String>(unit),
      'note': serializer.toJson<String>(note),
    };
  }

  BatchIngredient copyWith({
    int? id,
    String? batchId,
    int? sortOrder,
    String? name,
    double? amount,
    String? unit,
    String? note,
  }) => BatchIngredient(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    sortOrder: sortOrder ?? this.sortOrder,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    unit: unit ?? this.unit,
    note: note ?? this.note,
  );
  BatchIngredient copyWithCompanion(BatchIngredientsCompanion data) {
    return BatchIngredient(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatchIngredient(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, batchId, sortOrder, name, amount, unit, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatchIngredient &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.sortOrder == this.sortOrder &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.note == this.note);
}

class BatchIngredientsCompanion extends UpdateCompanion<BatchIngredient> {
  final Value<int> id;
  final Value<String> batchId;
  final Value<int> sortOrder;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> unit;
  final Value<String> note;
  const BatchIngredientsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.note = const Value.absent(),
  });
  BatchIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String batchId,
    this.sortOrder = const Value.absent(),
    required String name,
    required double amount,
    required String unit,
    this.note = const Value.absent(),
  }) : batchId = Value(batchId),
       name = Value(name),
       amount = Value(amount),
       unit = Value(unit);
  static Insertable<BatchIngredient> custom({
    Expression<int>? id,
    Expression<String>? batchId,
    Expression<int>? sortOrder,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? unit,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (note != null) 'note': note,
    });
  }

  BatchIngredientsCompanion copyWith({
    Value<int>? id,
    Value<String>? batchId,
    Value<int>? sortOrder,
    Value<String>? name,
    Value<double>? amount,
    Value<String>? unit,
    Value<String>? note,
  }) {
    return BatchIngredientsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      sortOrder: sortOrder ?? this.sortOrder,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $RunsTable extends Runs with TableInfo<$RunsTable, Run> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chargeVolumeLMeta = const VerificationMeta(
    'chargeVolumeL',
  );
  @override
  late final GeneratedColumn<double> chargeVolumeL = GeneratedColumn<double>(
    'charge_volume_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _chargeAbvMeta = const VerificationMeta(
    'chargeAbv',
  );
  @override
  late final GeneratedColumn<double> chargeAbv = GeneratedColumn<double>(
    'charge_abv',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cubeTempStartCMeta = const VerificationMeta(
    'cubeTempStartC',
  );
  @override
  late final GeneratedColumn<double> cubeTempStartC = GeneratedColumn<double>(
    'cube_temp_start_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cubeTempEndCMeta = const VerificationMeta(
    'cubeTempEndC',
  );
  @override
  late final GeneratedColumn<double> cubeTempEndC = GeneratedColumn<double>(
    'cube_temp_end_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    kind,
    startedAt,
    endedAt,
    chargeVolumeL,
    chargeAbv,
    cubeTempStartC,
    cubeTempEndC,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Run> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('charge_volume_l')) {
      context.handle(
        _chargeVolumeLMeta,
        chargeVolumeL.isAcceptableOrUnknown(
          data['charge_volume_l']!,
          _chargeVolumeLMeta,
        ),
      );
    }
    if (data.containsKey('charge_abv')) {
      context.handle(
        _chargeAbvMeta,
        chargeAbv.isAcceptableOrUnknown(data['charge_abv']!, _chargeAbvMeta),
      );
    }
    if (data.containsKey('cube_temp_start_c')) {
      context.handle(
        _cubeTempStartCMeta,
        cubeTempStartC.isAcceptableOrUnknown(
          data['cube_temp_start_c']!,
          _cubeTempStartCMeta,
        ),
      );
    }
    if (data.containsKey('cube_temp_end_c')) {
      context.handle(
        _cubeTempEndCMeta,
        cubeTempEndC.isAcceptableOrUnknown(
          data['cube_temp_end_c']!,
          _cubeTempEndCMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Run map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Run(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      chargeVolumeL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}charge_volume_l'],
      )!,
      chargeAbv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}charge_abv'],
      )!,
      cubeTempStartC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cube_temp_start_c'],
      ),
      cubeTempEndC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cube_temp_end_c'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $RunsTable createAlias(String alias) {
    return $RunsTable(attachedDatabase, alias);
  }
}

class Run extends DataClass implements Insertable<Run> {
  final String id;
  final String batchId;

  /// strip | spirit | rectification | gin | steam
  final String kind;
  final DateTime startedAt;
  final DateTime? endedAt;

  /// Залито в куб: объём и крепость.
  final double chargeVolumeL;
  final double chargeAbv;

  /// Температура в кубе на старте и на финише, °C.
  final double? cubeTempStartC;
  final double? cubeTempEndC;
  final String notes;
  const Run({
    required this.id,
    required this.batchId,
    required this.kind,
    required this.startedAt,
    this.endedAt,
    required this.chargeVolumeL,
    required this.chargeAbv,
    this.cubeTempStartC,
    this.cubeTempEndC,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['kind'] = Variable<String>(kind);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['charge_volume_l'] = Variable<double>(chargeVolumeL);
    map['charge_abv'] = Variable<double>(chargeAbv);
    if (!nullToAbsent || cubeTempStartC != null) {
      map['cube_temp_start_c'] = Variable<double>(cubeTempStartC);
    }
    if (!nullToAbsent || cubeTempEndC != null) {
      map['cube_temp_end_c'] = Variable<double>(cubeTempEndC);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  RunsCompanion toCompanion(bool nullToAbsent) {
    return RunsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      kind: Value(kind),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      chargeVolumeL: Value(chargeVolumeL),
      chargeAbv: Value(chargeAbv),
      cubeTempStartC: cubeTempStartC == null && nullToAbsent
          ? const Value.absent()
          : Value(cubeTempStartC),
      cubeTempEndC: cubeTempEndC == null && nullToAbsent
          ? const Value.absent()
          : Value(cubeTempEndC),
      notes: Value(notes),
    );
  }

  factory Run.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Run(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      kind: serializer.fromJson<String>(json['kind']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      chargeVolumeL: serializer.fromJson<double>(json['chargeVolumeL']),
      chargeAbv: serializer.fromJson<double>(json['chargeAbv']),
      cubeTempStartC: serializer.fromJson<double?>(json['cubeTempStartC']),
      cubeTempEndC: serializer.fromJson<double?>(json['cubeTempEndC']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'kind': serializer.toJson<String>(kind),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'chargeVolumeL': serializer.toJson<double>(chargeVolumeL),
      'chargeAbv': serializer.toJson<double>(chargeAbv),
      'cubeTempStartC': serializer.toJson<double?>(cubeTempStartC),
      'cubeTempEndC': serializer.toJson<double?>(cubeTempEndC),
      'notes': serializer.toJson<String>(notes),
    };
  }

  Run copyWith({
    String? id,
    String? batchId,
    String? kind,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    double? chargeVolumeL,
    double? chargeAbv,
    Value<double?> cubeTempStartC = const Value.absent(),
    Value<double?> cubeTempEndC = const Value.absent(),
    String? notes,
  }) => Run(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    kind: kind ?? this.kind,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    chargeVolumeL: chargeVolumeL ?? this.chargeVolumeL,
    chargeAbv: chargeAbv ?? this.chargeAbv,
    cubeTempStartC: cubeTempStartC.present
        ? cubeTempStartC.value
        : this.cubeTempStartC,
    cubeTempEndC: cubeTempEndC.present ? cubeTempEndC.value : this.cubeTempEndC,
    notes: notes ?? this.notes,
  );
  Run copyWithCompanion(RunsCompanion data) {
    return Run(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      kind: data.kind.present ? data.kind.value : this.kind,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      chargeVolumeL: data.chargeVolumeL.present
          ? data.chargeVolumeL.value
          : this.chargeVolumeL,
      chargeAbv: data.chargeAbv.present ? data.chargeAbv.value : this.chargeAbv,
      cubeTempStartC: data.cubeTempStartC.present
          ? data.cubeTempStartC.value
          : this.cubeTempStartC,
      cubeTempEndC: data.cubeTempEndC.present
          ? data.cubeTempEndC.value
          : this.cubeTempEndC,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Run(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('kind: $kind, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('chargeVolumeL: $chargeVolumeL, ')
          ..write('chargeAbv: $chargeAbv, ')
          ..write('cubeTempStartC: $cubeTempStartC, ')
          ..write('cubeTempEndC: $cubeTempEndC, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    kind,
    startedAt,
    endedAt,
    chargeVolumeL,
    chargeAbv,
    cubeTempStartC,
    cubeTempEndC,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Run &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.kind == this.kind &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.chargeVolumeL == this.chargeVolumeL &&
          other.chargeAbv == this.chargeAbv &&
          other.cubeTempStartC == this.cubeTempStartC &&
          other.cubeTempEndC == this.cubeTempEndC &&
          other.notes == this.notes);
}

class RunsCompanion extends UpdateCompanion<Run> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<String> kind;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<double> chargeVolumeL;
  final Value<double> chargeAbv;
  final Value<double?> cubeTempStartC;
  final Value<double?> cubeTempEndC;
  final Value<String> notes;
  final Value<int> rowid;
  const RunsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.kind = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.chargeVolumeL = const Value.absent(),
    this.chargeAbv = const Value.absent(),
    this.cubeTempStartC = const Value.absent(),
    this.cubeTempEndC = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RunsCompanion.insert({
    required String id,
    required String batchId,
    required String kind,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.chargeVolumeL = const Value.absent(),
    this.chargeAbv = const Value.absent(),
    this.cubeTempStartC = const Value.absent(),
    this.cubeTempEndC = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       kind = Value(kind),
       startedAt = Value(startedAt);
  static Insertable<Run> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<String>? kind,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<double>? chargeVolumeL,
    Expression<double>? chargeAbv,
    Expression<double>? cubeTempStartC,
    Expression<double>? cubeTempEndC,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (kind != null) 'kind': kind,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (chargeVolumeL != null) 'charge_volume_l': chargeVolumeL,
      if (chargeAbv != null) 'charge_abv': chargeAbv,
      if (cubeTempStartC != null) 'cube_temp_start_c': cubeTempStartC,
      if (cubeTempEndC != null) 'cube_temp_end_c': cubeTempEndC,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RunsCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<String>? kind,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<double>? chargeVolumeL,
    Value<double>? chargeAbv,
    Value<double?>? cubeTempStartC,
    Value<double?>? cubeTempEndC,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return RunsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      kind: kind ?? this.kind,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      chargeVolumeL: chargeVolumeL ?? this.chargeVolumeL,
      chargeAbv: chargeAbv ?? this.chargeAbv,
      cubeTempStartC: cubeTempStartC ?? this.cubeTempStartC,
      cubeTempEndC: cubeTempEndC ?? this.cubeTempEndC,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (chargeVolumeL.present) {
      map['charge_volume_l'] = Variable<double>(chargeVolumeL.value);
    }
    if (chargeAbv.present) {
      map['charge_abv'] = Variable<double>(chargeAbv.value);
    }
    if (cubeTempStartC.present) {
      map['cube_temp_start_c'] = Variable<double>(cubeTempStartC.value);
    }
    if (cubeTempEndC.present) {
      map['cube_temp_end_c'] = Variable<double>(cubeTempEndC.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RunsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('kind: $kind, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('chargeVolumeL: $chargeVolumeL, ')
          ..write('chargeAbv: $chargeAbv, ')
          ..write('cubeTempStartC: $cubeTempStartC, ')
          ..write('cubeTempEndC: $cubeTempEndC, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RunFractionsTable extends RunFractions
    with TableInfo<$RunFractionsTable, RunFraction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RunFractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _runIdMeta = const VerificationMeta('runId');
  @override
  late final GeneratedColumn<String> runId = GeneratedColumn<String>(
    'run_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES runs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _jarNoMeta = const VerificationMeta('jarNo');
  @override
  late final GeneratedColumn<int> jarNo = GeneratedColumn<int>(
    'jar_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeMlMeta = const VerificationMeta(
    'volumeMl',
  );
  @override
  late final GeneratedColumn<double> volumeMl = GeneratedColumn<double>(
    'volume_ml',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abvMeta = const VerificationMeta('abv');
  @override
  late final GeneratedColumn<double> abv = GeneratedColumn<double>(
    'abv',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    runId,
    jarNo,
    kind,
    volumeMl,
    abv,
    tempC,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'run_fractions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RunFraction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('run_id')) {
      context.handle(
        _runIdMeta,
        runId.isAcceptableOrUnknown(data['run_id']!, _runIdMeta),
      );
    } else if (isInserting) {
      context.missing(_runIdMeta);
    }
    if (data.containsKey('jar_no')) {
      context.handle(
        _jarNoMeta,
        jarNo.isAcceptableOrUnknown(data['jar_no']!, _jarNoMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('volume_ml')) {
      context.handle(
        _volumeMlMeta,
        volumeMl.isAcceptableOrUnknown(data['volume_ml']!, _volumeMlMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMlMeta);
    }
    if (data.containsKey('abv')) {
      context.handle(
        _abvMeta,
        abv.isAcceptableOrUnknown(data['abv']!, _abvMeta),
      );
    } else if (isInserting) {
      context.missing(_abvMeta);
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RunFraction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RunFraction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      runId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}run_id'],
      )!,
      jarNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jar_no'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      volumeMl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_ml'],
      )!,
      abv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}abv'],
      )!,
      tempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temp_c'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $RunFractionsTable createAlias(String alias) {
    return $RunFractionsTable(attachedDatabase, alias);
  }
}

class RunFraction extends DataClass implements Insertable<RunFraction> {
  final int id;
  final String runId;
  final int jarNo;

  /// foreshots | heads | hearts | tails | feints
  final String kind;
  final double volumeMl;
  final double abv;
  final double? tempC;
  final String note;
  const RunFraction({
    required this.id,
    required this.runId,
    required this.jarNo,
    required this.kind,
    required this.volumeMl,
    required this.abv,
    this.tempC,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['run_id'] = Variable<String>(runId);
    map['jar_no'] = Variable<int>(jarNo);
    map['kind'] = Variable<String>(kind);
    map['volume_ml'] = Variable<double>(volumeMl);
    map['abv'] = Variable<double>(abv);
    if (!nullToAbsent || tempC != null) {
      map['temp_c'] = Variable<double>(tempC);
    }
    map['note'] = Variable<String>(note);
    return map;
  }

  RunFractionsCompanion toCompanion(bool nullToAbsent) {
    return RunFractionsCompanion(
      id: Value(id),
      runId: Value(runId),
      jarNo: Value(jarNo),
      kind: Value(kind),
      volumeMl: Value(volumeMl),
      abv: Value(abv),
      tempC: tempC == null && nullToAbsent
          ? const Value.absent()
          : Value(tempC),
      note: Value(note),
    );
  }

  factory RunFraction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RunFraction(
      id: serializer.fromJson<int>(json['id']),
      runId: serializer.fromJson<String>(json['runId']),
      jarNo: serializer.fromJson<int>(json['jarNo']),
      kind: serializer.fromJson<String>(json['kind']),
      volumeMl: serializer.fromJson<double>(json['volumeMl']),
      abv: serializer.fromJson<double>(json['abv']),
      tempC: serializer.fromJson<double?>(json['tempC']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'runId': serializer.toJson<String>(runId),
      'jarNo': serializer.toJson<int>(jarNo),
      'kind': serializer.toJson<String>(kind),
      'volumeMl': serializer.toJson<double>(volumeMl),
      'abv': serializer.toJson<double>(abv),
      'tempC': serializer.toJson<double?>(tempC),
      'note': serializer.toJson<String>(note),
    };
  }

  RunFraction copyWith({
    int? id,
    String? runId,
    int? jarNo,
    String? kind,
    double? volumeMl,
    double? abv,
    Value<double?> tempC = const Value.absent(),
    String? note,
  }) => RunFraction(
    id: id ?? this.id,
    runId: runId ?? this.runId,
    jarNo: jarNo ?? this.jarNo,
    kind: kind ?? this.kind,
    volumeMl: volumeMl ?? this.volumeMl,
    abv: abv ?? this.abv,
    tempC: tempC.present ? tempC.value : this.tempC,
    note: note ?? this.note,
  );
  RunFraction copyWithCompanion(RunFractionsCompanion data) {
    return RunFraction(
      id: data.id.present ? data.id.value : this.id,
      runId: data.runId.present ? data.runId.value : this.runId,
      jarNo: data.jarNo.present ? data.jarNo.value : this.jarNo,
      kind: data.kind.present ? data.kind.value : this.kind,
      volumeMl: data.volumeMl.present ? data.volumeMl.value : this.volumeMl,
      abv: data.abv.present ? data.abv.value : this.abv,
      tempC: data.tempC.present ? data.tempC.value : this.tempC,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RunFraction(')
          ..write('id: $id, ')
          ..write('runId: $runId, ')
          ..write('jarNo: $jarNo, ')
          ..write('kind: $kind, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('abv: $abv, ')
          ..write('tempC: $tempC, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, runId, jarNo, kind, volumeMl, abv, tempC, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RunFraction &&
          other.id == this.id &&
          other.runId == this.runId &&
          other.jarNo == this.jarNo &&
          other.kind == this.kind &&
          other.volumeMl == this.volumeMl &&
          other.abv == this.abv &&
          other.tempC == this.tempC &&
          other.note == this.note);
}

class RunFractionsCompanion extends UpdateCompanion<RunFraction> {
  final Value<int> id;
  final Value<String> runId;
  final Value<int> jarNo;
  final Value<String> kind;
  final Value<double> volumeMl;
  final Value<double> abv;
  final Value<double?> tempC;
  final Value<String> note;
  const RunFractionsCompanion({
    this.id = const Value.absent(),
    this.runId = const Value.absent(),
    this.jarNo = const Value.absent(),
    this.kind = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.abv = const Value.absent(),
    this.tempC = const Value.absent(),
    this.note = const Value.absent(),
  });
  RunFractionsCompanion.insert({
    this.id = const Value.absent(),
    required String runId,
    this.jarNo = const Value.absent(),
    required String kind,
    required double volumeMl,
    required double abv,
    this.tempC = const Value.absent(),
    this.note = const Value.absent(),
  }) : runId = Value(runId),
       kind = Value(kind),
       volumeMl = Value(volumeMl),
       abv = Value(abv);
  static Insertable<RunFraction> custom({
    Expression<int>? id,
    Expression<String>? runId,
    Expression<int>? jarNo,
    Expression<String>? kind,
    Expression<double>? volumeMl,
    Expression<double>? abv,
    Expression<double>? tempC,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (runId != null) 'run_id': runId,
      if (jarNo != null) 'jar_no': jarNo,
      if (kind != null) 'kind': kind,
      if (volumeMl != null) 'volume_ml': volumeMl,
      if (abv != null) 'abv': abv,
      if (tempC != null) 'temp_c': tempC,
      if (note != null) 'note': note,
    });
  }

  RunFractionsCompanion copyWith({
    Value<int>? id,
    Value<String>? runId,
    Value<int>? jarNo,
    Value<String>? kind,
    Value<double>? volumeMl,
    Value<double>? abv,
    Value<double?>? tempC,
    Value<String>? note,
  }) {
    return RunFractionsCompanion(
      id: id ?? this.id,
      runId: runId ?? this.runId,
      jarNo: jarNo ?? this.jarNo,
      kind: kind ?? this.kind,
      volumeMl: volumeMl ?? this.volumeMl,
      abv: abv ?? this.abv,
      tempC: tempC ?? this.tempC,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (runId.present) {
      map['run_id'] = Variable<String>(runId.value);
    }
    if (jarNo.present) {
      map['jar_no'] = Variable<int>(jarNo.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (volumeMl.present) {
      map['volume_ml'] = Variable<double>(volumeMl.value);
    }
    if (abv.present) {
      map['abv'] = Variable<double>(abv.value);
    }
    if (tempC.present) {
      map['temp_c'] = Variable<double>(tempC.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RunFractionsCompanion(')
          ..write('id: $id, ')
          ..write('runId: $runId, ')
          ..write('jarNo: $jarNo, ')
          ..write('kind: $kind, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('abv: $abv, ')
          ..write('tempC: $tempC, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $VesselsTable extends Vessels with TableInfo<$VesselsTable, Vessel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VesselsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeLMeta = const VerificationMeta(
    'volumeL',
  );
  @override
  late final GeneratedColumn<double> volumeL = GeneratedColumn<double>(
    'volume_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialMeta = const VerificationMeta(
    'material',
  );
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
    'material',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _charLevelMeta = const VerificationMeta(
    'charLevel',
  );
  @override
  late final GeneratedColumn<int> charLevel = GeneratedColumn<int>(
    'char_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isOccupiedMeta = const VerificationMeta(
    'isOccupied',
  );
  @override
  late final GeneratedColumn<bool> isOccupied = GeneratedColumn<bool>(
    'is_occupied',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_occupied" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    volumeL,
    material,
    charLevel,
    location,
    isOccupied,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vessels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vessel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('volume_l')) {
      context.handle(
        _volumeLMeta,
        volumeL.isAcceptableOrUnknown(data['volume_l']!, _volumeLMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeLMeta);
    }
    if (data.containsKey('material')) {
      context.handle(
        _materialMeta,
        material.isAcceptableOrUnknown(data['material']!, _materialMeta),
      );
    }
    if (data.containsKey('char_level')) {
      context.handle(
        _charLevelMeta,
        charLevel.isAcceptableOrUnknown(data['char_level']!, _charLevelMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('is_occupied')) {
      context.handle(
        _isOccupiedMeta,
        isOccupied.isAcceptableOrUnknown(data['is_occupied']!, _isOccupiedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vessel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vessel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      volumeL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_l'],
      )!,
      material: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material'],
      )!,
      charLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}char_level'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      isOccupied: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_occupied'],
      )!,
    );
  }

  @override
  $VesselsTable createAlias(String alias) {
    return $VesselsTable(attachedDatabase, alias);
  }
}

class Vessel extends DataClass implements Insertable<Vessel> {
  final String id;
  final String name;

  /// barrel | glass | steel | jar | bottle | fermenter
  final String kind;
  final double volumeL;
  final String material;

  /// Обжиг бочки: 1 — лёгкий, 2 — средний, 3 — сильный.
  final int? charLevel;
  final String location;
  final bool isOccupied;
  const Vessel({
    required this.id,
    required this.name,
    required this.kind,
    required this.volumeL,
    required this.material,
    this.charLevel,
    required this.location,
    required this.isOccupied,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['volume_l'] = Variable<double>(volumeL);
    map['material'] = Variable<String>(material);
    if (!nullToAbsent || charLevel != null) {
      map['char_level'] = Variable<int>(charLevel);
    }
    map['location'] = Variable<String>(location);
    map['is_occupied'] = Variable<bool>(isOccupied);
    return map;
  }

  VesselsCompanion toCompanion(bool nullToAbsent) {
    return VesselsCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      volumeL: Value(volumeL),
      material: Value(material),
      charLevel: charLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(charLevel),
      location: Value(location),
      isOccupied: Value(isOccupied),
    );
  }

  factory Vessel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vessel(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      volumeL: serializer.fromJson<double>(json['volumeL']),
      material: serializer.fromJson<String>(json['material']),
      charLevel: serializer.fromJson<int?>(json['charLevel']),
      location: serializer.fromJson<String>(json['location']),
      isOccupied: serializer.fromJson<bool>(json['isOccupied']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'volumeL': serializer.toJson<double>(volumeL),
      'material': serializer.toJson<String>(material),
      'charLevel': serializer.toJson<int?>(charLevel),
      'location': serializer.toJson<String>(location),
      'isOccupied': serializer.toJson<bool>(isOccupied),
    };
  }

  Vessel copyWith({
    String? id,
    String? name,
    String? kind,
    double? volumeL,
    String? material,
    Value<int?> charLevel = const Value.absent(),
    String? location,
    bool? isOccupied,
  }) => Vessel(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    volumeL: volumeL ?? this.volumeL,
    material: material ?? this.material,
    charLevel: charLevel.present ? charLevel.value : this.charLevel,
    location: location ?? this.location,
    isOccupied: isOccupied ?? this.isOccupied,
  );
  Vessel copyWithCompanion(VesselsCompanion data) {
    return Vessel(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      volumeL: data.volumeL.present ? data.volumeL.value : this.volumeL,
      material: data.material.present ? data.material.value : this.material,
      charLevel: data.charLevel.present ? data.charLevel.value : this.charLevel,
      location: data.location.present ? data.location.value : this.location,
      isOccupied: data.isOccupied.present
          ? data.isOccupied.value
          : this.isOccupied,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vessel(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('volumeL: $volumeL, ')
          ..write('material: $material, ')
          ..write('charLevel: $charLevel, ')
          ..write('location: $location, ')
          ..write('isOccupied: $isOccupied')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    kind,
    volumeL,
    material,
    charLevel,
    location,
    isOccupied,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vessel &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.volumeL == this.volumeL &&
          other.material == this.material &&
          other.charLevel == this.charLevel &&
          other.location == this.location &&
          other.isOccupied == this.isOccupied);
}

class VesselsCompanion extends UpdateCompanion<Vessel> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<double> volumeL;
  final Value<String> material;
  final Value<int?> charLevel;
  final Value<String> location;
  final Value<bool> isOccupied;
  final Value<int> rowid;
  const VesselsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.volumeL = const Value.absent(),
    this.material = const Value.absent(),
    this.charLevel = const Value.absent(),
    this.location = const Value.absent(),
    this.isOccupied = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VesselsCompanion.insert({
    required String id,
    required String name,
    required String kind,
    required double volumeL,
    this.material = const Value.absent(),
    this.charLevel = const Value.absent(),
    this.location = const Value.absent(),
    this.isOccupied = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind),
       volumeL = Value(volumeL);
  static Insertable<Vessel> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<double>? volumeL,
    Expression<String>? material,
    Expression<int>? charLevel,
    Expression<String>? location,
    Expression<bool>? isOccupied,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (volumeL != null) 'volume_l': volumeL,
      if (material != null) 'material': material,
      if (charLevel != null) 'char_level': charLevel,
      if (location != null) 'location': location,
      if (isOccupied != null) 'is_occupied': isOccupied,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VesselsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<double>? volumeL,
    Value<String>? material,
    Value<int?>? charLevel,
    Value<String>? location,
    Value<bool>? isOccupied,
    Value<int>? rowid,
  }) {
    return VesselsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      volumeL: volumeL ?? this.volumeL,
      material: material ?? this.material,
      charLevel: charLevel ?? this.charLevel,
      location: location ?? this.location,
      isOccupied: isOccupied ?? this.isOccupied,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (volumeL.present) {
      map['volume_l'] = Variable<double>(volumeL.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (charLevel.present) {
      map['char_level'] = Variable<int>(charLevel.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (isOccupied.present) {
      map['is_occupied'] = Variable<bool>(isOccupied.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VesselsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('volumeL: $volumeL, ')
          ..write('material: $material, ')
          ..write('charLevel: $charLevel, ')
          ..write('location: $location, ')
          ..write('isOccupied: $isOccupied, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgingTable extends Aging with TableInfo<$AgingTable, AgingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _vesselIdMeta = const VerificationMeta(
    'vesselId',
  );
  @override
  late final GeneratedColumn<String> vesselId = GeneratedColumn<String>(
    'vessel_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vessels (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedEndAtMeta = const VerificationMeta(
    'plannedEndAt',
  );
  @override
  late final GeneratedColumn<DateTime> plannedEndAt = GeneratedColumn<DateTime>(
    'planned_end_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _angelSharePctYearMeta = const VerificationMeta(
    'angelSharePctYear',
  );
  @override
  late final GeneratedColumn<double> angelSharePctYear =
      GeneratedColumn<double>(
        'angel_share_pct_year',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(3),
      );
  static const VerificationMeta _lastToppedAtMeta = const VerificationMeta(
    'lastToppedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastToppedAt = GeneratedColumn<DateTime>(
    'last_topped_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    vesselId,
    startedAt,
    plannedEndAt,
    angelSharePctYear,
    lastToppedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aging';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('vessel_id')) {
      context.handle(
        _vesselIdMeta,
        vesselId.isAcceptableOrUnknown(data['vessel_id']!, _vesselIdMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('planned_end_at')) {
      context.handle(
        _plannedEndAtMeta,
        plannedEndAt.isAcceptableOrUnknown(
          data['planned_end_at']!,
          _plannedEndAtMeta,
        ),
      );
    }
    if (data.containsKey('angel_share_pct_year')) {
      context.handle(
        _angelSharePctYearMeta,
        angelSharePctYear.isAcceptableOrUnknown(
          data['angel_share_pct_year']!,
          _angelSharePctYearMeta,
        ),
      );
    }
    if (data.containsKey('last_topped_at')) {
      context.handle(
        _lastToppedAtMeta,
        lastToppedAt.isAcceptableOrUnknown(
          data['last_topped_at']!,
          _lastToppedAtMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgingEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      vesselId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vessel_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      plannedEndAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planned_end_at'],
      ),
      angelSharePctYear: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}angel_share_pct_year'],
      )!,
      lastToppedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_topped_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $AgingTable createAlias(String alias) {
    return $AgingTable(attachedDatabase, alias);
  }
}

class AgingEntry extends DataClass implements Insertable<AgingEntry> {
  final String id;
  final String batchId;
  final String? vesselId;
  final DateTime startedAt;
  final DateTime? plannedEndAt;

  /// Потери на испарение, % в год.
  final double angelSharePctYear;
  final DateTime? lastToppedAt;
  final String notes;
  const AgingEntry({
    required this.id,
    required this.batchId,
    this.vesselId,
    required this.startedAt,
    this.plannedEndAt,
    required this.angelSharePctYear,
    this.lastToppedAt,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    if (!nullToAbsent || vesselId != null) {
      map['vessel_id'] = Variable<String>(vesselId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || plannedEndAt != null) {
      map['planned_end_at'] = Variable<DateTime>(plannedEndAt);
    }
    map['angel_share_pct_year'] = Variable<double>(angelSharePctYear);
    if (!nullToAbsent || lastToppedAt != null) {
      map['last_topped_at'] = Variable<DateTime>(lastToppedAt);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  AgingCompanion toCompanion(bool nullToAbsent) {
    return AgingCompanion(
      id: Value(id),
      batchId: Value(batchId),
      vesselId: vesselId == null && nullToAbsent
          ? const Value.absent()
          : Value(vesselId),
      startedAt: Value(startedAt),
      plannedEndAt: plannedEndAt == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedEndAt),
      angelSharePctYear: Value(angelSharePctYear),
      lastToppedAt: lastToppedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastToppedAt),
      notes: Value(notes),
    );
  }

  factory AgingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgingEntry(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      vesselId: serializer.fromJson<String?>(json['vesselId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      plannedEndAt: serializer.fromJson<DateTime?>(json['plannedEndAt']),
      angelSharePctYear: serializer.fromJson<double>(json['angelSharePctYear']),
      lastToppedAt: serializer.fromJson<DateTime?>(json['lastToppedAt']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'vesselId': serializer.toJson<String?>(vesselId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'plannedEndAt': serializer.toJson<DateTime?>(plannedEndAt),
      'angelSharePctYear': serializer.toJson<double>(angelSharePctYear),
      'lastToppedAt': serializer.toJson<DateTime?>(lastToppedAt),
      'notes': serializer.toJson<String>(notes),
    };
  }

  AgingEntry copyWith({
    String? id,
    String? batchId,
    Value<String?> vesselId = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> plannedEndAt = const Value.absent(),
    double? angelSharePctYear,
    Value<DateTime?> lastToppedAt = const Value.absent(),
    String? notes,
  }) => AgingEntry(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    vesselId: vesselId.present ? vesselId.value : this.vesselId,
    startedAt: startedAt ?? this.startedAt,
    plannedEndAt: plannedEndAt.present ? plannedEndAt.value : this.plannedEndAt,
    angelSharePctYear: angelSharePctYear ?? this.angelSharePctYear,
    lastToppedAt: lastToppedAt.present ? lastToppedAt.value : this.lastToppedAt,
    notes: notes ?? this.notes,
  );
  AgingEntry copyWithCompanion(AgingCompanion data) {
    return AgingEntry(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      vesselId: data.vesselId.present ? data.vesselId.value : this.vesselId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      plannedEndAt: data.plannedEndAt.present
          ? data.plannedEndAt.value
          : this.plannedEndAt,
      angelSharePctYear: data.angelSharePctYear.present
          ? data.angelSharePctYear.value
          : this.angelSharePctYear,
      lastToppedAt: data.lastToppedAt.present
          ? data.lastToppedAt.value
          : this.lastToppedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgingEntry(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('vesselId: $vesselId, ')
          ..write('startedAt: $startedAt, ')
          ..write('plannedEndAt: $plannedEndAt, ')
          ..write('angelSharePctYear: $angelSharePctYear, ')
          ..write('lastToppedAt: $lastToppedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    vesselId,
    startedAt,
    plannedEndAt,
    angelSharePctYear,
    lastToppedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgingEntry &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.vesselId == this.vesselId &&
          other.startedAt == this.startedAt &&
          other.plannedEndAt == this.plannedEndAt &&
          other.angelSharePctYear == this.angelSharePctYear &&
          other.lastToppedAt == this.lastToppedAt &&
          other.notes == this.notes);
}

class AgingCompanion extends UpdateCompanion<AgingEntry> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<String?> vesselId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> plannedEndAt;
  final Value<double> angelSharePctYear;
  final Value<DateTime?> lastToppedAt;
  final Value<String> notes;
  final Value<int> rowid;
  const AgingCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.vesselId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.plannedEndAt = const Value.absent(),
    this.angelSharePctYear = const Value.absent(),
    this.lastToppedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgingCompanion.insert({
    required String id,
    required String batchId,
    this.vesselId = const Value.absent(),
    required DateTime startedAt,
    this.plannedEndAt = const Value.absent(),
    this.angelSharePctYear = const Value.absent(),
    this.lastToppedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       startedAt = Value(startedAt);
  static Insertable<AgingEntry> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<String>? vesselId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? plannedEndAt,
    Expression<double>? angelSharePctYear,
    Expression<DateTime>? lastToppedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (vesselId != null) 'vessel_id': vesselId,
      if (startedAt != null) 'started_at': startedAt,
      if (plannedEndAt != null) 'planned_end_at': plannedEndAt,
      if (angelSharePctYear != null) 'angel_share_pct_year': angelSharePctYear,
      if (lastToppedAt != null) 'last_topped_at': lastToppedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgingCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<String?>? vesselId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? plannedEndAt,
    Value<double>? angelSharePctYear,
    Value<DateTime?>? lastToppedAt,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return AgingCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      vesselId: vesselId ?? this.vesselId,
      startedAt: startedAt ?? this.startedAt,
      plannedEndAt: plannedEndAt ?? this.plannedEndAt,
      angelSharePctYear: angelSharePctYear ?? this.angelSharePctYear,
      lastToppedAt: lastToppedAt ?? this.lastToppedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (vesselId.present) {
      map['vessel_id'] = Variable<String>(vesselId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (plannedEndAt.present) {
      map['planned_end_at'] = Variable<DateTime>(plannedEndAt.value);
    }
    if (angelSharePctYear.present) {
      map['angel_share_pct_year'] = Variable<double>(angelSharePctYear.value);
    }
    if (lastToppedAt.present) {
      map['last_topped_at'] = Variable<DateTime>(lastToppedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgingCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('vesselId: $vesselId, ')
          ..write('startedAt: $startedAt, ')
          ..write('plannedEndAt: $plannedEndAt, ')
          ..write('angelSharePctYear: $angelSharePctYear, ')
          ..write('lastToppedAt: $lastToppedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MacerationsTable extends Macerations
    with TableInfo<$MacerationsTable, Maceration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MacerationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedEndAtMeta = const VerificationMeta(
    'plannedEndAt',
  );
  @override
  late final GeneratedColumn<DateTime> plannedEndAt = GeneratedColumn<DateTime>(
    'planned_end_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shakeEveryDaysMeta = const VerificationMeta(
    'shakeEveryDays',
  );
  @override
  late final GeneratedColumn<int> shakeEveryDays = GeneratedColumn<int>(
    'shake_every_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _lastShakenAtMeta = const VerificationMeta(
    'lastShakenAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastShakenAt = GeneratedColumn<DateTime>(
    'last_shaken_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shakenCountMeta = const VerificationMeta(
    'shakenCount',
  );
  @override
  late final GeneratedColumn<int> shakenCount = GeneratedColumn<int>(
    'shaken_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _strengthAbvMeta = const VerificationMeta(
    'strengthAbv',
  );
  @override
  late final GeneratedColumn<double> strengthAbv = GeneratedColumn<double>(
    'strength_abv',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    startedAt,
    plannedEndAt,
    shakeEveryDays,
    lastShakenAt,
    shakenCount,
    strengthAbv,
    finishedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'macerations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Maceration> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('planned_end_at')) {
      context.handle(
        _plannedEndAtMeta,
        plannedEndAt.isAcceptableOrUnknown(
          data['planned_end_at']!,
          _plannedEndAtMeta,
        ),
      );
    }
    if (data.containsKey('shake_every_days')) {
      context.handle(
        _shakeEveryDaysMeta,
        shakeEveryDays.isAcceptableOrUnknown(
          data['shake_every_days']!,
          _shakeEveryDaysMeta,
        ),
      );
    }
    if (data.containsKey('last_shaken_at')) {
      context.handle(
        _lastShakenAtMeta,
        lastShakenAt.isAcceptableOrUnknown(
          data['last_shaken_at']!,
          _lastShakenAtMeta,
        ),
      );
    }
    if (data.containsKey('shaken_count')) {
      context.handle(
        _shakenCountMeta,
        shakenCount.isAcceptableOrUnknown(
          data['shaken_count']!,
          _shakenCountMeta,
        ),
      );
    }
    if (data.containsKey('strength_abv')) {
      context.handle(
        _strengthAbvMeta,
        strengthAbv.isAcceptableOrUnknown(
          data['strength_abv']!,
          _strengthAbvMeta,
        ),
      );
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Maceration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Maceration(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      plannedEndAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planned_end_at'],
      ),
      shakeEveryDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shake_every_days'],
      )!,
      lastShakenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_shaken_at'],
      ),
      shakenCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shaken_count'],
      )!,
      strengthAbv: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}strength_abv'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $MacerationsTable createAlias(String alias) {
    return $MacerationsTable(attachedDatabase, alias);
  }
}

class Maceration extends DataClass implements Insertable<Maceration> {
  final String id;
  final String batchId;
  final DateTime startedAt;

  /// Плановое снятие с осадка. null — срок не задан.
  final DateTime? plannedEndAt;

  /// Взбалтывать каждые N дней. 0 — не взбалтываем.
  final int shakeEveryDays;
  final DateTime? lastShakenAt;
  final int shakenCount;

  /// Крепость спирта, на котором стоит сырьё, %.
  final double strengthAbv;
  final DateTime? finishedAt;
  final String notes;
  const Maceration({
    required this.id,
    required this.batchId,
    required this.startedAt,
    this.plannedEndAt,
    required this.shakeEveryDays,
    this.lastShakenAt,
    required this.shakenCount,
    required this.strengthAbv,
    this.finishedAt,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || plannedEndAt != null) {
      map['planned_end_at'] = Variable<DateTime>(plannedEndAt);
    }
    map['shake_every_days'] = Variable<int>(shakeEveryDays);
    if (!nullToAbsent || lastShakenAt != null) {
      map['last_shaken_at'] = Variable<DateTime>(lastShakenAt);
    }
    map['shaken_count'] = Variable<int>(shakenCount);
    map['strength_abv'] = Variable<double>(strengthAbv);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    map['notes'] = Variable<String>(notes);
    return map;
  }

  MacerationsCompanion toCompanion(bool nullToAbsent) {
    return MacerationsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      startedAt: Value(startedAt),
      plannedEndAt: plannedEndAt == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedEndAt),
      shakeEveryDays: Value(shakeEveryDays),
      lastShakenAt: lastShakenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastShakenAt),
      shakenCount: Value(shakenCount),
      strengthAbv: Value(strengthAbv),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      notes: Value(notes),
    );
  }

  factory Maceration.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Maceration(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      plannedEndAt: serializer.fromJson<DateTime?>(json['plannedEndAt']),
      shakeEveryDays: serializer.fromJson<int>(json['shakeEveryDays']),
      lastShakenAt: serializer.fromJson<DateTime?>(json['lastShakenAt']),
      shakenCount: serializer.fromJson<int>(json['shakenCount']),
      strengthAbv: serializer.fromJson<double>(json['strengthAbv']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'plannedEndAt': serializer.toJson<DateTime?>(plannedEndAt),
      'shakeEveryDays': serializer.toJson<int>(shakeEveryDays),
      'lastShakenAt': serializer.toJson<DateTime?>(lastShakenAt),
      'shakenCount': serializer.toJson<int>(shakenCount),
      'strengthAbv': serializer.toJson<double>(strengthAbv),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'notes': serializer.toJson<String>(notes),
    };
  }

  Maceration copyWith({
    String? id,
    String? batchId,
    DateTime? startedAt,
    Value<DateTime?> plannedEndAt = const Value.absent(),
    int? shakeEveryDays,
    Value<DateTime?> lastShakenAt = const Value.absent(),
    int? shakenCount,
    double? strengthAbv,
    Value<DateTime?> finishedAt = const Value.absent(),
    String? notes,
  }) => Maceration(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    startedAt: startedAt ?? this.startedAt,
    plannedEndAt: plannedEndAt.present ? plannedEndAt.value : this.plannedEndAt,
    shakeEveryDays: shakeEveryDays ?? this.shakeEveryDays,
    lastShakenAt: lastShakenAt.present ? lastShakenAt.value : this.lastShakenAt,
    shakenCount: shakenCount ?? this.shakenCount,
    strengthAbv: strengthAbv ?? this.strengthAbv,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    notes: notes ?? this.notes,
  );
  Maceration copyWithCompanion(MacerationsCompanion data) {
    return Maceration(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      plannedEndAt: data.plannedEndAt.present
          ? data.plannedEndAt.value
          : this.plannedEndAt,
      shakeEveryDays: data.shakeEveryDays.present
          ? data.shakeEveryDays.value
          : this.shakeEveryDays,
      lastShakenAt: data.lastShakenAt.present
          ? data.lastShakenAt.value
          : this.lastShakenAt,
      shakenCount: data.shakenCount.present
          ? data.shakenCount.value
          : this.shakenCount,
      strengthAbv: data.strengthAbv.present
          ? data.strengthAbv.value
          : this.strengthAbv,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Maceration(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('startedAt: $startedAt, ')
          ..write('plannedEndAt: $plannedEndAt, ')
          ..write('shakeEveryDays: $shakeEveryDays, ')
          ..write('lastShakenAt: $lastShakenAt, ')
          ..write('shakenCount: $shakenCount, ')
          ..write('strengthAbv: $strengthAbv, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    startedAt,
    plannedEndAt,
    shakeEveryDays,
    lastShakenAt,
    shakenCount,
    strengthAbv,
    finishedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Maceration &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.startedAt == this.startedAt &&
          other.plannedEndAt == this.plannedEndAt &&
          other.shakeEveryDays == this.shakeEveryDays &&
          other.lastShakenAt == this.lastShakenAt &&
          other.shakenCount == this.shakenCount &&
          other.strengthAbv == this.strengthAbv &&
          other.finishedAt == this.finishedAt &&
          other.notes == this.notes);
}

class MacerationsCompanion extends UpdateCompanion<Maceration> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> plannedEndAt;
  final Value<int> shakeEveryDays;
  final Value<DateTime?> lastShakenAt;
  final Value<int> shakenCount;
  final Value<double> strengthAbv;
  final Value<DateTime?> finishedAt;
  final Value<String> notes;
  final Value<int> rowid;
  const MacerationsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.plannedEndAt = const Value.absent(),
    this.shakeEveryDays = const Value.absent(),
    this.lastShakenAt = const Value.absent(),
    this.shakenCount = const Value.absent(),
    this.strengthAbv = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MacerationsCompanion.insert({
    required String id,
    required String batchId,
    required DateTime startedAt,
    this.plannedEndAt = const Value.absent(),
    this.shakeEveryDays = const Value.absent(),
    this.lastShakenAt = const Value.absent(),
    this.shakenCount = const Value.absent(),
    this.strengthAbv = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       startedAt = Value(startedAt);
  static Insertable<Maceration> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? plannedEndAt,
    Expression<int>? shakeEveryDays,
    Expression<DateTime>? lastShakenAt,
    Expression<int>? shakenCount,
    Expression<double>? strengthAbv,
    Expression<DateTime>? finishedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (startedAt != null) 'started_at': startedAt,
      if (plannedEndAt != null) 'planned_end_at': plannedEndAt,
      if (shakeEveryDays != null) 'shake_every_days': shakeEveryDays,
      if (lastShakenAt != null) 'last_shaken_at': lastShakenAt,
      if (shakenCount != null) 'shaken_count': shakenCount,
      if (strengthAbv != null) 'strength_abv': strengthAbv,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MacerationsCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? plannedEndAt,
    Value<int>? shakeEveryDays,
    Value<DateTime?>? lastShakenAt,
    Value<int>? shakenCount,
    Value<double>? strengthAbv,
    Value<DateTime?>? finishedAt,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return MacerationsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      startedAt: startedAt ?? this.startedAt,
      plannedEndAt: plannedEndAt ?? this.plannedEndAt,
      shakeEveryDays: shakeEveryDays ?? this.shakeEveryDays,
      lastShakenAt: lastShakenAt ?? this.lastShakenAt,
      shakenCount: shakenCount ?? this.shakenCount,
      strengthAbv: strengthAbv ?? this.strengthAbv,
      finishedAt: finishedAt ?? this.finishedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (plannedEndAt.present) {
      map['planned_end_at'] = Variable<DateTime>(plannedEndAt.value);
    }
    if (shakeEveryDays.present) {
      map['shake_every_days'] = Variable<int>(shakeEveryDays.value);
    }
    if (lastShakenAt.present) {
      map['last_shaken_at'] = Variable<DateTime>(lastShakenAt.value);
    }
    if (shakenCount.present) {
      map['shaken_count'] = Variable<int>(shakenCount.value);
    }
    if (strengthAbv.present) {
      map['strength_abv'] = Variable<double>(strengthAbv.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MacerationsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('startedAt: $startedAt, ')
          ..write('plannedEndAt: $plannedEndAt, ')
          ..write('shakeEveryDays: $shakeEveryDays, ')
          ..write('lastShakenAt: $lastShakenAt, ')
          ..write('shakenCount: $shakenCount, ')
          ..write('strengthAbv: $strengthAbv, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TastingsTable extends Tastings with TableInfo<$TastingsTable, Tasting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TastingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _aromaMeta = const VerificationMeta('aroma');
  @override
  late final GeneratedColumn<String> aroma = GeneratedColumn<String>(
    'aroma',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _tasteMeta = const VerificationMeta('taste');
  @override
  late final GeneratedColumn<String> taste = GeneratedColumn<String>(
    'taste',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _finishMeta = const VerificationMeta('finish');
  @override
  late final GeneratedColumn<String> finish = GeneratedColumn<String>(
    'finish',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _verdictMeta = const VerificationMeta(
    'verdict',
  );
  @override
  late final GeneratedColumn<String> verdict = GeneratedColumn<String>(
    'verdict',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    at,
    rating,
    aroma,
    taste,
    finish,
    verdict,
    photoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tastings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tasting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('aroma')) {
      context.handle(
        _aromaMeta,
        aroma.isAcceptableOrUnknown(data['aroma']!, _aromaMeta),
      );
    }
    if (data.containsKey('taste')) {
      context.handle(
        _tasteMeta,
        taste.isAcceptableOrUnknown(data['taste']!, _tasteMeta),
      );
    }
    if (data.containsKey('finish')) {
      context.handle(
        _finishMeta,
        finish.isAcceptableOrUnknown(data['finish']!, _finishMeta),
      );
    }
    if (data.containsKey('verdict')) {
      context.handle(
        _verdictMeta,
        verdict.isAcceptableOrUnknown(data['verdict']!, _verdictMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tasting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tasting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      aroma: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aroma'],
      )!,
      taste: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taste'],
      )!,
      finish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}finish'],
      )!,
      verdict: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verdict'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      )!,
    );
  }

  @override
  $TastingsTable createAlias(String alias) {
    return $TastingsTable(attachedDatabase, alias);
  }
}

class Tasting extends DataClass implements Insertable<Tasting> {
  final String id;
  final String batchId;
  final DateTime at;

  /// 1..5
  final int rating;
  final String aroma;
  final String taste;
  final String finish;
  final String verdict;
  final String photoPath;
  const Tasting({
    required this.id,
    required this.batchId,
    required this.at,
    required this.rating,
    required this.aroma,
    required this.taste,
    required this.finish,
    required this.verdict,
    required this.photoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['at'] = Variable<DateTime>(at);
    map['rating'] = Variable<int>(rating);
    map['aroma'] = Variable<String>(aroma);
    map['taste'] = Variable<String>(taste);
    map['finish'] = Variable<String>(finish);
    map['verdict'] = Variable<String>(verdict);
    map['photo_path'] = Variable<String>(photoPath);
    return map;
  }

  TastingsCompanion toCompanion(bool nullToAbsent) {
    return TastingsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      at: Value(at),
      rating: Value(rating),
      aroma: Value(aroma),
      taste: Value(taste),
      finish: Value(finish),
      verdict: Value(verdict),
      photoPath: Value(photoPath),
    );
  }

  factory Tasting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tasting(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      at: serializer.fromJson<DateTime>(json['at']),
      rating: serializer.fromJson<int>(json['rating']),
      aroma: serializer.fromJson<String>(json['aroma']),
      taste: serializer.fromJson<String>(json['taste']),
      finish: serializer.fromJson<String>(json['finish']),
      verdict: serializer.fromJson<String>(json['verdict']),
      photoPath: serializer.fromJson<String>(json['photoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'at': serializer.toJson<DateTime>(at),
      'rating': serializer.toJson<int>(rating),
      'aroma': serializer.toJson<String>(aroma),
      'taste': serializer.toJson<String>(taste),
      'finish': serializer.toJson<String>(finish),
      'verdict': serializer.toJson<String>(verdict),
      'photoPath': serializer.toJson<String>(photoPath),
    };
  }

  Tasting copyWith({
    String? id,
    String? batchId,
    DateTime? at,
    int? rating,
    String? aroma,
    String? taste,
    String? finish,
    String? verdict,
    String? photoPath,
  }) => Tasting(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    at: at ?? this.at,
    rating: rating ?? this.rating,
    aroma: aroma ?? this.aroma,
    taste: taste ?? this.taste,
    finish: finish ?? this.finish,
    verdict: verdict ?? this.verdict,
    photoPath: photoPath ?? this.photoPath,
  );
  Tasting copyWithCompanion(TastingsCompanion data) {
    return Tasting(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      at: data.at.present ? data.at.value : this.at,
      rating: data.rating.present ? data.rating.value : this.rating,
      aroma: data.aroma.present ? data.aroma.value : this.aroma,
      taste: data.taste.present ? data.taste.value : this.taste,
      finish: data.finish.present ? data.finish.value : this.finish,
      verdict: data.verdict.present ? data.verdict.value : this.verdict,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tasting(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('at: $at, ')
          ..write('rating: $rating, ')
          ..write('aroma: $aroma, ')
          ..write('taste: $taste, ')
          ..write('finish: $finish, ')
          ..write('verdict: $verdict, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    at,
    rating,
    aroma,
    taste,
    finish,
    verdict,
    photoPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tasting &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.at == this.at &&
          other.rating == this.rating &&
          other.aroma == this.aroma &&
          other.taste == this.taste &&
          other.finish == this.finish &&
          other.verdict == this.verdict &&
          other.photoPath == this.photoPath);
}

class TastingsCompanion extends UpdateCompanion<Tasting> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<DateTime> at;
  final Value<int> rating;
  final Value<String> aroma;
  final Value<String> taste;
  final Value<String> finish;
  final Value<String> verdict;
  final Value<String> photoPath;
  final Value<int> rowid;
  const TastingsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.at = const Value.absent(),
    this.rating = const Value.absent(),
    this.aroma = const Value.absent(),
    this.taste = const Value.absent(),
    this.finish = const Value.absent(),
    this.verdict = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TastingsCompanion.insert({
    required String id,
    required String batchId,
    required DateTime at,
    this.rating = const Value.absent(),
    this.aroma = const Value.absent(),
    this.taste = const Value.absent(),
    this.finish = const Value.absent(),
    this.verdict = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       at = Value(at);
  static Insertable<Tasting> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<DateTime>? at,
    Expression<int>? rating,
    Expression<String>? aroma,
    Expression<String>? taste,
    Expression<String>? finish,
    Expression<String>? verdict,
    Expression<String>? photoPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (at != null) 'at': at,
      if (rating != null) 'rating': rating,
      if (aroma != null) 'aroma': aroma,
      if (taste != null) 'taste': taste,
      if (finish != null) 'finish': finish,
      if (verdict != null) 'verdict': verdict,
      if (photoPath != null) 'photo_path': photoPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TastingsCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<DateTime>? at,
    Value<int>? rating,
    Value<String>? aroma,
    Value<String>? taste,
    Value<String>? finish,
    Value<String>? verdict,
    Value<String>? photoPath,
    Value<int>? rowid,
  }) {
    return TastingsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      at: at ?? this.at,
      rating: rating ?? this.rating,
      aroma: aroma ?? this.aroma,
      taste: taste ?? this.taste,
      finish: finish ?? this.finish,
      verdict: verdict ?? this.verdict,
      photoPath: photoPath ?? this.photoPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (aroma.present) {
      map['aroma'] = Variable<String>(aroma.value);
    }
    if (taste.present) {
      map['taste'] = Variable<String>(taste.value);
    }
    if (finish.present) {
      map['finish'] = Variable<String>(finish.value);
    }
    if (verdict.present) {
      map['verdict'] = Variable<String>(verdict.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TastingsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('at: $at, ')
          ..write('rating: $rating, ')
          ..write('aroma: $aroma, ')
          ..write('taste: $taste, ')
          ..write('finish: $finish, ')
          ..write('verdict: $verdict, ')
          ..write('photoPath: $photoPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $RecipeIngredientsTable recipeIngredients =
      $RecipeIngredientsTable(this);
  late final $RecipeStepsTable recipeSteps = $RecipeStepsTable(this);
  late final $BatchesTable batches = $BatchesTable(this);
  late final $BatchEventsTable batchEvents = $BatchEventsTable(this);
  late final $MeasurementsTable measurements = $MeasurementsTable(this);
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  late final $BatchIngredientsTable batchIngredients = $BatchIngredientsTable(
    this,
  );
  late final $RunsTable runs = $RunsTable(this);
  late final $RunFractionsTable runFractions = $RunFractionsTable(this);
  late final $VesselsTable vessels = $VesselsTable(this);
  late final $AgingTable aging = $AgingTable(this);
  late final $MacerationsTable macerations = $MacerationsTable(this);
  late final $TastingsTable tastings = $TastingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    recipes,
    recipeIngredients,
    recipeSteps,
    batches,
    batchEvents,
    measurements,
    appMeta,
    batchIngredients,
    runs,
    runFractions,
    vessels,
    aging,
    macerations,
    tastings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('batch_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('measurements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('batch_ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('runs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'runs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('run_fractions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('aging', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('macerations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tastings', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$RecipesTableCreateCompanionBuilder = RecipesCompanion Function({
  required String id,
  required String title,
  required String kind,
  Value<String> styleTags,
  Value<double> baseVolumeL,
  Value<double> expectedYieldL,
  Value<double> expectedAbv,
  Value<String> summary,
  Value<String> source,
  Value<bool> isBuiltIn,
  Value<bool> isFavorite,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$RecipesTableUpdateCompanionBuilder = RecipesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> kind,
  Value<String> styleTags,
  Value<double> baseVolumeL,
  Value<double> expectedYieldL,
  Value<double> expectedAbv,
  Value<String> summary,
  Value<String> source,
  Value<bool> isBuiltIn,
  Value<bool> isFavorite,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$RecipesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipesTable, Recipe> {
  $$RecipesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredient>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: 'recipes__id__recipe_ingredients__recipe_id',
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeStepsTable, List<RecipeStep>>
  _recipeStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeSteps,
    aliasName: 'recipes__id__recipe_steps__recipe_id',
  );

  $$RecipeStepsTableProcessedTableManager get recipeStepsRefs {
    final manager = $$RecipeStepsTableTableManager(
      $_db,
      $_db.recipeSteps,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BatchesTable, List<Batch>> _batchesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.batches,
    aliasName: 'recipes__id__batches__recipe_id',
  );

  $$BatchesTableProcessedTableManager get batchesRefs {
    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get styleTags => $composableBuilder(
    column: $table.styleTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get baseVolumeL => $composableBuilder(
    column: $table.baseVolumeL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedYieldL => $composableBuilder(
    column: $table.expectedYieldL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedAbv => $composableBuilder(
    column: $table.expectedAbv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeStepsRefs(
    Expression<bool> Function($$RecipeStepsTableFilterComposer f) f,
  ) {
    final $$RecipeStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableFilterComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> batchesRefs(
    Expression<bool> Function($$BatchesTableFilterComposer f) f,
  ) {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get styleTags => $composableBuilder(
    column: $table.styleTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get baseVolumeL => $composableBuilder(
    column: $table.baseVolumeL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedYieldL => $composableBuilder(
    column: $table.expectedYieldL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedAbv => $composableBuilder(
    column: $table.expectedAbv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get styleTags =>
      $composableBuilder(column: $table.styleTags, builder: (column) => column);

  GeneratedColumn<double> get baseVolumeL => $composableBuilder(
    column: $table.baseVolumeL,
    builder: (column) => column,
  );

  GeneratedColumn<double> get expectedYieldL => $composableBuilder(
    column: $table.expectedYieldL,
    builder: (column) => column,
  );

  GeneratedColumn<double> get expectedAbv => $composableBuilder(
    column: $table.expectedAbv,
    builder: (column) => column,
  );

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recipeStepsRefs<T extends Object>(
    Expression<T> Function($$RecipeStepsTableAnnotationComposer a) f,
  ) {
    final $$RecipeStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> batchesRefs<T extends Object>(
    Expression<T> Function($$BatchesTableAnnotationComposer a) f,
  ) {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, $$RecipesTableReferences),
          Recipe,
          PrefetchHooks Function({
            bool recipeIngredientsRefs,
            bool recipeStepsRefs,
            bool batchesRefs,
          })
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> styleTags = const Value.absent(),
                Value<double> baseVolumeL = const Value.absent(),
                Value<double> expectedYieldL = const Value.absent(),
                Value<double> expectedAbv = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                title: title,
                kind: kind,
                styleTags: styleTags,
                baseVolumeL: baseVolumeL,
                expectedYieldL: expectedYieldL,
                expectedAbv: expectedAbv,
                summary: summary,
                source: source,
                isBuiltIn: isBuiltIn,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String kind,
                Value<String> styleTags = const Value.absent(),
                Value<double> baseVolumeL = const Value.absent(),
                Value<double> expectedYieldL = const Value.absent(),
                Value<double> expectedAbv = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion.insert(
                id: id,
                title: title,
                kind: kind,
                styleTags: styleTags,
                baseVolumeL: baseVolumeL,
                expectedYieldL: expectedYieldL,
                expectedAbv: expectedAbv,
                summary: summary,
                source: source,
                isBuiltIn: isBuiltIn,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipesTable, Recipe>(table),
                  $$RecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recipeIngredientsRefs = false,
                recipeStepsRefs = false,
                batchesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                    if (recipeStepsRefs) db.recipeSteps,
                    if (batchesRefs) db.batches,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientsRefs)
                        await $_getPrefetchedDataByColumns<
                          Recipe,
                          $RecipesTable,
                          RecipeIngredient,
                          $RecipeIngredientsTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                      if (recipeStepsRefs)
                        await $_getPrefetchedDataByColumns<
                          Recipe,
                          $RecipesTable,
                          RecipeStep,
                          $RecipeStepsTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeStepsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                      if (batchesRefs)
                        await $_getPrefetchedDataByColumns<
                          Recipe,
                          $RecipesTable,
                          Batch,
                          $BatchesTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._batchesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).batchesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, $$RecipesTableReferences),
      Recipe,
      PrefetchHooks Function({
        bool recipeIngredientsRefs,
        bool recipeStepsRefs,
        bool batchesRefs,
      })
    >;
typedef $$RecipeIngredientsTableCreateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      required String recipeId,
      Value<int> sortOrder,
      required String name,
      required double amount,
      required String unit,
      Value<String> note,
    });
typedef $$RecipeIngredientsTableUpdateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      Value<String> recipeId,
      Value<int> sortOrder,
      Value<String> name,
      Value<double> amount,
      Value<String> unit,
      Value<String> note,
    });

final class $$RecipeIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient
        > {
  $$RecipeIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_ingredients__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient,
          $$RecipeIngredientsTableFilterComposer,
          $$RecipeIngredientsTableOrderingComposer,
          $$RecipeIngredientsTableAnnotationComposer,
          $$RecipeIngredientsTableCreateCompanionBuilder,
          $$RecipeIngredientsTableUpdateCompanionBuilder,
          (RecipeIngredient, $$RecipeIngredientsTableReferences),
          RecipeIngredient,
          PrefetchHooks Function({bool recipeId})
        > {
  $$RecipeIngredientsTableTableManager(
    _$AppDatabase db,
    $RecipeIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => RecipeIngredientsCompanion(
                id: id,
                recipeId: recipeId,
                sortOrder: sortOrder,
                name: name,
                amount: amount,
                unit: unit,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recipeId,
                Value<int> sortOrder = const Value.absent(),
                required String name,
                required double amount,
                required String unit,
                Value<String> note = const Value.absent(),
              }) => RecipeIngredientsCompanion.insert(
                id: id,
                recipeId: recipeId,
                sortOrder: sortOrder,
                name: name,
                amount: amount,
                unit: unit,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeIngredientsTable, RecipeIngredient>(table),
                  $$RecipeIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeIngredientsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeIngredientsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeIngredientsTable,
      RecipeIngredient,
      $$RecipeIngredientsTableFilterComposer,
      $$RecipeIngredientsTableOrderingComposer,
      $$RecipeIngredientsTableAnnotationComposer,
      $$RecipeIngredientsTableCreateCompanionBuilder,
      $$RecipeIngredientsTableUpdateCompanionBuilder,
      (RecipeIngredient, $$RecipeIngredientsTableReferences),
      RecipeIngredient,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$RecipeStepsTableCreateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      required String recipeId,
      Value<int> sortOrder,
      required String title,
      Value<String> description,
      Value<int> offsetDays,
      Value<int?> durationMin,
      Value<double?> tempC,
      Value<String> eventKind,
      Value<int?> repeatEveryDays,
      Value<int?> repeatUntilDay,
    });
typedef $$RecipeStepsTableUpdateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      Value<String> recipeId,
      Value<int> sortOrder,
      Value<String> title,
      Value<String> description,
      Value<int> offsetDays,
      Value<int?> durationMin,
      Value<double?> tempC,
      Value<String> eventKind,
      Value<int?> repeatEveryDays,
      Value<int?> repeatUntilDay,
    });

final class $$RecipeStepsTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeStepsTable, RecipeStep> {
  $$RecipeStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_steps__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeStepsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get offsetDays => $composableBuilder(
    column: $table.offsetDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventKind => $composableBuilder(
    column: $table.eventKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatEveryDays => $composableBuilder(
    column: $table.repeatEveryDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatUntilDay => $composableBuilder(
    column: $table.repeatUntilDay,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get offsetDays => $composableBuilder(
    column: $table.offsetDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventKind => $composableBuilder(
    column: $table.eventKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatEveryDays => $composableBuilder(
    column: $table.repeatEveryDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatUntilDay => $composableBuilder(
    column: $table.repeatUntilDay,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get offsetDays => $composableBuilder(
    column: $table.offsetDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tempC =>
      $composableBuilder(column: $table.tempC, builder: (column) => column);

  GeneratedColumn<String> get eventKind =>
      $composableBuilder(column: $table.eventKind, builder: (column) => column);

  GeneratedColumn<int> get repeatEveryDays => $composableBuilder(
    column: $table.repeatEveryDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repeatUntilDay => $composableBuilder(
    column: $table.repeatUntilDay,
    builder: (column) => column,
  );

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeStepsTable,
          RecipeStep,
          $$RecipeStepsTableFilterComposer,
          $$RecipeStepsTableOrderingComposer,
          $$RecipeStepsTableAnnotationComposer,
          $$RecipeStepsTableCreateCompanionBuilder,
          $$RecipeStepsTableUpdateCompanionBuilder,
          (RecipeStep, $$RecipeStepsTableReferences),
          RecipeStep,
          PrefetchHooks Function({bool recipeId})
        > {
  $$RecipeStepsTableTableManager(_$AppDatabase db, $RecipeStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> offsetDays = const Value.absent(),
                Value<int?> durationMin = const Value.absent(),
                Value<double?> tempC = const Value.absent(),
                Value<String> eventKind = const Value.absent(),
                Value<int?> repeatEveryDays = const Value.absent(),
                Value<int?> repeatUntilDay = const Value.absent(),
              }) => RecipeStepsCompanion(
                id: id,
                recipeId: recipeId,
                sortOrder: sortOrder,
                title: title,
                description: description,
                offsetDays: offsetDays,
                durationMin: durationMin,
                tempC: tempC,
                eventKind: eventKind,
                repeatEveryDays: repeatEveryDays,
                repeatUntilDay: repeatUntilDay,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recipeId,
                Value<int> sortOrder = const Value.absent(),
                required String title,
                Value<String> description = const Value.absent(),
                Value<int> offsetDays = const Value.absent(),
                Value<int?> durationMin = const Value.absent(),
                Value<double?> tempC = const Value.absent(),
                Value<String> eventKind = const Value.absent(),
                Value<int?> repeatEveryDays = const Value.absent(),
                Value<int?> repeatUntilDay = const Value.absent(),
              }) => RecipeStepsCompanion.insert(
                id: id,
                recipeId: recipeId,
                sortOrder: sortOrder,
                title: title,
                description: description,
                offsetDays: offsetDays,
                durationMin: durationMin,
                tempC: tempC,
                eventKind: eventKind,
                repeatEveryDays: repeatEveryDays,
                repeatUntilDay: repeatUntilDay,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeStepsTable, RecipeStep>(table),
                  $$RecipeStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeStepsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeStepsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeStepsTable,
      RecipeStep,
      $$RecipeStepsTableFilterComposer,
      $$RecipeStepsTableOrderingComposer,
      $$RecipeStepsTableAnnotationComposer,
      $$RecipeStepsTableCreateCompanionBuilder,
      $$RecipeStepsTableUpdateCompanionBuilder,
      (RecipeStep, $$RecipeStepsTableReferences),
      RecipeStep,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$BatchesTableCreateCompanionBuilder = BatchesCompanion Function({
  required String id,
  required String recipeId,
  Value<String> code,
  required String title,
  required DateTime startedAt,
  Value<DateTime?> finishedAt,
  Value<double> volumeL,
  Value<double> abv,
  Value<String> status,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$BatchesTableUpdateCompanionBuilder = BatchesCompanion Function({
  Value<String> id,
  Value<String> recipeId,
  Value<String> code,
  Value<String> title,
  Value<DateTime> startedAt,
  Value<DateTime?> finishedAt,
  Value<double> volumeL,
  Value<double> abv,
  Value<String> status,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$BatchesTableReferences
    extends BaseReferences<_$AppDatabase, $BatchesTable, Batch> {
  $$BatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('batches__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BatchEventsTable, List<BatchEvent>>
  _batchEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.batchEvents,
    aliasName: 'batches__id__batch_events__batch_id',
  );

  $$BatchEventsTableProcessedTableManager get batchEventsRefs {
    final manager = $$BatchEventsTableTableManager(
      $_db,
      $_db.batchEvents,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeasurementsTable, List<Measurement>>
  _measurementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.measurements,
    aliasName: 'batches__id__measurements__batch_id',
  );

  $$MeasurementsTableProcessedTableManager get measurementsRefs {
    final manager = $$MeasurementsTableTableManager(
      $_db,
      $_db.measurements,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_measurementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BatchIngredientsTable, List<BatchIngredient>>
  _batchIngredientsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.batchIngredients,
    aliasName: 'batches__id__batch_ingredients__batch_id',
  );

  $$BatchIngredientsTableProcessedTableManager get batchIngredientsRefs {
    final manager = $$BatchIngredientsTableTableManager(
      $_db,
      $_db.batchIngredients,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _batchIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RunsTable, List<Run>> _runsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.runs,
    aliasName: 'batches__id__runs__batch_id',
  );

  $$RunsTableProcessedTableManager get runsRefs {
    final manager = $$RunsTableTableManager(
      $_db,
      $_db.runs,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_runsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AgingTable, List<AgingEntry>> _agingRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.aging,
    aliasName: 'batches__id__aging__batch_id',
  );

  $$AgingTableProcessedTableManager get agingRefs {
    final manager = $$AgingTableTableManager(
      $_db,
      $_db.aging,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_agingRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MacerationsTable, List<Maceration>>
  _macerationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.macerations,
    aliasName: 'batches__id__macerations__batch_id',
  );

  $$MacerationsTableProcessedTableManager get macerationsRefs {
    final manager = $$MacerationsTableTableManager(
      $_db,
      $_db.macerations,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_macerationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TastingsTable, List<Tasting>> _tastingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tastings,
    aliasName: 'batches__id__tastings__batch_id',
  );

  $$TastingsTableProcessedTableManager get tastingsRefs {
    final manager = $$TastingsTableTableManager(
      $_db,
      $_db.tastings,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tastingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BatchesTableFilterComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeL => $composableBuilder(
    column: $table.volumeL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get abv => $composableBuilder(
    column: $table.abv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> batchEventsRefs(
    Expression<bool> Function($$BatchEventsTableFilterComposer f) f,
  ) {
    final $$BatchEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchEvents,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchEventsTableFilterComposer(
            $db: $db,
            $table: $db.batchEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> measurementsRefs(
    Expression<bool> Function($$MeasurementsTableFilterComposer f) f,
  ) {
    final $$MeasurementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.measurements,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementsTableFilterComposer(
            $db: $db,
            $table: $db.measurements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> batchIngredientsRefs(
    Expression<bool> Function($$BatchIngredientsTableFilterComposer f) f,
  ) {
    final $$BatchIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchIngredients,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.batchIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> runsRefs(
    Expression<bool> Function($$RunsTableFilterComposer f) f,
  ) {
    final $$RunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.runs,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RunsTableFilterComposer(
            $db: $db,
            $table: $db.runs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> agingRefs(
    Expression<bool> Function($$AgingTableFilterComposer f) f,
  ) {
    final $$AgingTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aging,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingTableFilterComposer(
            $db: $db,
            $table: $db.aging,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> macerationsRefs(
    Expression<bool> Function($$MacerationsTableFilterComposer f) f,
  ) {
    final $$MacerationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.macerations,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MacerationsTableFilterComposer(
            $db: $db,
            $table: $db.macerations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tastingsRefs(
    Expression<bool> Function($$TastingsTableFilterComposer f) f,
  ) {
    final $$TastingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tastings,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TastingsTableFilterComposer(
            $db: $db,
            $table: $db.tastings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeL => $composableBuilder(
    column: $table.volumeL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get abv => $composableBuilder(
    column: $table.abv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get volumeL =>
      $composableBuilder(column: $table.volumeL, builder: (column) => column);

  GeneratedColumn<double> get abv =>
      $composableBuilder(column: $table.abv, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> batchEventsRefs<T extends Object>(
    Expression<T> Function($$BatchEventsTableAnnotationComposer a) f,
  ) {
    final $$BatchEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchEvents,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.batchEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> measurementsRefs<T extends Object>(
    Expression<T> Function($$MeasurementsTableAnnotationComposer a) f,
  ) {
    final $$MeasurementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.measurements,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementsTableAnnotationComposer(
            $db: $db,
            $table: $db.measurements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> batchIngredientsRefs<T extends Object>(
    Expression<T> Function($$BatchIngredientsTableAnnotationComposer a) f,
  ) {
    final $$BatchIngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchIngredients,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchIngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.batchIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> runsRefs<T extends Object>(
    Expression<T> Function($$RunsTableAnnotationComposer a) f,
  ) {
    final $$RunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.runs,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RunsTableAnnotationComposer(
            $db: $db,
            $table: $db.runs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> agingRefs<T extends Object>(
    Expression<T> Function($$AgingTableAnnotationComposer a) f,
  ) {
    final $$AgingTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aging,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingTableAnnotationComposer(
            $db: $db,
            $table: $db.aging,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> macerationsRefs<T extends Object>(
    Expression<T> Function($$MacerationsTableAnnotationComposer a) f,
  ) {
    final $$MacerationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.macerations,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MacerationsTableAnnotationComposer(
            $db: $db,
            $table: $db.macerations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tastingsRefs<T extends Object>(
    Expression<T> Function($$TastingsTableAnnotationComposer a) f,
  ) {
    final $$TastingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tastings,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TastingsTableAnnotationComposer(
            $db: $db,
            $table: $db.tastings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchesTable,
          Batch,
          $$BatchesTableFilterComposer,
          $$BatchesTableOrderingComposer,
          $$BatchesTableAnnotationComposer,
          $$BatchesTableCreateCompanionBuilder,
          $$BatchesTableUpdateCompanionBuilder,
          (Batch, $$BatchesTableReferences),
          Batch,
          PrefetchHooks Function({
            bool recipeId,
            bool batchEventsRefs,
            bool measurementsRefs,
            bool batchIngredientsRefs,
            bool runsRefs,
            bool agingRefs,
            bool macerationsRefs,
            bool tastingsRefs,
          })
        > {
  $$BatchesTableTableManager(_$AppDatabase db, $BatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<double> volumeL = const Value.absent(),
                Value<double> abv = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatchesCompanion(
                id: id,
                recipeId: recipeId,
                code: code,
                title: title,
                startedAt: startedAt,
                finishedAt: finishedAt,
                volumeL: volumeL,
                abv: abv,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recipeId,
                Value<String> code = const Value.absent(),
                required String title,
                required DateTime startedAt,
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<double> volumeL = const Value.absent(),
                Value<double> abv = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatchesCompanion.insert(
                id: id,
                recipeId: recipeId,
                code: code,
                title: title,
                startedAt: startedAt,
                finishedAt: finishedAt,
                volumeL: volumeL,
                abv: abv,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatchesTable, Batch>(table),
                  $$BatchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recipeId = false,
                batchEventsRefs = false,
                measurementsRefs = false,
                batchIngredientsRefs = false,
                runsRefs = false,
                agingRefs = false,
                macerationsRefs = false,
                tastingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (batchEventsRefs) db.batchEvents,
                    if (measurementsRefs) db.measurements,
                    if (batchIngredientsRefs) db.batchIngredients,
                    if (runsRefs) db.runs,
                    if (agingRefs) db.aging,
                    if (macerationsRefs) db.macerations,
                    if (tastingsRefs) db.tastings,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (recipeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.recipeId,
                            referencedTable: $$BatchesTableReferences
                                ._recipeIdTable(db),
                            referencedColumn: $$BatchesTableReferences
                                ._recipeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (batchEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          Batch,
                          $BatchesTable,
                          BatchEvent,
                          $BatchEventsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._batchEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(
                                db,
                                table,
                                p0,
                              ).batchEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (measurementsRefs)
                        await $_getPrefetchedDataByColumns<
                          Batch,
                          $BatchesTable,
                          Measurement,
                          $MeasurementsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._measurementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(
                                db,
                                table,
                                p0,
                              ).measurementsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (batchIngredientsRefs)
                        await $_getPrefetchedDataByColumns<
                          Batch,
                          $BatchesTable,
                          BatchIngredient,
                          $BatchIngredientsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._batchIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(
                                db,
                                table,
                                p0,
                              ).batchIngredientsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (runsRefs)
                        await $_getPrefetchedDataByColumns<
                          Batch,
                          $BatchesTable,
                          Run,
                          $RunsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._runsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(db, table, p0).runsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (agingRefs)
                        await $_getPrefetchedDataByColumns<
                          Batch,
                          $BatchesTable,
                          AgingEntry,
                          $AgingTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._agingRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(db, table, p0).agingRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (macerationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Batch,
                          $BatchesTable,
                          Maceration,
                          $MacerationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._macerationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(
                                db,
                                table,
                                p0,
                              ).macerationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (tastingsRefs)
                        await $_getPrefetchedDataByColumns<
                          Batch,
                          $BatchesTable,
                          Tasting,
                          $TastingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences
                              ._tastingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(
                                db,
                                table,
                                p0,
                              ).tastingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchesTable,
      Batch,
      $$BatchesTableFilterComposer,
      $$BatchesTableOrderingComposer,
      $$BatchesTableAnnotationComposer,
      $$BatchesTableCreateCompanionBuilder,
      $$BatchesTableUpdateCompanionBuilder,
      (Batch, $$BatchesTableReferences),
      Batch,
      PrefetchHooks Function({
        bool recipeId,
        bool batchEventsRefs,
        bool measurementsRefs,
        bool batchIngredientsRefs,
        bool runsRefs,
        bool agingRefs,
        bool macerationsRefs,
        bool tastingsRefs,
      })
    >;
typedef $$BatchEventsTableCreateCompanionBuilder =
    BatchEventsCompanion Function({
      required String id,
      required String batchId,
      required String kind,
      required String title,
      Value<String> description,
      required DateTime plannedAt,
      Value<DateTime?> actualAt,
      Value<String> status,
      Value<int> remindBeforeMin,
      Value<int?> notificationId,
      Value<int> rowid,
    });
typedef $$BatchEventsTableUpdateCompanionBuilder =
    BatchEventsCompanion Function({
      Value<String> id,
      Value<String> batchId,
      Value<String> kind,
      Value<String> title,
      Value<String> description,
      Value<DateTime> plannedAt,
      Value<DateTime?> actualAt,
      Value<String> status,
      Value<int> remindBeforeMin,
      Value<int?> notificationId,
      Value<int> rowid,
    });

final class $$BatchEventsTableReferences
    extends BaseReferences<_$AppDatabase, $BatchEventsTable, BatchEvent> {
  $$BatchEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('batch_events__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BatchEventsTableFilterComposer
    extends Composer<_$AppDatabase, $BatchEventsTable> {
  $$BatchEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plannedAt => $composableBuilder(
    column: $table.plannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualAt => $composableBuilder(
    column: $table.actualAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remindBeforeMin => $composableBuilder(
    column: $table.remindBeforeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchEventsTable> {
  $$BatchEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plannedAt => $composableBuilder(
    column: $table.plannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualAt => $composableBuilder(
    column: $table.actualAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remindBeforeMin => $composableBuilder(
    column: $table.remindBeforeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchEventsTable> {
  $$BatchEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get plannedAt =>
      $composableBuilder(column: $table.plannedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get actualAt =>
      $composableBuilder(column: $table.actualAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get remindBeforeMin => $composableBuilder(
    column: $table.remindBeforeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchEventsTable,
          BatchEvent,
          $$BatchEventsTableFilterComposer,
          $$BatchEventsTableOrderingComposer,
          $$BatchEventsTableAnnotationComposer,
          $$BatchEventsTableCreateCompanionBuilder,
          $$BatchEventsTableUpdateCompanionBuilder,
          (BatchEvent, $$BatchEventsTableReferences),
          BatchEvent,
          PrefetchHooks Function({bool batchId})
        > {
  $$BatchEventsTableTableManager(_$AppDatabase db, $BatchEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> plannedAt = const Value.absent(),
                Value<DateTime?> actualAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> remindBeforeMin = const Value.absent(),
                Value<int?> notificationId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatchEventsCompanion(
                id: id,
                batchId: batchId,
                kind: kind,
                title: title,
                description: description,
                plannedAt: plannedAt,
                actualAt: actualAt,
                status: status,
                remindBeforeMin: remindBeforeMin,
                notificationId: notificationId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                required String kind,
                required String title,
                Value<String> description = const Value.absent(),
                required DateTime plannedAt,
                Value<DateTime?> actualAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> remindBeforeMin = const Value.absent(),
                Value<int?> notificationId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatchEventsCompanion.insert(
                id: id,
                batchId: batchId,
                kind: kind,
                title: title,
                description: description,
                plannedAt: plannedAt,
                actualAt: actualAt,
                status: status,
                remindBeforeMin: remindBeforeMin,
                notificationId: notificationId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatchEventsTable, BatchEvent>(table),
                  $$BatchEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$BatchEventsTableReferences
                            ._batchIdTable(db),
                        referencedColumn: $$BatchEventsTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BatchEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchEventsTable,
      BatchEvent,
      $$BatchEventsTableFilterComposer,
      $$BatchEventsTableOrderingComposer,
      $$BatchEventsTableAnnotationComposer,
      $$BatchEventsTableCreateCompanionBuilder,
      $$BatchEventsTableUpdateCompanionBuilder,
      (BatchEvent, $$BatchEventsTableReferences),
      BatchEvent,
      PrefetchHooks Function({bool batchId})
    >;
typedef $$MeasurementsTableCreateCompanionBuilder =
    MeasurementsCompanion Function({
      required String id,
      required String batchId,
      required DateTime at,
      required String kind,
      required double value,
      Value<String> note,
      Value<int> rowid,
    });
typedef $$MeasurementsTableUpdateCompanionBuilder =
    MeasurementsCompanion Function({
      Value<String> id,
      Value<String> batchId,
      Value<DateTime> at,
      Value<String> kind,
      Value<double> value,
      Value<String> note,
      Value<int> rowid,
    });

final class $$MeasurementsTableReferences
    extends BaseReferences<_$AppDatabase, $MeasurementsTable, Measurement> {
  $$MeasurementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('measurements__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeasurementsTable,
          Measurement,
          $$MeasurementsTableFilterComposer,
          $$MeasurementsTableOrderingComposer,
          $$MeasurementsTableAnnotationComposer,
          $$MeasurementsTableCreateCompanionBuilder,
          $$MeasurementsTableUpdateCompanionBuilder,
          (Measurement, $$MeasurementsTableReferences),
          Measurement,
          PrefetchHooks Function({bool batchId})
        > {
  $$MeasurementsTableTableManager(_$AppDatabase db, $MeasurementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeasurementsCompanion(
                id: id,
                batchId: batchId,
                at: at,
                kind: kind,
                value: value,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                required DateTime at,
                required String kind,
                required double value,
                Value<String> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeasurementsCompanion.insert(
                id: id,
                batchId: batchId,
                at: at,
                kind: kind,
                value: value,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MeasurementsTable, Measurement>(table),
                  $$MeasurementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$MeasurementsTableReferences
                            ._batchIdTable(db),
                        referencedColumn: $$MeasurementsTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeasurementsTable,
      Measurement,
      $$MeasurementsTableFilterComposer,
      $$MeasurementsTableOrderingComposer,
      $$MeasurementsTableAnnotationComposer,
      $$MeasurementsTableCreateCompanionBuilder,
      $$MeasurementsTableUpdateCompanionBuilder,
      (Measurement, $$MeasurementsTableReferences),
      Measurement,
      PrefetchHooks Function({bool batchId})
    >;
typedef $$AppMetaTableCreateCompanionBuilder = AppMetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppMetaTableUpdateCompanionBuilder = AppMetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaData,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaData,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>,
          ),
          AppMetaData,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => AppMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppMetaTable, AppMetaData>(table),
                  BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaData,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaData, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaData>),
      AppMetaData,
      PrefetchHooks Function()
    >;
typedef $$BatchIngredientsTableCreateCompanionBuilder =
    BatchIngredientsCompanion Function({
      Value<int> id,
      required String batchId,
      Value<int> sortOrder,
      required String name,
      required double amount,
      required String unit,
      Value<String> note,
    });
typedef $$BatchIngredientsTableUpdateCompanionBuilder =
    BatchIngredientsCompanion Function({
      Value<int> id,
      Value<String> batchId,
      Value<int> sortOrder,
      Value<String> name,
      Value<double> amount,
      Value<String> unit,
      Value<String> note,
    });

final class $$BatchIngredientsTableReferences
    extends
        BaseReferences<_$AppDatabase, $BatchIngredientsTable, BatchIngredient> {
  $$BatchIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('batch_ingredients__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BatchIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $BatchIngredientsTable> {
  $$BatchIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchIngredientsTable> {
  $$BatchIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchIngredientsTable> {
  $$BatchIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchIngredientsTable,
          BatchIngredient,
          $$BatchIngredientsTableFilterComposer,
          $$BatchIngredientsTableOrderingComposer,
          $$BatchIngredientsTableAnnotationComposer,
          $$BatchIngredientsTableCreateCompanionBuilder,
          $$BatchIngredientsTableUpdateCompanionBuilder,
          (BatchIngredient, $$BatchIngredientsTableReferences),
          BatchIngredient,
          PrefetchHooks Function({bool batchId})
        > {
  $$BatchIngredientsTableTableManager(
    _$AppDatabase db,
    $BatchIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchIngredientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => BatchIngredientsCompanion(
                id: id,
                batchId: batchId,
                sortOrder: sortOrder,
                name: name,
                amount: amount,
                unit: unit,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String batchId,
                Value<int> sortOrder = const Value.absent(),
                required String name,
                required double amount,
                required String unit,
                Value<String> note = const Value.absent(),
              }) => BatchIngredientsCompanion.insert(
                id: id,
                batchId: batchId,
                sortOrder: sortOrder,
                name: name,
                amount: amount,
                unit: unit,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatchIngredientsTable, BatchIngredient>(table),
                  $$BatchIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$BatchIngredientsTableReferences
                            ._batchIdTable(db),
                        referencedColumn: $$BatchIngredientsTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BatchIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchIngredientsTable,
      BatchIngredient,
      $$BatchIngredientsTableFilterComposer,
      $$BatchIngredientsTableOrderingComposer,
      $$BatchIngredientsTableAnnotationComposer,
      $$BatchIngredientsTableCreateCompanionBuilder,
      $$BatchIngredientsTableUpdateCompanionBuilder,
      (BatchIngredient, $$BatchIngredientsTableReferences),
      BatchIngredient,
      PrefetchHooks Function({bool batchId})
    >;
typedef $$RunsTableCreateCompanionBuilder = RunsCompanion Function({
  required String id,
  required String batchId,
  required String kind,
  required DateTime startedAt,
  Value<DateTime?> endedAt,
  Value<double> chargeVolumeL,
  Value<double> chargeAbv,
  Value<double?> cubeTempStartC,
  Value<double?> cubeTempEndC,
  Value<String> notes,
  Value<int> rowid,
});
typedef $$RunsTableUpdateCompanionBuilder = RunsCompanion Function({
  Value<String> id,
  Value<String> batchId,
  Value<String> kind,
  Value<DateTime> startedAt,
  Value<DateTime?> endedAt,
  Value<double> chargeVolumeL,
  Value<double> chargeAbv,
  Value<double?> cubeTempStartC,
  Value<double?> cubeTempEndC,
  Value<String> notes,
  Value<int> rowid,
});

final class $$RunsTableReferences
    extends BaseReferences<_$AppDatabase, $RunsTable, Run> {
  $$RunsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('runs__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RunFractionsTable, List<RunFraction>>
  _runFractionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.runFractions,
    aliasName: 'runs__id__run_fractions__run_id',
  );

  $$RunFractionsTableProcessedTableManager get runFractionsRefs {
    final manager = $$RunFractionsTableTableManager(
      $_db,
      $_db.runFractions,
    ).filter((f) => f.runId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_runFractionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RunsTableFilterComposer extends Composer<_$AppDatabase, $RunsTable> {
  $$RunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chargeVolumeL => $composableBuilder(
    column: $table.chargeVolumeL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chargeAbv => $composableBuilder(
    column: $table.chargeAbv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cubeTempStartC => $composableBuilder(
    column: $table.cubeTempStartC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cubeTempEndC => $composableBuilder(
    column: $table.cubeTempEndC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> runFractionsRefs(
    Expression<bool> Function($$RunFractionsTableFilterComposer f) f,
  ) {
    final $$RunFractionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.runFractions,
      getReferencedColumn: (t) => t.runId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RunFractionsTableFilterComposer(
            $db: $db,
            $table: $db.runFractions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RunsTableOrderingComposer extends Composer<_$AppDatabase, $RunsTable> {
  $$RunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chargeVolumeL => $composableBuilder(
    column: $table.chargeVolumeL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chargeAbv => $composableBuilder(
    column: $table.chargeAbv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cubeTempStartC => $composableBuilder(
    column: $table.cubeTempStartC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cubeTempEndC => $composableBuilder(
    column: $table.cubeTempEndC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RunsTable> {
  $$RunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<double> get chargeVolumeL => $composableBuilder(
    column: $table.chargeVolumeL,
    builder: (column) => column,
  );

  GeneratedColumn<double> get chargeAbv =>
      $composableBuilder(column: $table.chargeAbv, builder: (column) => column);

  GeneratedColumn<double> get cubeTempStartC => $composableBuilder(
    column: $table.cubeTempStartC,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cubeTempEndC => $composableBuilder(
    column: $table.cubeTempEndC,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> runFractionsRefs<T extends Object>(
    Expression<T> Function($$RunFractionsTableAnnotationComposer a) f,
  ) {
    final $$RunFractionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.runFractions,
      getReferencedColumn: (t) => t.runId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RunFractionsTableAnnotationComposer(
            $db: $db,
            $table: $db.runFractions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RunsTable,
          Run,
          $$RunsTableFilterComposer,
          $$RunsTableOrderingComposer,
          $$RunsTableAnnotationComposer,
          $$RunsTableCreateCompanionBuilder,
          $$RunsTableUpdateCompanionBuilder,
          (Run, $$RunsTableReferences),
          Run,
          PrefetchHooks Function({bool batchId, bool runFractionsRefs})
        > {
  $$RunsTableTableManager(_$AppDatabase db, $RunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<double> chargeVolumeL = const Value.absent(),
                Value<double> chargeAbv = const Value.absent(),
                Value<double?> cubeTempStartC = const Value.absent(),
                Value<double?> cubeTempEndC = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RunsCompanion(
                id: id,
                batchId: batchId,
                kind: kind,
                startedAt: startedAt,
                endedAt: endedAt,
                chargeVolumeL: chargeVolumeL,
                chargeAbv: chargeAbv,
                cubeTempStartC: cubeTempStartC,
                cubeTempEndC: cubeTempEndC,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                required String kind,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<double> chargeVolumeL = const Value.absent(),
                Value<double> chargeAbv = const Value.absent(),
                Value<double?> cubeTempStartC = const Value.absent(),
                Value<double?> cubeTempEndC = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RunsCompanion.insert(
                id: id,
                batchId: batchId,
                kind: kind,
                startedAt: startedAt,
                endedAt: endedAt,
                chargeVolumeL: chargeVolumeL,
                chargeAbv: chargeAbv,
                cubeTempStartC: cubeTempStartC,
                cubeTempEndC: cubeTempEndC,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RunsTable, Run>(table),
                  $$RunsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false, runFractionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (runFractionsRefs) db.runFractions],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$RunsTableReferences._batchIdTable(
                          db,
                        ),
                        referencedColumn: $$RunsTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (runFractionsRefs)
                    await $_getPrefetchedDataByColumns<
                      Run,
                      $RunsTable,
                      RunFraction,
                      $RunFractionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$RunsTableReferences
                          ._runFractionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RunsTableReferences(db, table, p0).runFractionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'run_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RunsTable,
      Run,
      $$RunsTableFilterComposer,
      $$RunsTableOrderingComposer,
      $$RunsTableAnnotationComposer,
      $$RunsTableCreateCompanionBuilder,
      $$RunsTableUpdateCompanionBuilder,
      (Run, $$RunsTableReferences),
      Run,
      PrefetchHooks Function({bool batchId, bool runFractionsRefs})
    >;
typedef $$RunFractionsTableCreateCompanionBuilder =
    RunFractionsCompanion Function({
      Value<int> id,
      required String runId,
      Value<int> jarNo,
      required String kind,
      required double volumeMl,
      required double abv,
      Value<double?> tempC,
      Value<String> note,
    });
typedef $$RunFractionsTableUpdateCompanionBuilder =
    RunFractionsCompanion Function({
      Value<int> id,
      Value<String> runId,
      Value<int> jarNo,
      Value<String> kind,
      Value<double> volumeMl,
      Value<double> abv,
      Value<double?> tempC,
      Value<String> note,
    });

final class $$RunFractionsTableReferences
    extends BaseReferences<_$AppDatabase, $RunFractionsTable, RunFraction> {
  $$RunFractionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RunsTable _runIdTable(_$AppDatabase db) =>
      db.runs.createAlias('run_fractions__run_id__runs__id');

  $$RunsTableProcessedTableManager get runId {
    final $_column = $_itemColumn<String>('run_id')!;

    final manager = $$RunsTableTableManager(
      $_db,
      $_db.runs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_runIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RunFractionsTableFilterComposer
    extends Composer<_$AppDatabase, $RunFractionsTable> {
  $$RunFractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jarNo => $composableBuilder(
    column: $table.jarNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get abv => $composableBuilder(
    column: $table.abv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$RunsTableFilterComposer get runId {
    final $$RunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.runs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RunsTableFilterComposer(
            $db: $db,
            $table: $db.runs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RunFractionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RunFractionsTable> {
  $$RunFractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jarNo => $composableBuilder(
    column: $table.jarNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get abv => $composableBuilder(
    column: $table.abv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$RunsTableOrderingComposer get runId {
    final $$RunsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.runs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RunsTableOrderingComposer(
            $db: $db,
            $table: $db.runs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RunFractionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RunFractionsTable> {
  $$RunFractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get jarNo =>
      $composableBuilder(column: $table.jarNo, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get volumeMl =>
      $composableBuilder(column: $table.volumeMl, builder: (column) => column);

  GeneratedColumn<double> get abv =>
      $composableBuilder(column: $table.abv, builder: (column) => column);

  GeneratedColumn<double> get tempC =>
      $composableBuilder(column: $table.tempC, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$RunsTableAnnotationComposer get runId {
    final $$RunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.runs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RunsTableAnnotationComposer(
            $db: $db,
            $table: $db.runs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RunFractionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RunFractionsTable,
          RunFraction,
          $$RunFractionsTableFilterComposer,
          $$RunFractionsTableOrderingComposer,
          $$RunFractionsTableAnnotationComposer,
          $$RunFractionsTableCreateCompanionBuilder,
          $$RunFractionsTableUpdateCompanionBuilder,
          (RunFraction, $$RunFractionsTableReferences),
          RunFraction,
          PrefetchHooks Function({bool runId})
        > {
  $$RunFractionsTableTableManager(_$AppDatabase db, $RunFractionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RunFractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RunFractionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RunFractionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> runId = const Value.absent(),
                Value<int> jarNo = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> volumeMl = const Value.absent(),
                Value<double> abv = const Value.absent(),
                Value<double?> tempC = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => RunFractionsCompanion(
                id: id,
                runId: runId,
                jarNo: jarNo,
                kind: kind,
                volumeMl: volumeMl,
                abv: abv,
                tempC: tempC,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String runId,
                Value<int> jarNo = const Value.absent(),
                required String kind,
                required double volumeMl,
                required double abv,
                Value<double?> tempC = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => RunFractionsCompanion.insert(
                id: id,
                runId: runId,
                jarNo: jarNo,
                kind: kind,
                volumeMl: volumeMl,
                abv: abv,
                tempC: tempC,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RunFractionsTable, RunFraction>(table),
                  $$RunFractionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({runId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (runId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.runId,
                        referencedTable: $$RunFractionsTableReferences
                            ._runIdTable(db),
                        referencedColumn: $$RunFractionsTableReferences
                            ._runIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RunFractionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RunFractionsTable,
      RunFraction,
      $$RunFractionsTableFilterComposer,
      $$RunFractionsTableOrderingComposer,
      $$RunFractionsTableAnnotationComposer,
      $$RunFractionsTableCreateCompanionBuilder,
      $$RunFractionsTableUpdateCompanionBuilder,
      (RunFraction, $$RunFractionsTableReferences),
      RunFraction,
      PrefetchHooks Function({bool runId})
    >;
typedef $$VesselsTableCreateCompanionBuilder = VesselsCompanion Function({
  required String id,
  required String name,
  required String kind,
  required double volumeL,
  Value<String> material,
  Value<int?> charLevel,
  Value<String> location,
  Value<bool> isOccupied,
  Value<int> rowid,
});
typedef $$VesselsTableUpdateCompanionBuilder = VesselsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> kind,
  Value<double> volumeL,
  Value<String> material,
  Value<int?> charLevel,
  Value<String> location,
  Value<bool> isOccupied,
  Value<int> rowid,
});

final class $$VesselsTableReferences
    extends BaseReferences<_$AppDatabase, $VesselsTable, Vessel> {
  $$VesselsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AgingTable, List<AgingEntry>> _agingRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.aging,
    aliasName: 'vessels__id__aging__vessel_id',
  );

  $$AgingTableProcessedTableManager get agingRefs {
    final manager = $$AgingTableTableManager(
      $_db,
      $_db.aging,
    ).filter((f) => f.vesselId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_agingRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VesselsTableFilterComposer
    extends Composer<_$AppDatabase, $VesselsTable> {
  $$VesselsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeL => $composableBuilder(
    column: $table.volumeL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get charLevel => $composableBuilder(
    column: $table.charLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOccupied => $composableBuilder(
    column: $table.isOccupied,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> agingRefs(
    Expression<bool> Function($$AgingTableFilterComposer f) f,
  ) {
    final $$AgingTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aging,
      getReferencedColumn: (t) => t.vesselId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingTableFilterComposer(
            $db: $db,
            $table: $db.aging,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VesselsTableOrderingComposer
    extends Composer<_$AppDatabase, $VesselsTable> {
  $$VesselsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeL => $composableBuilder(
    column: $table.volumeL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get charLevel => $composableBuilder(
    column: $table.charLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOccupied => $composableBuilder(
    column: $table.isOccupied,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VesselsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VesselsTable> {
  $$VesselsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get volumeL =>
      $composableBuilder(column: $table.volumeL, builder: (column) => column);

  GeneratedColumn<String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumn<int> get charLevel =>
      $composableBuilder(column: $table.charLevel, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<bool> get isOccupied => $composableBuilder(
    column: $table.isOccupied,
    builder: (column) => column,
  );

  Expression<T> agingRefs<T extends Object>(
    Expression<T> Function($$AgingTableAnnotationComposer a) f,
  ) {
    final $$AgingTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aging,
      getReferencedColumn: (t) => t.vesselId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingTableAnnotationComposer(
            $db: $db,
            $table: $db.aging,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VesselsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VesselsTable,
          Vessel,
          $$VesselsTableFilterComposer,
          $$VesselsTableOrderingComposer,
          $$VesselsTableAnnotationComposer,
          $$VesselsTableCreateCompanionBuilder,
          $$VesselsTableUpdateCompanionBuilder,
          (Vessel, $$VesselsTableReferences),
          Vessel,
          PrefetchHooks Function({bool agingRefs})
        > {
  $$VesselsTableTableManager(_$AppDatabase db, $VesselsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VesselsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VesselsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VesselsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> volumeL = const Value.absent(),
                Value<String> material = const Value.absent(),
                Value<int?> charLevel = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<bool> isOccupied = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VesselsCompanion(
                id: id,
                name: name,
                kind: kind,
                volumeL: volumeL,
                material: material,
                charLevel: charLevel,
                location: location,
                isOccupied: isOccupied,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String kind,
                required double volumeL,
                Value<String> material = const Value.absent(),
                Value<int?> charLevel = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<bool> isOccupied = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VesselsCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                volumeL: volumeL,
                material: material,
                charLevel: charLevel,
                location: location,
                isOccupied: isOccupied,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VesselsTable, Vessel>(table),
                  $$VesselsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({agingRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (agingRefs) db.aging],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (agingRefs)
                    await $_getPrefetchedDataByColumns<
                      Vessel,
                      $VesselsTable,
                      AgingEntry,
                      $AgingTable
                    >(
                      currentTable: table,
                      referencedTable: $$VesselsTableReferences._agingRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$VesselsTableReferences(db, table, p0).agingRefs,
                      currentColumn: 'id',
                      referencedColumn: 'vessel_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VesselsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VesselsTable,
      Vessel,
      $$VesselsTableFilterComposer,
      $$VesselsTableOrderingComposer,
      $$VesselsTableAnnotationComposer,
      $$VesselsTableCreateCompanionBuilder,
      $$VesselsTableUpdateCompanionBuilder,
      (Vessel, $$VesselsTableReferences),
      Vessel,
      PrefetchHooks Function({bool agingRefs})
    >;
typedef $$AgingTableCreateCompanionBuilder = AgingCompanion Function({
  required String id,
  required String batchId,
  Value<String?> vesselId,
  required DateTime startedAt,
  Value<DateTime?> plannedEndAt,
  Value<double> angelSharePctYear,
  Value<DateTime?> lastToppedAt,
  Value<String> notes,
  Value<int> rowid,
});
typedef $$AgingTableUpdateCompanionBuilder = AgingCompanion Function({
  Value<String> id,
  Value<String> batchId,
  Value<String?> vesselId,
  Value<DateTime> startedAt,
  Value<DateTime?> plannedEndAt,
  Value<double> angelSharePctYear,
  Value<DateTime?> lastToppedAt,
  Value<String> notes,
  Value<int> rowid,
});

final class $$AgingTableReferences
    extends BaseReferences<_$AppDatabase, $AgingTable, AgingEntry> {
  $$AgingTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('aging__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VesselsTable _vesselIdTable(_$AppDatabase db) =>
      db.vessels.createAlias('aging__vessel_id__vessels__id');

  $$VesselsTableProcessedTableManager? get vesselId {
    final $_column = $_itemColumn<String>('vessel_id');
    if ($_column == null) return null;
    final manager = $$VesselsTableTableManager(
      $_db,
      $_db.vessels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vesselIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AgingTableFilterComposer extends Composer<_$AppDatabase, $AgingTable> {
  $$AgingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plannedEndAt => $composableBuilder(
    column: $table.plannedEndAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get angelSharePctYear => $composableBuilder(
    column: $table.angelSharePctYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastToppedAt => $composableBuilder(
    column: $table.lastToppedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VesselsTableFilterComposer get vesselId {
    final $$VesselsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vesselId,
      referencedTable: $db.vessels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VesselsTableFilterComposer(
            $db: $db,
            $table: $db.vessels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgingTableOrderingComposer
    extends Composer<_$AppDatabase, $AgingTable> {
  $$AgingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plannedEndAt => $composableBuilder(
    column: $table.plannedEndAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get angelSharePctYear => $composableBuilder(
    column: $table.angelSharePctYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastToppedAt => $composableBuilder(
    column: $table.lastToppedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VesselsTableOrderingComposer get vesselId {
    final $$VesselsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vesselId,
      referencedTable: $db.vessels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VesselsTableOrderingComposer(
            $db: $db,
            $table: $db.vessels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgingTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgingTable> {
  $$AgingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedEndAt => $composableBuilder(
    column: $table.plannedEndAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get angelSharePctYear => $composableBuilder(
    column: $table.angelSharePctYear,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastToppedAt => $composableBuilder(
    column: $table.lastToppedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VesselsTableAnnotationComposer get vesselId {
    final $$VesselsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vesselId,
      referencedTable: $db.vessels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VesselsTableAnnotationComposer(
            $db: $db,
            $table: $db.vessels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgingTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AgingTable,
          AgingEntry,
          $$AgingTableFilterComposer,
          $$AgingTableOrderingComposer,
          $$AgingTableAnnotationComposer,
          $$AgingTableCreateCompanionBuilder,
          $$AgingTableUpdateCompanionBuilder,
          (AgingEntry, $$AgingTableReferences),
          AgingEntry,
          PrefetchHooks Function({bool batchId, bool vesselId})
        > {
  $$AgingTableTableManager(_$AppDatabase db, $AgingTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgingTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<String?> vesselId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> plannedEndAt = const Value.absent(),
                Value<double> angelSharePctYear = const Value.absent(),
                Value<DateTime?> lastToppedAt = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgingCompanion(
                id: id,
                batchId: batchId,
                vesselId: vesselId,
                startedAt: startedAt,
                plannedEndAt: plannedEndAt,
                angelSharePctYear: angelSharePctYear,
                lastToppedAt: lastToppedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                Value<String?> vesselId = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> plannedEndAt = const Value.absent(),
                Value<double> angelSharePctYear = const Value.absent(),
                Value<DateTime?> lastToppedAt = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgingCompanion.insert(
                id: id,
                batchId: batchId,
                vesselId: vesselId,
                startedAt: startedAt,
                plannedEndAt: plannedEndAt,
                angelSharePctYear: angelSharePctYear,
                lastToppedAt: lastToppedAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AgingTable, AgingEntry>(table),
                  $$AgingTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false, vesselId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$AgingTableReferences._batchIdTable(
                          db,
                        ),
                        referencedColumn: $$AgingTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (vesselId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vesselId,
                        referencedTable: $$AgingTableReferences._vesselIdTable(
                          db,
                        ),
                        referencedColumn: $$AgingTableReferences
                            ._vesselIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AgingTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AgingTable,
      AgingEntry,
      $$AgingTableFilterComposer,
      $$AgingTableOrderingComposer,
      $$AgingTableAnnotationComposer,
      $$AgingTableCreateCompanionBuilder,
      $$AgingTableUpdateCompanionBuilder,
      (AgingEntry, $$AgingTableReferences),
      AgingEntry,
      PrefetchHooks Function({bool batchId, bool vesselId})
    >;
typedef $$MacerationsTableCreateCompanionBuilder =
    MacerationsCompanion Function({
      required String id,
      required String batchId,
      required DateTime startedAt,
      Value<DateTime?> plannedEndAt,
      Value<int> shakeEveryDays,
      Value<DateTime?> lastShakenAt,
      Value<int> shakenCount,
      Value<double> strengthAbv,
      Value<DateTime?> finishedAt,
      Value<String> notes,
      Value<int> rowid,
    });
typedef $$MacerationsTableUpdateCompanionBuilder =
    MacerationsCompanion Function({
      Value<String> id,
      Value<String> batchId,
      Value<DateTime> startedAt,
      Value<DateTime?> plannedEndAt,
      Value<int> shakeEveryDays,
      Value<DateTime?> lastShakenAt,
      Value<int> shakenCount,
      Value<double> strengthAbv,
      Value<DateTime?> finishedAt,
      Value<String> notes,
      Value<int> rowid,
    });

final class $$MacerationsTableReferences
    extends BaseReferences<_$AppDatabase, $MacerationsTable, Maceration> {
  $$MacerationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('macerations__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MacerationsTableFilterComposer
    extends Composer<_$AppDatabase, $MacerationsTable> {
  $$MacerationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plannedEndAt => $composableBuilder(
    column: $table.plannedEndAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shakeEveryDays => $composableBuilder(
    column: $table.shakeEveryDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastShakenAt => $composableBuilder(
    column: $table.lastShakenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shakenCount => $composableBuilder(
    column: $table.shakenCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get strengthAbv => $composableBuilder(
    column: $table.strengthAbv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MacerationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MacerationsTable> {
  $$MacerationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plannedEndAt => $composableBuilder(
    column: $table.plannedEndAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shakeEveryDays => $composableBuilder(
    column: $table.shakeEveryDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastShakenAt => $composableBuilder(
    column: $table.lastShakenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shakenCount => $composableBuilder(
    column: $table.shakenCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get strengthAbv => $composableBuilder(
    column: $table.strengthAbv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MacerationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MacerationsTable> {
  $$MacerationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get plannedEndAt => $composableBuilder(
    column: $table.plannedEndAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shakeEveryDays => $composableBuilder(
    column: $table.shakeEveryDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastShakenAt => $composableBuilder(
    column: $table.lastShakenAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shakenCount => $composableBuilder(
    column: $table.shakenCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get strengthAbv => $composableBuilder(
    column: $table.strengthAbv,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MacerationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MacerationsTable,
          Maceration,
          $$MacerationsTableFilterComposer,
          $$MacerationsTableOrderingComposer,
          $$MacerationsTableAnnotationComposer,
          $$MacerationsTableCreateCompanionBuilder,
          $$MacerationsTableUpdateCompanionBuilder,
          (Maceration, $$MacerationsTableReferences),
          Maceration,
          PrefetchHooks Function({bool batchId})
        > {
  $$MacerationsTableTableManager(_$AppDatabase db, $MacerationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MacerationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MacerationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MacerationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> plannedEndAt = const Value.absent(),
                Value<int> shakeEveryDays = const Value.absent(),
                Value<DateTime?> lastShakenAt = const Value.absent(),
                Value<int> shakenCount = const Value.absent(),
                Value<double> strengthAbv = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MacerationsCompanion(
                id: id,
                batchId: batchId,
                startedAt: startedAt,
                plannedEndAt: plannedEndAt,
                shakeEveryDays: shakeEveryDays,
                lastShakenAt: lastShakenAt,
                shakenCount: shakenCount,
                strengthAbv: strengthAbv,
                finishedAt: finishedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                required DateTime startedAt,
                Value<DateTime?> plannedEndAt = const Value.absent(),
                Value<int> shakeEveryDays = const Value.absent(),
                Value<DateTime?> lastShakenAt = const Value.absent(),
                Value<int> shakenCount = const Value.absent(),
                Value<double> strengthAbv = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MacerationsCompanion.insert(
                id: id,
                batchId: batchId,
                startedAt: startedAt,
                plannedEndAt: plannedEndAt,
                shakeEveryDays: shakeEveryDays,
                lastShakenAt: lastShakenAt,
                shakenCount: shakenCount,
                strengthAbv: strengthAbv,
                finishedAt: finishedAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MacerationsTable, Maceration>(table),
                  $$MacerationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$MacerationsTableReferences
                            ._batchIdTable(db),
                        referencedColumn: $$MacerationsTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MacerationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MacerationsTable,
      Maceration,
      $$MacerationsTableFilterComposer,
      $$MacerationsTableOrderingComposer,
      $$MacerationsTableAnnotationComposer,
      $$MacerationsTableCreateCompanionBuilder,
      $$MacerationsTableUpdateCompanionBuilder,
      (Maceration, $$MacerationsTableReferences),
      Maceration,
      PrefetchHooks Function({bool batchId})
    >;
typedef $$TastingsTableCreateCompanionBuilder = TastingsCompanion Function({
  required String id,
  required String batchId,
  required DateTime at,
  Value<int> rating,
  Value<String> aroma,
  Value<String> taste,
  Value<String> finish,
  Value<String> verdict,
  Value<String> photoPath,
  Value<int> rowid,
});
typedef $$TastingsTableUpdateCompanionBuilder = TastingsCompanion Function({
  Value<String> id,
  Value<String> batchId,
  Value<DateTime> at,
  Value<int> rating,
  Value<String> aroma,
  Value<String> taste,
  Value<String> finish,
  Value<String> verdict,
  Value<String> photoPath,
  Value<int> rowid,
});

final class $$TastingsTableReferences
    extends BaseReferences<_$AppDatabase, $TastingsTable, Tasting> {
  $$TastingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('tastings__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TastingsTableFilterComposer
    extends Composer<_$AppDatabase, $TastingsTable> {
  $$TastingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aroma => $composableBuilder(
    column: $table.aroma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taste => $composableBuilder(
    column: $table.taste,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get finish => $composableBuilder(
    column: $table.finish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verdict => $composableBuilder(
    column: $table.verdict,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TastingsTableOrderingComposer
    extends Composer<_$AppDatabase, $TastingsTable> {
  $$TastingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aroma => $composableBuilder(
    column: $table.aroma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taste => $composableBuilder(
    column: $table.taste,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get finish => $composableBuilder(
    column: $table.finish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verdict => $composableBuilder(
    column: $table.verdict,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TastingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TastingsTable> {
  $$TastingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get aroma =>
      $composableBuilder(column: $table.aroma, builder: (column) => column);

  GeneratedColumn<String> get taste =>
      $composableBuilder(column: $table.taste, builder: (column) => column);

  GeneratedColumn<String> get finish =>
      $composableBuilder(column: $table.finish, builder: (column) => column);

  GeneratedColumn<String> get verdict =>
      $composableBuilder(column: $table.verdict, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TastingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TastingsTable,
          Tasting,
          $$TastingsTableFilterComposer,
          $$TastingsTableOrderingComposer,
          $$TastingsTableAnnotationComposer,
          $$TastingsTableCreateCompanionBuilder,
          $$TastingsTableUpdateCompanionBuilder,
          (Tasting, $$TastingsTableReferences),
          Tasting,
          PrefetchHooks Function({bool batchId})
        > {
  $$TastingsTableTableManager(_$AppDatabase db, $TastingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TastingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TastingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TastingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<String> aroma = const Value.absent(),
                Value<String> taste = const Value.absent(),
                Value<String> finish = const Value.absent(),
                Value<String> verdict = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TastingsCompanion(
                id: id,
                batchId: batchId,
                at: at,
                rating: rating,
                aroma: aroma,
                taste: taste,
                finish: finish,
                verdict: verdict,
                photoPath: photoPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                required DateTime at,
                Value<int> rating = const Value.absent(),
                Value<String> aroma = const Value.absent(),
                Value<String> taste = const Value.absent(),
                Value<String> finish = const Value.absent(),
                Value<String> verdict = const Value.absent(),
                Value<String> photoPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TastingsCompanion.insert(
                id: id,
                batchId: batchId,
                at: at,
                rating: rating,
                aroma: aroma,
                taste: taste,
                finish: finish,
                verdict: verdict,
                photoPath: photoPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TastingsTable, Tasting>(table),
                  $$TastingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$TastingsTableReferences
                            ._batchIdTable(db),
                        referencedColumn: $$TastingsTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TastingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TastingsTable,
      Tasting,
      $$TastingsTableFilterComposer,
      $$TastingsTableOrderingComposer,
      $$TastingsTableAnnotationComposer,
      $$TastingsTableCreateCompanionBuilder,
      $$TastingsTableUpdateCompanionBuilder,
      (Tasting, $$TastingsTableReferences),
      Tasting,
      PrefetchHooks Function({bool batchId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(_db, _db.recipeIngredients);
  $$RecipeStepsTableTableManager get recipeSteps =>
      $$RecipeStepsTableTableManager(_db, _db.recipeSteps);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db, _db.batches);
  $$BatchEventsTableTableManager get batchEvents =>
      $$BatchEventsTableTableManager(_db, _db.batchEvents);
  $$MeasurementsTableTableManager get measurements =>
      $$MeasurementsTableTableManager(_db, _db.measurements);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
  $$BatchIngredientsTableTableManager get batchIngredients =>
      $$BatchIngredientsTableTableManager(_db, _db.batchIngredients);
  $$RunsTableTableManager get runs => $$RunsTableTableManager(_db, _db.runs);
  $$RunFractionsTableTableManager get runFractions =>
      $$RunFractionsTableTableManager(_db, _db.runFractions);
  $$VesselsTableTableManager get vessels =>
      $$VesselsTableTableManager(_db, _db.vessels);
  $$AgingTableTableManager get aging =>
      $$AgingTableTableManager(_db, _db.aging);
  $$MacerationsTableTableManager get macerations =>
      $$MacerationsTableTableManager(_db, _db.macerations);
  $$TastingsTableTableManager get tastings =>
      $$TastingsTableTableManager(_db, _db.tastings);
}
