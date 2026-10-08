import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
abstract class Weather with _$Weather {
  const Weather._();

  const factory Weather({
    required double temperature,
    required double windspeed,
    required int weathercode,
    @JsonKey(name: 'is_day', fromJson: _isDayFromJson) required bool isDay,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  WeatherCondition get condition => WeatherCondition.fromCode(weathercode);

  WeatherSymbol get symbol => condition.symbol(isDay: isDay);
}

// Open-Meteo sends is_day as 0/1.
bool _isDayFromJson(Object? value) => switch (value) {
  final num n => n != 0,
  final bool b => b,
  _ => throw const FormatException('is_day must be 0/1'),
};

/// Platform-neutral icon identity; the presentation layer maps it to an
/// actual icon per platform.
enum WeatherSymbol {
  sun,
  moonStars,
  cloudSun,
  cloudMoon,
  cloud,
  fog,
  drizzle,
  rain,
  snow,
  thunderstorm,
  unknown,
}

/// WMO weather interpretation codes, grouped as Open-Meteo documents them.
enum WeatherCondition {
  clearSky,
  mainlyClear,
  partlyCloudy,
  overcast,
  foggy,
  drizzle,
  freezingDrizzle,
  rain,
  freezingRain,
  snowfall,
  snowGrains,
  rainShowers,
  snowShowers,
  thunderstorm,
  thunderstormWithHail,
  unknown;

  static WeatherCondition fromCode(int code) => switch (code) {
    0 => clearSky,
    1 => mainlyClear,
    2 => partlyCloudy,
    3 => overcast,
    45 || 48 => foggy,
    51 || 53 || 55 => drizzle,
    56 || 57 => freezingDrizzle,
    61 || 63 || 65 => rain,
    66 || 67 => freezingRain,
    71 || 73 || 75 => snowfall,
    77 => snowGrains,
    80 || 81 || 82 => rainShowers,
    85 || 86 => snowShowers,
    95 => thunderstorm,
    96 || 99 => thunderstormWithHail,
    _ => unknown,
  };

  WeatherSymbol symbol({required bool isDay}) => switch (this) {
    clearSky ||
    mainlyClear => isDay ? WeatherSymbol.sun : WeatherSymbol.moonStars,
    partlyCloudy => isDay ? WeatherSymbol.cloudSun : WeatherSymbol.cloudMoon,
    overcast => WeatherSymbol.cloud,
    foggy => WeatherSymbol.fog,
    drizzle || freezingDrizzle => WeatherSymbol.drizzle,
    rain || freezingRain || rainShowers => WeatherSymbol.rain,
    snowfall || snowGrains || snowShowers => WeatherSymbol.snow,
    thunderstorm || thunderstormWithHail => WeatherSymbol.thunderstorm,
    unknown => WeatherSymbol.unknown,
  };
}
