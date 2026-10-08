import 'package:country_finder/core/api_client.dart';
import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../support/fixtures.dart';

void main() {
  Map<String, dynamic> body({Object isDay = 1}) => {
    'current_weather': {
      'temperature': 21.3,
      'windspeed': 9.4,
      'weathercode': 2,
      'is_day': isDay,
    },
  };

  OpenMeteoWeatherRepository repo(
    http.Response Function(http.Request) respond, {
    List<http.Request>? log,
  }) => OpenMeteoWeatherRepository(ApiClient(fakeHttp(respond, log: log)));

  test('decodes current weather and sends the right query', () async {
    final requests = <http.Request>[];
    final weather = await repo(
      (_) => jsonResponse(body()),
      log: requests,
    ).fetchWeather(48.8, 2.3);
    expect(weather, sampleWeather);
    final url = requests.single.url;
    expect(url.host, 'api.open-meteo.com');
    expect(url.path, '/v1/forecast');
    expect(url.queryParameters, {
      'latitude': '48.8',
      'longitude': '2.3',
      'current_weather': 'true',
    });
  });

  test('is_day 0 decodes as night', () async {
    final weather = await repo(
      (_) => jsonResponse(body(isDay: 0)),
    ).fetchWeather(0, 0);
    expect(weather.isDay, isFalse);
  });

  final failures = <String, http.Response Function(http.Request)>{
    'transport': offline,
    'non-2xx': (_) => jsonResponse(body(), status: 500),
    'rate limited': (_) => jsonResponse(body(), status: 429),
    'bad json': (_) => jsonResponse('nope'),
    'missing current_weather': (_) => jsonResponse({'other': 1}),
    'bad is_day': (_) => jsonResponse(body(isDay: 'yes')),
  };
  failures.forEach((name, respond) {
    test('$name → weatherUnavailable', () {
      expect(
        repo(respond).fetchWeather(1, 1),
        throwsA(const WeatherUnavailableError()),
      );
    });
  });
}
