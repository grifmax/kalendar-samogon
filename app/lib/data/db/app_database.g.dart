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
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (batchEventsRefs) db.batchEvents,
                    if (measurementsRefs) db.measurements,
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
}
