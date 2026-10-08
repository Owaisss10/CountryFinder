import 'dart:convert';
import 'dart:io';

import 'package:country_finder/core/api_client.dart';
import 'package:country_finder/core/app_database.dart';
import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../support/fixtures.dart';

void main() {
  group('decodeCountries', () {
    test('skips records with missing or mistyped required keys', () {
      final body = jsonEncode([
        countryJson(),
        {'name': 'No code', 'alpha2Code': 'NC', 'region': 'Europe'},
        {'alpha3Code': 'NON', 'alpha2Code': 'NO', 'region': 'Europe'},
        countryJson(name: 'Spain', alpha3Code: 'ESP')..['population'] = 'lots',
      ]);
      expect(decodeCountries(body).map((d) => d.country.alpha3Code), ['FRA']);
    });

    test('keeps the raw JSON of each decoded record', () {
      final decoded = decodeCountries(jsonEncode([countryJson()]));
      expect(jsonDecode(decoded.single.rawJson), countryJson());
    });

    test('a body that is not an array of objects throws decodingFailed', () {
      for (final body in ['{"message": "nope"}', 'not json', '[1, 2]']) {
        expect(
          () => decodeCountries(body),
          throwsA(const DecodingFailedError()),
        );
      }
    });

    test('every record of a real API response decodes', () {
      final body = File('test/fixtures/countries.json').readAsStringSync();
      final countries = decodeCountries(body).map((d) => d.country).toList();
      expect(countries, hasLength(250));
      expect(
        countries.firstWhere((c) => c.alpha3Code == 'CIV').matches('cote'),
        isTrue,
      );
      expect(
        countries.firstWhere((c) => c.alpha3Code == 'TUR').matches('turkiye'),
        isTrue,
      );
    });
  });

  group('CountriesRepositoryImpl', () {
    late AppDatabase db;
    late FakeNetworkMonitor monitor;
    late List<http.Request> requests;
    late http.Response Function(http.Request) respond;
    final now = DateTime(2026, 10, 1, 12);

    CountriesRepositoryImpl repo() => CountriesRepositoryImpl(
      api: ApiClient(fakeHttp((r) => respond(r), log: requests)),
      db: db,
      networkMonitor: monitor,
      now: () => now,
    );

    setUp(() {
      db = AppDatabase(
        DatabaseConnection(
          NativeDatabase.memory(),
          closeStreamsSynchronously: true,
        ),
      );
      monitor = FakeNetworkMonitor();
      requests = [];
      respond = (_) => jsonResponse([
        countryJson(name: 'Spain', alpha3Code: 'ESP'),
        countryJson(name: 'austria', alpha3Code: 'AUT'),
        {'broken': true},
      ]);
    });

    tearDown(() => db.close());

    test('online: returns sorted network data and writes the cache', () async {
      final result = await repo().fetchCountries();
      expect(result.isFromCache, isFalse);
      expect(result.cacheDate, isNull);
      expect(result.countries.map((c) => c.alpha3Code), ['AUT', 'ESP']);
      expect(requests.single.url, CountriesRepositoryImpl.countriesUrl);
      final rows = await db.select(db.countryCache).get();
      expect(rows.map((r) => r.alpha3Code), unorderedEquals(['AUT', 'ESP']));
      expect(rows.first.lastUpdated, now);
    });

    test('a new fetch replaces the cache wholesale', () async {
      await repo().fetchCountries();
      respond = (_) =>
          jsonResponse([countryJson(name: 'Italy', alpha3Code: 'ITA')]);
      await repo().fetchCountries();
      final rows = await db.select(db.countryCache).get();
      expect(rows.map((r) => r.alpha3Code), ['ITA']);
    });

    test('known offline: serves the cache without a request', () async {
      await repo().fetchCountries();
      requests.clear();
      monitor.isConnected = false;
      final result = await repo().fetchCountries();
      expect(requests, isEmpty);
      expect(result.isFromCache, isTrue);
      expect(result.cacheDate, now);
      expect(result.countries.map((c) => c.alpha3Code), ['AUT', 'ESP']);
    });

    test('offline with an empty cache throws noConnection', () {
      monitor.isConnected = false;
      expect(repo().fetchCountries(), throwsA(const NoConnectionError()));
    });

    test('forceNetwork ignores the network monitor', () async {
      monitor.isConnected = false;
      final result = await repo().fetchCountries(forceNetwork: true);
      expect(requests, hasLength(1));
      expect(result.isFromCache, isFalse);
    });

    test('a network error falls back to the cache', () async {
      await repo().fetchCountries();
      respond = offline;
      final result = await repo().fetchCountries();
      expect(result.isFromCache, isTrue);
      expect(result.countries, hasLength(2));
    });

    test('a network error with an empty cache rethrows the original', () {
      respond = (_) => jsonResponse('', status: 429);
      expect(repo().fetchCountries(), throwsA(const RateLimitedError()));
    });

    test('a non-array body with an empty cache surfaces decodingFailed', () {
      respond = (_) => jsonResponse({'oops': 1});
      expect(repo().fetchCountries(), throwsA(const DecodingFailedError()));
    });

    test('corrupt cache rows are skipped', () async {
      await repo().fetchCountries();
      await db
          .into(db.countryCache)
          .insert(
            CountryCacheCompanion.insert(
              alpha3Code: 'BAD',
              jsonData: '{not json',
              lastUpdated: now,
            ),
          );
      monitor.isConnected = false;
      final result = await repo().fetchCountries();
      expect(result.countries.map((c) => c.alpha3Code), ['AUT', 'ESP']);
    });
  });
}
