import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// One row per country, holding the raw API JSON rather than mirrored
/// columns so `Country.fromJson` stays the only definition of its shape.
@DataClassName('CountryCacheRow')
class CountryCache extends Table {
  TextColumn get alpha3Code => text()();
  TextColumn get jsonData => text()();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {alpha3Code};
}

@DataClassName('FavoriteItemRow')
class FavoriteItem extends Table {
  TextColumn get alpha3Code => text()();
  DateTimeColumn get dateAdded => dateTime()();

  @override
  Set<Column> get primaryKey => {alpha3Code};
}

@DriftDatabase(tables: [CountryCache, FavoriteItem])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults() : super(driftDatabase(name: 'country_finder'));

  @override
  int get schemaVersion => 1;
}
