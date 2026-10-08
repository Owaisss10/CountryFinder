import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/country_detail_provider.dart';
import 'package:country_finder/providers/favorites_provider.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../support/fixtures.dart';
import '../support/test_container.dart';

void main() {
  final fra = country(borders: ['ESP', 'XXX', 'DEU']);
  final esp = country(name: 'Spain', alpha3Code: 'ESP');
  final deu = country(name: 'Germany', alpha3Code: 'DEU');

  late FakeCountriesRepository countriesRepo;
  late MockWeatherRepository weatherRepo;

  setUp(() {
    countriesRepo = FakeCountriesRepository(
      (_) async =>
          CountriesFetchResult(countries: [deu, fra, esp], isFromCache: false),
    );
    weatherRepo = MockWeatherRepository();
  });

  /// A container with the countries loaded and [code]'s detail provider
  /// kept alive.
  Future<ProviderContainer> loaded(String code) async {
    final container = testContainer(
      countries: countriesRepo,
      weather: weatherRepo,
    );
    await container.read(countriesListProvider.notifier).load();
    container.listen(countryDetailProvider(code), (_, _) {});
    return container;
  }

  test('resolves neighbours in order, dropping unknown codes', () async {
    final container = await loaded('FRA');
    final state = container.read(countryDetailProvider('FRA'));
    expect(state.country, fra);
    expect(state.neighbours, [esp, deu]);
  });

  test('an unknown code resolves to no country', () async {
    final container = await loaded('NOPE');
    expect(container.read(countryDetailProvider('NOPE')).country, isNull);
  });

  test('weather loads with the country coordinates', () async {
    when(
      () => weatherRepo.fetchWeather(46, 2),
    ).thenAnswer((_) async => sampleWeather);
    final container = await loaded('FRA');
    expect(
      container.read(countryDetailProvider('FRA')).weatherState,
      isA<WeatherLoading>(),
    );
    await container.read(countryDetailProvider('FRA').notifier).loadWeather();
    final weather = container.read(countryDetailProvider('FRA')).weatherState;
    expect((weather as WeatherLoaded).weather, sampleWeather);
  });

  test('a weather failure, then a successful retry', () async {
    var fail = true;
    when(() => weatherRepo.fetchWeather(any(), any())).thenAnswer((_) async {
      if (fail) throw const WeatherUnavailableError();
      return sampleWeather;
    });
    final container = await loaded('FRA');
    final notifier = container.read(countryDetailProvider('FRA').notifier);

    await notifier.loadWeather();
    final failed = container.read(countryDetailProvider('FRA')).weatherState;
    expect((failed as WeatherFailed).error, const WeatherUnavailableError());

    fail = false;
    await notifier.retryWeather();
    expect(
      container.read(countryDetailProvider('FRA')).weatherState,
      isA<WeatherLoaded>(),
    );
  });

  test('missing coordinates fail without a request', () async {
    countriesRepo.handler = (_) async => CountriesFetchResult(
      countries: [
        country(alpha3Code: 'NLL', latlng: [1]),
      ],
      isFromCache: false,
    );
    final container = await loaded('NLL');
    await container.read(countryDetailProvider('NLL').notifier).loadWeather();
    final state = container.read(countryDetailProvider('NLL')).weatherState;
    expect((state as WeatherFailed).error, isNull);
    verifyNever(() => weatherRepo.fetchWeather(any(), any()));
  });

  test('the weather state survives a favorite toggle', () async {
    when(
      () => weatherRepo.fetchWeather(any(), any()),
    ).thenAnswer((_) async => sampleWeather);
    final container = await loaded('FRA');
    await container.read(countryDetailProvider('FRA').notifier).loadWeather();
    await container.read(favoritesProvider.notifier).toggle('FRA');
    expect(
      container.read(countryDetailProvider('FRA')).weatherState,
      isA<WeatherLoaded>(),
    );
    verify(() => weatherRepo.fetchWeather(any(), any())).called(1);
  });
}
