// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependency_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Must be overridden at startup with the loaded instance.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// Must be overridden at startup with the loaded instance.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Must be overridden at startup with the loaded instance.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'70ef90bd70df9f89260fca9b542d9f8d25d8e3cb';

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'8a644d41ebab6efe60fe4fa590d83036f91a7132';

@ProviderFor(httpClient)
final httpClientProvider = HttpClientProvider._();

final class HttpClientProvider
    extends $FunctionalProvider<http.Client, http.Client, http.Client>
    with $Provider<http.Client> {
  HttpClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpClientHash();

  @$internal
  @override
  $ProviderElement<http.Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  http.Client create(Ref ref) {
    return httpClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(http.Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<http.Client>(value),
    );
  }
}

String _$httpClientHash() => r'7ec49beae0f15115de79f9aa98dbd250130e26d8';

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'd1a332f12e936e9baa62bbc710163c0c7906aae9';

@ProviderFor(networkMonitor)
final networkMonitorProvider = NetworkMonitorProvider._();

final class NetworkMonitorProvider
    extends $FunctionalProvider<NetworkMonitor, NetworkMonitor, NetworkMonitor>
    with $Provider<NetworkMonitor> {
  NetworkMonitorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkMonitorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkMonitorHash();

  @$internal
  @override
  $ProviderElement<NetworkMonitor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkMonitor create(Ref ref) {
    return networkMonitor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkMonitor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkMonitor>(value),
    );
  }
}

String _$networkMonitorHash() => r'86267b8b0a8712927a23e9f6493ff3788e2557cb';

@ProviderFor(countriesRepository)
final countriesRepositoryProvider = CountriesRepositoryProvider._();

final class CountriesRepositoryProvider
    extends
        $FunctionalProvider<
          CountriesRepository,
          CountriesRepository,
          CountriesRepository
        >
    with $Provider<CountriesRepository> {
  CountriesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countriesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countriesRepositoryHash();

  @$internal
  @override
  $ProviderElement<CountriesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CountriesRepository create(Ref ref) {
    return countriesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountriesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountriesRepository>(value),
    );
  }
}

String _$countriesRepositoryHash() =>
    r'29368a77dbcd55ec4b8f60d9647a8ba0bdff60d9';

@ProviderFor(favoritesRepository)
final favoritesRepositoryProvider = FavoritesRepositoryProvider._();

final class FavoritesRepositoryProvider
    extends
        $FunctionalProvider<
          FavoritesRepository,
          FavoritesRepository,
          FavoritesRepository
        >
    with $Provider<FavoritesRepository> {
  FavoritesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavoritesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoritesRepository create(Ref ref) {
    return favoritesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesRepository>(value),
    );
  }
}

String _$favoritesRepositoryHash() =>
    r'17e00dad2138615ebded6d48d772e78a4da1c5fb';

@ProviderFor(weatherRepository)
final weatherRepositoryProvider = WeatherRepositoryProvider._();

final class WeatherRepositoryProvider
    extends
        $FunctionalProvider<
          WeatherRepository,
          WeatherRepository,
          WeatherRepository
        >
    with $Provider<WeatherRepository> {
  WeatherRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherRepositoryHash();

  @$internal
  @override
  $ProviderElement<WeatherRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherRepository create(Ref ref) {
    return weatherRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherRepository>(value),
    );
  }
}

String _$weatherRepositoryHash() => r'78f53f273a2980e639180454b664e2c1094bc88f';

@ProviderFor(sortOptionRepository)
final sortOptionRepositoryProvider = SortOptionRepositoryProvider._();

final class SortOptionRepositoryProvider
    extends
        $FunctionalProvider<
          SortOptionRepository,
          SortOptionRepository,
          SortOptionRepository
        >
    with $Provider<SortOptionRepository> {
  SortOptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortOptionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortOptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SortOptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SortOptionRepository create(Ref ref) {
    return sortOptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SortOptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SortOptionRepository>(value),
    );
  }
}

String _$sortOptionRepositoryHash() =>
    r'15db6782e92ebb808b276d4a325b5be7b856e564';

@ProviderFor(flagCacheManager)
final flagCacheManagerProvider = FlagCacheManagerProvider._();

final class FlagCacheManagerProvider
    extends
        $FunctionalProvider<
          BaseCacheManager,
          BaseCacheManager,
          BaseCacheManager
        >
    with $Provider<BaseCacheManager> {
  FlagCacheManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flagCacheManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flagCacheManagerHash();

  @$internal
  @override
  $ProviderElement<BaseCacheManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BaseCacheManager create(Ref ref) {
    return flagCacheManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseCacheManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseCacheManager>(value),
    );
  }
}

String _$flagCacheManagerHash() => r'a7ff3d0ecaa66484102570323ab4930443a13263';

@ProviderFor(mapDataRepository)
final mapDataRepositoryProvider = MapDataRepositoryProvider._();

final class MapDataRepositoryProvider
    extends
        $FunctionalProvider<
          MapDataRepository,
          MapDataRepository,
          MapDataRepository
        >
    with $Provider<MapDataRepository> {
  MapDataRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapDataRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapDataRepositoryHash();

  @$internal
  @override
  $ProviderElement<MapDataRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MapDataRepository create(Ref ref) {
    return mapDataRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapDataRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapDataRepository>(value),
    );
  }
}

String _$mapDataRepositoryHash() => r'5b53b2a5a08f3f0ba4dc4fa1d91189374abbbd9d';
