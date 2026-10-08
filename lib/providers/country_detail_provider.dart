import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/weather.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_detail_provider.g.dart';

sealed class WeatherState {
  const WeatherState();
}

final class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded(this.weather);

  final Weather weather;
}

final class WeatherFailed extends WeatherState {
  /// A null [error] means the country has no usable coordinates.
  const WeatherFailed([this.error]);

  final DomainError? error;
}

class CountryDetailState {
  const CountryDetailState({
    required this.country,
    required this.neighbours,
    required this.weatherState,
  });

  /// Null if the code doesn't resolve against the loaded list.
  final Country? country;

  /// `borders` resolved against the loaded list, in order; unknown codes
  /// dropped.
  final List<Country> neighbours;

  final WeatherState weatherState;

  CountryDetailState copyWith({
    Country? country,
    List<Country>? neighbours,
    WeatherState? weatherState,
  }) => CountryDetailState(
    country: country ?? this.country,
    neighbours: neighbours ?? this.neighbours,
    weatherState: weatherState ?? this.weatherState,
  );
}

@riverpod
class CountryDetail extends _$CountryDetail {
  // Tags each weather request so a stale response can't overwrite a newer one.
  int _weatherRequest = 0;

  @override
  CountryDetailState build(String alpha3Code) {
    // listen, not watch: a rebuild would reset the weather state, which has
    // to survive unrelated changes such as toggling a favorite.
    ref.listen(countriesListProvider.select((s) => s.countries), (
      _,
      countries,
    ) {
      final (country, neighbours) = _resolve(countries);
      state = state.copyWith(country: country, neighbours: neighbours);
    });
    final (country, neighbours) = _resolve(
      ref.read(countriesListProvider).countries,
    );
    return CountryDetailState(
      country: country,
      neighbours: neighbours,
      weatherState: const WeatherLoading(),
    );
  }

  (Country?, List<Country>) _resolve(List<Country> countries) {
    final index = {for (final c in countries) c.alpha3Code: c};
    final country = index[alpha3Code];
    final neighbours = [
      for (final code in country?.borders ?? const <String>[]) ?index[code],
    ];
    return (country, neighbours);
  }

  Future<void> loadWeather() async {
    final coordinates = state.country?.coordinates;
    if (coordinates == null) {
      state = state.copyWith(weatherState: const WeatherFailed());
      return;
    }
    final request = ++_weatherRequest;
    state = state.copyWith(weatherState: const WeatherLoading());
    WeatherState next;
    try {
      final weather = await ref
          .read(weatherRepositoryProvider)
          .fetchWeather(coordinates.latitude, coordinates.longitude);
      next = WeatherLoaded(weather);
    } on DomainError catch (e) {
      next = WeatherFailed(e);
    } on Object {
      next = const WeatherFailed(WeatherUnavailableError());
    }
    if (!ref.mounted || request != _weatherRequest) return;
    state = state.copyWith(weatherState: next);
  }

  Future<void> retryWeather() => loadWeather();
}
