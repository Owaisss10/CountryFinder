import 'dart:convert';

import 'package:country_finder/core/api_client.dart';
import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/models/weather.dart';
import 'package:logging/logging.dart';

final _log = Logger('WeatherRepository');

abstract interface class WeatherRepository {
  /// Throws only [WeatherUnavailableError].
  Future<Weather> fetchWeather(double latitude, double longitude);
}

/// Current weather from Open-Meteo. Any failure at all becomes
/// [WeatherUnavailableError].
class OpenMeteoWeatherRepository implements WeatherRepository {
  OpenMeteoWeatherRepository(this._api);

  final ApiClient _api;

  @override
  Future<Weather> fetchWeather(double latitude, double longitude) async {
    final url = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
    });
    try {
      return decodeWeather(await _api.get(url));
    } on Object catch (e) {
      _log.warning('Weather fetch failed for $latitude,$longitude', e);
      throw const WeatherUnavailableError();
    }
  }
}

/// Throws on any malformed body.
Weather decodeWeather(String body) {
  final json = jsonDecode(body) as Map<String, dynamic>;
  return Weather.fromJson(json['current_weather'] as Map<String, dynamic>);
}
