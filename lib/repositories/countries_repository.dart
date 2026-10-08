import 'dart:convert';

import 'package:country_finder/core/api_client.dart';
import 'package:country_finder/core/app_database.dart';
import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/core/network_monitor.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/shared/country_sorting.dart';
import 'package:logging/logging.dart';

final _log = Logger('CountriesRepository');

class CountriesFetchResult {
  const CountriesFetchResult({
    required this.countries,
    required this.isFromCache,
    this.cacheDate,
  });

  final List<Country> countries;

  /// The only thing that drives the offline banner: the device can be
  /// online while the request still fails.
  final bool isFromCache;

  /// When the cache was last written; null for a fresh network result.
  final DateTime? cacheDate;
}

abstract interface class CountriesRepository {
  /// [forceNetwork] always attempts a real request regardless of the network
  /// monitor. Used for an explicit Retry, since connectivity events can lag
  /// behind the real network state right after reconnecting.
  Future<CountriesFetchResult> fetchCountries({bool forceNetwork = false});
}

/// Network first, with the Drift cache as the offline fallback.
class CountriesRepositoryImpl implements CountriesRepository {
  CountriesRepositoryImpl({
    required this._api,
    required this._db,
    required this._networkMonitor,
    this._now = DateTime.now,
  });

  static final Uri countriesUrl = Uri.parse('https://countries.dev/countries');

  final ApiClient _api;
  final AppDatabase _db;
  final NetworkMonitor _networkMonitor;
  final DateTime Function() _now;

  @override
  Future<CountriesFetchResult> fetchCountries({
    bool forceNetwork = false,
  }) async {
    if (!forceNetwork && !_networkMonitor.isConnected) {
      // Known offline: go straight to the cache instead of waiting out a
      // request that can only time out.
      return _cachedOrThrow(const NoConnectionError());
    }
    try {
      final decoded = decodeCountries(await _api.get(countriesUrl));
      await _writeThrough(decoded);
      return CountriesFetchResult(
        countries: sortedByName(decoded.map((d) => d.country)),
        isFromCache: false,
      );
    } on DomainError catch (error) {
      _log.info('Network fetch failed ($error), falling back to cache');
      return _cachedOrThrow(error);
    }
  }

  /// Best-effort: a cache write failure must not fail a successful fetch.
  Future<void> _writeThrough(List<DecodedCountry> decoded) async {
    final timestamp = _now();
    try {
      // Replaced wholesale rather than diffed; a couple hundred small rows.
      await _db.transaction(() async {
        await _db.delete(_db.countryCache).go();
        await _db.batch((batch) {
          batch.insertAll(_db.countryCache, [
            for (final d in decoded)
              CountryCacheCompanion.insert(
                alpha3Code: d.country.alpha3Code,
                jsonData: d.rawJson,
                lastUpdated: timestamp,
              ),
          ]);
        });
      });
    } on Object catch (e, st) {
      _log.warning('Failed to write countries cache', e, st);
    }
  }

  /// Rethrows [fallbackError] (the original failure) if the cache is empty.
  Future<CountriesFetchResult> _cachedOrThrow(DomainError fallbackError) async {
    final List<CountryCacheRow> rows;
    try {
      rows = await _db.select(_db.countryCache).get();
    } on Object catch (e, st) {
      _log.warning('Failed to read countries cache', e, st);
      throw fallbackError;
    }
    final countries = <Country>[];
    for (final row in rows) {
      final country = _decodeRow(row);
      if (country != null) countries.add(country);
    }
    if (countries.isEmpty) throw fallbackError;
    return CountriesFetchResult(
      countries: sortedByName(countries),
      isFromCache: true,
      // All rows come from one batch, so max just picks the latest stamp.
      cacheDate: rows
          .map((r) => r.lastUpdated)
          .reduce((a, b) => a.isAfter(b) ? a : b),
    );
  }

  Country? _decodeRow(CountryCacheRow row) {
    try {
      final json = jsonDecode(row.jsonData);
      return json is Map<String, dynamic> ? tryDecodeCountry(json) : null;
    } on FormatException catch (e) {
      _log.fine('Skipping corrupt cache row ${row.alpha3Code}', e);
      return null;
    }
  }
}

/// A decoded country plus the exact JSON it came from, which is what gets
/// cached so `Country.fromJson` stays the single source of truth for shape.
typedef DecodedCountry = ({Country country, String rawJson});

/// Decodes item by item: one malformed record is skipped instead of failing
/// the list. A body that isn't a JSON array of objects at all throws
/// [DecodingFailedError] so the UI shows the error state, not an empty list.
List<DecodedCountry> decodeCountries(String body) {
  final Object? decoded;
  try {
    decoded = jsonDecode(body);
  } on FormatException catch (e) {
    _log.warning('Countries body is not JSON', e);
    throw const DecodingFailedError();
  }
  if (decoded is! List ||
      decoded.any((item) => item is! Map<String, dynamic>)) {
    throw const DecodingFailedError();
  }
  final result = <DecodedCountry>[];
  for (final item in decoded.cast<Map<String, dynamic>>()) {
    final country = tryDecodeCountry(item);
    if (country != null) {
      result.add((country: country, rawJson: jsonEncode(item)));
    }
  }
  return result;
}

Country? tryDecodeCountry(Map<String, dynamic> json) {
  try {
    return Country.fromJson(json);
  } on Object catch (e) {
    // Missing required keys surface as TypeError from the generated code.
    _log.fine('Skipping malformed country ${json['alpha3Code']}: $e');
    return null;
  }
}
