import 'dart:async';

import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/search_query_provider.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';
import '../support/test_container.dart';

void main() {
  final fra = country();
  final esp = country(name: 'Spain', alpha3Code: 'ESP', capital: 'Madrid');
  final deu = country(name: 'Germany', alpha3Code: 'DEU', capital: 'Berlin');
  final countries = [deu, fra, esp];

  late FakeCountriesRepository repo;
  late InMemorySortOptionRepository sortRepo;

  setUp(() {
    repo = FakeCountriesRepository(
      (_) async =>
          CountriesFetchResult(countries: countries, isFromCache: false),
    );
    sortRepo = InMemorySortOptionRepository();
  });

  test('starts loading with the saved sort option', () {
    sortRepo.saved = const SortOption(
      field: SortField.area,
      direction: SortDirection.descending,
    );
    final container = testContainer(countries: repo, sortOption: sortRepo);
    final state = container.read(countriesListProvider);
    expect(state.viewState, isA<ViewLoading>());
    expect(state.sortOption.field, SortField.area);
  });

  test('a successful load sets the countries and the loaded state', () async {
    final container = testContainer(countries: repo);
    await container.read(countriesListProvider.notifier).load();
    final state = container.read(countriesListProvider);
    expect(state.viewState, isA<ViewLoaded>());
    expect(state.countries, countries);
    expect(state.isOffline, isFalse);
  });

  test('a second load while one is in flight is a no-op', () async {
    final completer = Completer<CountriesFetchResult>();
    repo.handler = (_) => completer.future;
    final container = testContainer(countries: repo);
    final notifier = container.read(countriesListProvider.notifier);
    final first = notifier.load();
    unawaited(notifier.load());
    unawaited(notifier.retry());
    completer.complete(
      CountriesFetchResult(countries: countries, isFromCache: false),
    );
    await first;
    expect(repo.calls, [false]);
  });

  test('retry forces the network', () async {
    final container = testContainer(countries: repo);
    await container.read(countriesListProvider.notifier).retry();
    expect(repo.calls, [true]);
  });

  test('a failure exposes the DomainError and retry recovers', () async {
    repo.handler = (_) async => throw const ServerError(500);
    final container = testContainer(countries: repo);
    final notifier = container.read(countriesListProvider.notifier);
    await notifier.load();
    final failed = container.read(countriesListProvider).viewState;
    expect((failed as ViewFailed).error, const ServerError(500));

    repo.handler = (_) async => CountriesFetchResult(
      countries: countries,
      isFromCache: true,
      cacheDate: DateTime(2026),
    );
    await notifier.retry();
    final state = container.read(countriesListProvider);
    expect(state.viewState, isA<ViewLoaded>());
    expect(state.isOffline, isTrue);
    expect(state.cacheDate, DateTime(2026));
  });

  test('sort changes are saved and drive the filtered list', () async {
    final container = testContainer(countries: repo, sortOption: sortRepo);
    final notifier = container.read(countriesListProvider.notifier);
    await notifier.load();
    expect(notifier.filtered('').map((c) => c.alpha3Code), [
      'FRA',
      'DEU',
      'ESP',
    ]);

    await notifier.selectSortField(SortField.name);
    expect(sortRepo.saved?.direction, SortDirection.descending);
    expect(
      container.read(filteredCountriesProvider('')).map((c) => c.alpha3Code),
      ['ESP', 'DEU', 'FRA'],
    );
    expect(notifier.filtered('spa').single, esp);
  });

  test('countryByAlpha3 looks up loaded countries', () async {
    final container = testContainer(countries: repo);
    final notifier = container.read(countriesListProvider.notifier);
    expect(notifier.countryByAlpha3('ESP'), isNull);
    await notifier.load();
    expect(notifier.countryByAlpha3('ESP'), esp);
  });

  test('the search query starts empty and updates', () {
    final container = testContainer(countries: repo);
    container.listen(searchQueryProvider, (_, _) {});
    expect(container.read(searchQueryProvider), '');
    container.read(searchQueryProvider.notifier).update('fra');
    expect(container.read(searchQueryProvider), 'fra');
  });
}
