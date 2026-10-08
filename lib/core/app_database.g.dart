// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CountryCacheTable extends CountryCache
    with TableInfo<$CountryCacheTable, CountryCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountryCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _alpha3CodeMeta = const VerificationMeta(
    'alpha3Code',
  );
  @override
  late final GeneratedColumn<String> alpha3Code = GeneratedColumn<String>(
    'alpha3_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonDataMeta = const VerificationMeta(
    'jsonData',
  );
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
    'json_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [alpha3Code, jsonData, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'country_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CountryCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('alpha3_code')) {
      context.handle(
        _alpha3CodeMeta,
        alpha3Code.isAcceptableOrUnknown(data['alpha3_code']!, _alpha3CodeMeta),
      );
    } else if (isInserting) {
      context.missing(_alpha3CodeMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(
        _jsonDataMeta,
        jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {alpha3Code};
  @override
  CountryCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CountryCacheRow(
      alpha3Code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alpha3_code'],
      )!,
      jsonData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_data'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $CountryCacheTable createAlias(String alias) {
    return $CountryCacheTable(attachedDatabase, alias);
  }
}

class CountryCacheRow extends DataClass implements Insertable<CountryCacheRow> {
  final String alpha3Code;
  final String jsonData;
  final DateTime lastUpdated;
  const CountryCacheRow({
    required this.alpha3Code,
    required this.jsonData,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['alpha3_code'] = Variable<String>(alpha3Code);
    map['json_data'] = Variable<String>(jsonData);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  CountryCacheCompanion toCompanion(bool nullToAbsent) {
    return CountryCacheCompanion(
      alpha3Code: Value(alpha3Code),
      jsonData: Value(jsonData),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory CountryCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CountryCacheRow(
      alpha3Code: serializer.fromJson<String>(json['alpha3Code']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'alpha3Code': serializer.toJson<String>(alpha3Code),
      'jsonData': serializer.toJson<String>(jsonData),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  CountryCacheRow copyWith({
    String? alpha3Code,
    String? jsonData,
    DateTime? lastUpdated,
  }) => CountryCacheRow(
    alpha3Code: alpha3Code ?? this.alpha3Code,
    jsonData: jsonData ?? this.jsonData,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  CountryCacheRow copyWithCompanion(CountryCacheCompanion data) {
    return CountryCacheRow(
      alpha3Code: data.alpha3Code.present
          ? data.alpha3Code.value
          : this.alpha3Code,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CountryCacheRow(')
          ..write('alpha3Code: $alpha3Code, ')
          ..write('jsonData: $jsonData, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(alpha3Code, jsonData, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountryCacheRow &&
          other.alpha3Code == this.alpha3Code &&
          other.jsonData == this.jsonData &&
          other.lastUpdated == this.lastUpdated);
}

class CountryCacheCompanion extends UpdateCompanion<CountryCacheRow> {
  final Value<String> alpha3Code;
  final Value<String> jsonData;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const CountryCacheCompanion({
    this.alpha3Code = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CountryCacheCompanion.insert({
    required String alpha3Code,
    required String jsonData,
    required DateTime lastUpdated,
    this.rowid = const Value.absent(),
  }) : alpha3Code = Value(alpha3Code),
       jsonData = Value(jsonData),
       lastUpdated = Value(lastUpdated);
  static Insertable<CountryCacheRow> custom({
    Expression<String>? alpha3Code,
    Expression<String>? jsonData,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (alpha3Code != null) 'alpha3_code': alpha3Code,
      if (jsonData != null) 'json_data': jsonData,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CountryCacheCompanion copyWith({
    Value<String>? alpha3Code,
    Value<String>? jsonData,
    Value<DateTime>? lastUpdated,
    Value<int>? rowid,
  }) {
    return CountryCacheCompanion(
      alpha3Code: alpha3Code ?? this.alpha3Code,
      jsonData: jsonData ?? this.jsonData,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (alpha3Code.present) {
      map['alpha3_code'] = Variable<String>(alpha3Code.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountryCacheCompanion(')
          ..write('alpha3Code: $alpha3Code, ')
          ..write('jsonData: $jsonData, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoriteItemTable extends FavoriteItem
    with TableInfo<$FavoriteItemTable, FavoriteItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _alpha3CodeMeta = const VerificationMeta(
    'alpha3Code',
  );
  @override
  late final GeneratedColumn<String> alpha3Code = GeneratedColumn<String>(
    'alpha3_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateAddedMeta = const VerificationMeta(
    'dateAdded',
  );
  @override
  late final GeneratedColumn<DateTime> dateAdded = GeneratedColumn<DateTime>(
    'date_added',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [alpha3Code, dateAdded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_item';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('alpha3_code')) {
      context.handle(
        _alpha3CodeMeta,
        alpha3Code.isAcceptableOrUnknown(data['alpha3_code']!, _alpha3CodeMeta),
      );
    } else if (isInserting) {
      context.missing(_alpha3CodeMeta);
    }
    if (data.containsKey('date_added')) {
      context.handle(
        _dateAddedMeta,
        dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta),
      );
    } else if (isInserting) {
      context.missing(_dateAddedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {alpha3Code};
  @override
  FavoriteItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteItemRow(
      alpha3Code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alpha3_code'],
      )!,
      dateAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_added'],
      )!,
    );
  }

  @override
  $FavoriteItemTable createAlias(String alias) {
    return $FavoriteItemTable(attachedDatabase, alias);
  }
}

class FavoriteItemRow extends DataClass implements Insertable<FavoriteItemRow> {
  final String alpha3Code;
  final DateTime dateAdded;
  const FavoriteItemRow({required this.alpha3Code, required this.dateAdded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['alpha3_code'] = Variable<String>(alpha3Code);
    map['date_added'] = Variable<DateTime>(dateAdded);
    return map;
  }

  FavoriteItemCompanion toCompanion(bool nullToAbsent) {
    return FavoriteItemCompanion(
      alpha3Code: Value(alpha3Code),
      dateAdded: Value(dateAdded),
    );
  }

  factory FavoriteItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteItemRow(
      alpha3Code: serializer.fromJson<String>(json['alpha3Code']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'alpha3Code': serializer.toJson<String>(alpha3Code),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
    };
  }

  FavoriteItemRow copyWith({String? alpha3Code, DateTime? dateAdded}) =>
      FavoriteItemRow(
        alpha3Code: alpha3Code ?? this.alpha3Code,
        dateAdded: dateAdded ?? this.dateAdded,
      );
  FavoriteItemRow copyWithCompanion(FavoriteItemCompanion data) {
    return FavoriteItemRow(
      alpha3Code: data.alpha3Code.present
          ? data.alpha3Code.value
          : this.alpha3Code,
      dateAdded: data.dateAdded.present ? data.dateAdded.value : this.dateAdded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteItemRow(')
          ..write('alpha3Code: $alpha3Code, ')
          ..write('dateAdded: $dateAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(alpha3Code, dateAdded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteItemRow &&
          other.alpha3Code == this.alpha3Code &&
          other.dateAdded == this.dateAdded);
}

class FavoriteItemCompanion extends UpdateCompanion<FavoriteItemRow> {
  final Value<String> alpha3Code;
  final Value<DateTime> dateAdded;
  final Value<int> rowid;
  const FavoriteItemCompanion({
    this.alpha3Code = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteItemCompanion.insert({
    required String alpha3Code,
    required DateTime dateAdded,
    this.rowid = const Value.absent(),
  }) : alpha3Code = Value(alpha3Code),
       dateAdded = Value(dateAdded);
  static Insertable<FavoriteItemRow> custom({
    Expression<String>? alpha3Code,
    Expression<DateTime>? dateAdded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (alpha3Code != null) 'alpha3_code': alpha3Code,
      if (dateAdded != null) 'date_added': dateAdded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteItemCompanion copyWith({
    Value<String>? alpha3Code,
    Value<DateTime>? dateAdded,
    Value<int>? rowid,
  }) {
    return FavoriteItemCompanion(
      alpha3Code: alpha3Code ?? this.alpha3Code,
      dateAdded: dateAdded ?? this.dateAdded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (alpha3Code.present) {
      map['alpha3_code'] = Variable<String>(alpha3Code.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<DateTime>(dateAdded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteItemCompanion(')
          ..write('alpha3Code: $alpha3Code, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CountryCacheTable countryCache = $CountryCacheTable(this);
  late final $FavoriteItemTable favoriteItem = $FavoriteItemTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    countryCache,
    favoriteItem,
  ];
}

typedef $$CountryCacheTableCreateCompanionBuilder =
    CountryCacheCompanion Function({
      required String alpha3Code,
      required String jsonData,
      required DateTime lastUpdated,
      Value<int> rowid,
    });
typedef $$CountryCacheTableUpdateCompanionBuilder =
    CountryCacheCompanion Function({
      Value<String> alpha3Code,
      Value<String> jsonData,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });

class $$CountryCacheTableFilterComposer
    extends Composer<_$AppDatabase, $CountryCacheTable> {
  $$CountryCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get alpha3Code => $composableBuilder(
    column: $table.alpha3Code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CountryCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $CountryCacheTable> {
  $$CountryCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get alpha3Code => $composableBuilder(
    column: $table.alpha3Code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CountryCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $CountryCacheTable> {
  $$CountryCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get alpha3Code => $composableBuilder(
    column: $table.alpha3Code,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$CountryCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CountryCacheTable,
          CountryCacheRow,
          $$CountryCacheTableFilterComposer,
          $$CountryCacheTableOrderingComposer,
          $$CountryCacheTableAnnotationComposer,
          $$CountryCacheTableCreateCompanionBuilder,
          $$CountryCacheTableUpdateCompanionBuilder,
          (
            CountryCacheRow,
            BaseReferences<_$AppDatabase, $CountryCacheTable, CountryCacheRow>,
          ),
          CountryCacheRow,
          PrefetchHooks Function()
        > {
  $$CountryCacheTableTableManager(_$AppDatabase db, $CountryCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CountryCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CountryCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CountryCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> alpha3Code = const Value.absent(),
                Value<String> jsonData = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CountryCacheCompanion(
                alpha3Code: alpha3Code,
                jsonData: jsonData,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String alpha3Code,
                required String jsonData,
                required DateTime lastUpdated,
                Value<int> rowid = const Value.absent(),
              }) => CountryCacheCompanion.insert(
                alpha3Code: alpha3Code,
                jsonData: jsonData,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CountryCacheTable, CountryCacheRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CountryCacheTable,
                    CountryCacheRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CountryCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CountryCacheTable,
      CountryCacheRow,
      $$CountryCacheTableFilterComposer,
      $$CountryCacheTableOrderingComposer,
      $$CountryCacheTableAnnotationComposer,
      $$CountryCacheTableCreateCompanionBuilder,
      $$CountryCacheTableUpdateCompanionBuilder,
      (
        CountryCacheRow,
        BaseReferences<_$AppDatabase, $CountryCacheTable, CountryCacheRow>,
      ),
      CountryCacheRow,
      PrefetchHooks Function()
    >;
typedef $$FavoriteItemTableCreateCompanionBuilder =
    FavoriteItemCompanion Function({
      required String alpha3Code,
      required DateTime dateAdded,
      Value<int> rowid,
    });
typedef $$FavoriteItemTableUpdateCompanionBuilder =
    FavoriteItemCompanion Function({
      Value<String> alpha3Code,
      Value<DateTime> dateAdded,
      Value<int> rowid,
    });

class $$FavoriteItemTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteItemTable> {
  $$FavoriteItemTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get alpha3Code => $composableBuilder(
    column: $table.alpha3Code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteItemTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteItemTable> {
  $$FavoriteItemTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get alpha3Code => $composableBuilder(
    column: $table.alpha3Code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteItemTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteItemTable> {
  $$FavoriteItemTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get alpha3Code => $composableBuilder(
    column: $table.alpha3Code,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateAdded =>
      $composableBuilder(column: $table.dateAdded, builder: (column) => column);
}

class $$FavoriteItemTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteItemTable,
          FavoriteItemRow,
          $$FavoriteItemTableFilterComposer,
          $$FavoriteItemTableOrderingComposer,
          $$FavoriteItemTableAnnotationComposer,
          $$FavoriteItemTableCreateCompanionBuilder,
          $$FavoriteItemTableUpdateCompanionBuilder,
          (
            FavoriteItemRow,
            BaseReferences<_$AppDatabase, $FavoriteItemTable, FavoriteItemRow>,
          ),
          FavoriteItemRow,
          PrefetchHooks Function()
        > {
  $$FavoriteItemTableTableManager(_$AppDatabase db, $FavoriteItemTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteItemTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteItemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteItemTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> alpha3Code = const Value.absent(),
                Value<DateTime> dateAdded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteItemCompanion(
                alpha3Code: alpha3Code,
                dateAdded: dateAdded,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String alpha3Code,
                required DateTime dateAdded,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteItemCompanion.insert(
                alpha3Code: alpha3Code,
                dateAdded: dateAdded,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoriteItemTable, FavoriteItemRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FavoriteItemTable,
                    FavoriteItemRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteItemTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteItemTable,
      FavoriteItemRow,
      $$FavoriteItemTableFilterComposer,
      $$FavoriteItemTableOrderingComposer,
      $$FavoriteItemTableAnnotationComposer,
      $$FavoriteItemTableCreateCompanionBuilder,
      $$FavoriteItemTableUpdateCompanionBuilder,
      (
        FavoriteItemRow,
        BaseReferences<_$AppDatabase, $FavoriteItemTable, FavoriteItemRow>,
      ),
      FavoriteItemRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CountryCacheTableTableManager get countryCache =>
      $$CountryCacheTableTableManager(_db, _db.countryCache);
  $$FavoriteItemTableTableManager get favoriteItem =>
      $$FavoriteItemTableTableManager(_db, _db.favoriteItem);
}
