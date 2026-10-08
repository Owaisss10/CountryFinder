import 'package:country_finder/core/api_client.dart';
import 'package:country_finder/core/app_database.dart';
import 'package:country_finder/core/flag_cache_manager.dart';
import 'package:country_finder/core/network_monitor.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:country_finder/repositories/favorites_repository.dart';
import 'package:country_finder/repositories/map_data_repository.dart';
import 'package:country_finder/repositories/sort_option_repository.dart';
import 'package:country_finder/repositories/weather_repository.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dependency_providers.g.dart';

// The app's dependencies: the Riverpod version of RepositoryProvider or
// get_it. Tests swap any of these with ProviderScope/ProviderContainer
// overrides.

/// Must be overridden at startup with the loaded instance.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('sharedPreferencesProvider must be overridden');

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase.defaults();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
http.Client httpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => ApiClient(ref.watch(httpClientProvider));

@Riverpod(keepAlive: true)
NetworkMonitor networkMonitor(Ref ref) {
  final monitor = ConnectivityNetworkMonitor();
  ref.onDispose(monitor.dispose);
  return monitor;
}

@Riverpod(keepAlive: true)
CountriesRepository countriesRepository(Ref ref) => CountriesRepositoryImpl(
  api: ref.watch(apiClientProvider),
  db: ref.watch(appDatabaseProvider),
  networkMonitor: ref.watch(networkMonitorProvider),
);

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) =>
    FavoritesRepositoryImpl(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) =>
    OpenMeteoWeatherRepository(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
SortOptionRepository sortOptionRepository(Ref ref) =>
    SharedPrefsSortOptionRepository(ref.watch(sharedPreferencesProvider));

@Riverpod(keepAlive: true)
BaseCacheManager flagCacheManager(Ref ref) => FlagCacheManager();

@Riverpod(keepAlive: true)
MapDataRepository mapDataRepository(Ref ref) =>
    AssetMapDataRepository(rootBundle);
