import 'package:country_finder/core/app_database.dart';
import 'package:drift/drift.dart';

class FavoriteEntry {
  const FavoriteEntry({required this.alpha3Code, required this.dateAdded});

  final String alpha3Code;
  final DateTime dateAdded;
}

abstract interface class FavoritesRepository {
  /// Newest first.
  Future<List<FavoriteEntry>> fetchAll();

  /// No-op if already a favorite.
  Future<void> add(String alpha3Code);

  /// No-op if not a favorite.
  Future<void> remove(String alpha3Code);
}

/// Favorites stored in the Drift `favorite_item` table.
class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._db, {this._now = DateTime.now});

  final AppDatabase _db;
  final DateTime Function() _now;

  @override
  Future<List<FavoriteEntry>> fetchAll() async {
    final query = _db.select(_db.favoriteItem)
      ..orderBy([(t) => OrderingTerm.desc(t.dateAdded)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        FavoriteEntry(alpha3Code: row.alpha3Code, dateAdded: row.dateAdded),
    ];
  }

  @override
  Future<void> add(String alpha3Code) async {
    await _db
        .into(_db.favoriteItem)
        .insert(
          FavoriteItemCompanion.insert(
            alpha3Code: alpha3Code,
            dateAdded: _now(),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  @override
  Future<void> remove(String alpha3Code) async {
    await (_db.delete(
      _db.favoriteItem,
    )..where((t) => t.alpha3Code.equals(alpha3Code))).go();
  }
}
