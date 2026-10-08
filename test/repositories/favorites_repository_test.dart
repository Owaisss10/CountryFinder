import 'package:country_finder/core/app_database.dart';
import 'package:country_finder/repositories/favorites_repository.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
  });

  tearDown(() => db.close());

  test('fetchAll is newest first; add and remove are idempotent', () async {
    var t = DateTime(2026);
    final repo = FavoritesRepositoryImpl(
      db,
      now: () => t = t.add(const Duration(minutes: 1)),
    );
    await repo.add('FRA');
    await repo.add('ESP');
    await repo.add('FRA');
    expect((await repo.fetchAll()).map((e) => e.alpha3Code), ['ESP', 'FRA']);

    await repo.remove('FRA');
    await repo.remove('XXX');
    expect((await repo.fetchAll()).map((e) => e.alpha3Code), ['ESP']);
  });
}
