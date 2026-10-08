import 'dart:async';
import 'dart:convert';

import 'package:country_finder/core/network_monitor.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/map_data.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/models/weather.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:country_finder/repositories/favorites_repository.dart';
import 'package:country_finder/repositories/map_data_repository.dart';
import 'package:country_finder/repositories/sort_option_repository.dart';
import 'package:country_finder/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';

Map<String, dynamic> countryJson({
  String name = 'France',
  String alpha3Code = 'FRA',
  String alpha2Code = 'FR',
  String region = 'Europe',
  String? capital = 'Paris',
  String? nativeName,
  List<String>? altSpellings,
  int? population = 67000000,
  num? area = 551695,
  List<String>? borders,
  Object? flags = const {'png': 'https://example.com/fr.png'},
  List<num>? latlng = const [46, 2],
}) => {
  'name': name,
  'alpha3Code': alpha3Code,
  'alpha2Code': alpha2Code,
  'region': region,
  'capital': ?capital,
  'nativeName': ?nativeName,
  'altSpellings': ?altSpellings,
  'population': ?population,
  'area': ?area,
  'borders': ?borders,
  'flags': ?flags,
  'latlng': ?latlng,
};

Country country({
  String name = 'France',
  String alpha3Code = 'FRA',
  String? capital = 'Paris',
  String? nativeName,
  List<String>? altSpellings,
  int? population,
  double? area,
  double? populationDensity,
  List<String>? borders,
  List<Currency>? currencies,
  List<Language>? languages,
  List<String>? callingCodes,
  List<String>? timezones,
  List<double>? latlng = const [46, 2],
}) => Country(
  name: name,
  alpha3Code: alpha3Code,
  alpha2Code: alpha3Code.substring(0, 2),
  region: 'Europe',
  capital: capital,
  nativeName: nativeName,
  altSpellings: altSpellings,
  population: population,
  area: area,
  populationDensity: populationDensity,
  borders: borders,
  currencies: currencies,
  languages: languages,
  callingCodes: callingCodes,
  timezones: timezones,
  latlng: latlng,
);

const sampleWeather = Weather(
  temperature: 21.3,
  windspeed: 9.4,
  weathercode: 2,
  isDay: true,
);

/// A JSON response encoded as UTF-8 with no charset header.
http.Response jsonResponse(Object body, {int status = 200}) =>
    http.Response.bytes(
      utf8.encode(body is String ? body : jsonEncode(body)),
      status,
      headers: const {'content-type': 'application/json'},
    );

/// Fake HTTP client that answers with [respond] and records each request in
/// [log].
MockClient fakeHttp(
  FutureOr<http.Response> Function(http.Request request) respond, {
  List<http.Request>? log,
}) => MockClient((request) async {
  log?.add(request);
  return respond(request);
});

/// Fails like a real client does when the device is offline.
Never offline(http.Request request) =>
    throw http.ClientException('offline', request.url);

class FakeNetworkMonitor implements NetworkMonitor {
  FakeNetworkMonitor({this.isConnected = true});

  @override
  bool isConnected;
}

class FakeCountriesRepository implements CountriesRepository {
  FakeCountriesRepository(this.handler);

  Future<CountriesFetchResult> Function(bool forceNetwork) handler;
  final calls = <bool>[];

  @override
  Future<CountriesFetchResult> fetchCountries({bool forceNetwork = false}) {
    calls.add(forceNetwork);
    return handler(forceNetwork);
  }
}

class InMemoryFavoritesRepository implements FavoritesRepository {
  final List<FavoriteEntry> _entries = [];
  int _clock = 0;
  bool failWrites = false;

  @override
  Future<List<FavoriteEntry>> fetchAll() async =>
      [..._entries]..sort((a, b) => b.dateAdded.compareTo(a.dateAdded));

  @override
  Future<void> add(String alpha3Code) async {
    if (failWrites) throw StateError('disk full');
    if (_entries.any((e) => e.alpha3Code == alpha3Code)) return;
    _entries.add(
      FavoriteEntry(
        alpha3Code: alpha3Code,
        dateAdded: DateTime(2026).add(Duration(seconds: _clock++)),
      ),
    );
  }

  @override
  Future<void> remove(String alpha3Code) async {
    if (failWrites) throw StateError('disk full');
    _entries.removeWhere((e) => e.alpha3Code == alpha3Code);
  }
}

class MockWeatherRepository extends Mock implements WeatherRepository {}

/// A square of land around France, enough to check the basemap draws, and a
/// pin spot for France matching the `country()` fixture's default
/// coordinates, on that (large) land.
const sampleMapData = MapData(
  shapes: [
    CountryShape(
      code: 'FRA',
      polygons: [
        [
          [LatLng(42, -5), LatLng(51, -5), LatLng(51, 8), LatLng(42, 8)],
        ],
      ],
    ),
  ],
  pins: {'FRA': PinSpot(point: LatLng(46, 2), landSize: 13)},
);

class FakeMapDataRepository implements MapDataRepository {
  FakeMapDataRepository([this.data = const MapData(shapes: [], pins: {})]);

  final MapData data;

  @override
  Future<MapData> load() async => data;
}

class InMemorySortOptionRepository implements SortOptionRepository {
  InMemorySortOptionRepository([this.saved]);

  SortOption? saved;

  @override
  SortOption load() => saved ?? SortOption.defaultOption;

  @override
  Future<void> save(SortOption option) async => saved = option;
}
