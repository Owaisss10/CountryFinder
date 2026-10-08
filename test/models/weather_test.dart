import 'package:country_finder/models/weather.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WMO weather codes', () {
    final table = <List<int>, WeatherCondition>{
      [0]: WeatherCondition.clearSky,
      [1]: WeatherCondition.mainlyClear,
      [2]: WeatherCondition.partlyCloudy,
      [3]: WeatherCondition.overcast,
      [45, 48]: WeatherCondition.foggy,
      [51, 53, 55]: WeatherCondition.drizzle,
      [56, 57]: WeatherCondition.freezingDrizzle,
      [61, 63, 65]: WeatherCondition.rain,
      [66, 67]: WeatherCondition.freezingRain,
      [71, 73, 75]: WeatherCondition.snowfall,
      [77]: WeatherCondition.snowGrains,
      [80, 81, 82]: WeatherCondition.rainShowers,
      [85, 86]: WeatherCondition.snowShowers,
      [95]: WeatherCondition.thunderstorm,
      [96, 99]: WeatherCondition.thunderstormWithHail,
      [4, 100, -1]: WeatherCondition.unknown,
    };
    table.forEach((codes, condition) {
      test('$codes → $condition', () {
        for (final code in codes) {
          expect(WeatherCondition.fromCode(code), condition);
        }
      });
    });
  });

  test('day and night symbols', () {
    expect(WeatherCondition.clearSky.symbol(isDay: true), WeatherSymbol.sun);
    expect(
      WeatherCondition.mainlyClear.symbol(isDay: false),
      WeatherSymbol.moonStars,
    );
    expect(
      WeatherCondition.partlyCloudy.symbol(isDay: true),
      WeatherSymbol.cloudSun,
    );
    expect(
      WeatherCondition.partlyCloudy.symbol(isDay: false),
      WeatherSymbol.cloudMoon,
    );
    expect(WeatherCondition.overcast.symbol(isDay: false), WeatherSymbol.cloud);
    expect(WeatherCondition.unknown.symbol(isDay: true), WeatherSymbol.unknown);
  });

  test('is_day 0/1 decodes to a bool', () {
    Weather decode(Object isDay) => Weather.fromJson({
      'temperature': 1.0,
      'windspeed': 2.0,
      'weathercode': 0,
      'is_day': isDay,
    });
    expect(decode(1).isDay, isTrue);
    expect(decode(0).isDay, isFalse);
    expect(() => decode('yes'), throwsFormatException);
  });
}
