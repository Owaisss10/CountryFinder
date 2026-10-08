import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/favorites_provider.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';
import '../support/test_container.dart';

void main() {
  final fra = country();
  final esp = country(name: 'Spain', alpha3Code: 'ESP');
  final deu = country(name: 'Germany', alpha3Code: 'DEU');

  late FakeCountriesRepository countriesRepo;
  late InMemoryFavoritesRepository favoritesRepo;

  setUp(() {
    countriesRepo = FakeCountriesRepository(
      (_) async =>
          CountriesFetchResult(countries: [deu, fra, esp], isFromCache: false),
    );
    favoritesRepo = InMemoryFavoritesRepository();
  });

  test('orders newest first and resolves once countries load', () async {
    await favoritesRepo.add('ESP');
    await favoritesRepo.add('FRA');
    await favoritesRepo.add('ZZZ');
    final container = testContainer(
      countries: countriesRepo,
      favorites: favoritesRepo,
    );
    container.read(favoritesProvider);
    await container.read(favoritesProvider.notifier).refresh();
    expect(container.read(favoritesProvider).favorites, isEmpty);
    expect(container.read(favoritesProvider).order, ['ZZZ', 'FRA', 'ESP']);

    await container.read(countriesListProvider.notifier).load();
    expect(container.read(favoritesProvider).favorites, [fra, esp]);
  });

  test('toggle adds and removes', () async {
    final container = testContainer(
      countries: countriesRepo,
      favorites: favoritesRepo,
    );
    await container.read(countriesListProvider.notifier).load();
    final notifier = container.read(favoritesProvider.notifier);

    await notifier.toggle('DEU');
    expect(container.read(favoritesProvider).isFavorite('DEU'), isTrue);
    await notifier.toggle('ESP');
    expect(container.read(favoritesProvider).favorites, [esp, deu]);
    await notifier.toggle('DEU');
    expect(container.read(favoritesProvider).favorites, [esp]);
  });

  test('persistence errors are logged, not thrown', () async {
    favoritesRepo.failWrites = true;
    final container = testContainer(
      countries: countriesRepo,
      favorites: favoritesRepo,
    );
    await container.read(favoritesProvider.notifier).toggle('FRA');
    expect(container.read(favoritesProvider).isFavorite('FRA'), isFalse);
  });
}
