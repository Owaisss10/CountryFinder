import 'package:country_finder/providers/dependency_providers.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:country_finder/repositories/favorites_repository.dart';
import 'package:country_finder/repositories/map_data_repository.dart';
import 'package:country_finder/repositories/sort_option_repository.dart';
import 'package:country_finder/repositories/weather_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fixtures.dart';

/// A ProviderContainer wired to fakes instead of real repositories. It's
/// disposed automatically when the test ends.
ProviderContainer testContainer({
  required CountriesRepository countries,
  FavoritesRepository? favorites,
  WeatherRepository? weather,
  SortOptionRepository? sortOption,
  MapDataRepository? mapData,
}) => ProviderContainer.test(
  overrides: [
    countriesRepositoryProvider.overrideWithValue(countries),
    favoritesRepositoryProvider.overrideWithValue(
      favorites ?? InMemoryFavoritesRepository(),
    ),
    weatherRepositoryProvider.overrideWithValue(
      weather ?? MockWeatherRepository(),
    ),
    sortOptionRepositoryProvider.overrideWithValue(
      sortOption ?? InMemorySortOptionRepository(),
    ),
    mapDataRepositoryProvider.overrideWithValue(
      mapData ?? FakeMapDataRepository(),
    ),
  ],
);
