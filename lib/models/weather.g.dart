// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Weather _$WeatherFromJson(Map<String, dynamic> json) => _Weather(
  temperature: (json['temperature'] as num).toDouble(),
  windspeed: (json['windspeed'] as num).toDouble(),
  weathercode: (json['weathercode'] as num).toInt(),
  isDay: _isDayFromJson(json['is_day']),
);

Map<String, dynamic> _$WeatherToJson(_Weather instance) => <String, dynamic>{
  'temperature': instance.temperature,
  'windspeed': instance.windspeed,
  'weathercode': instance.weathercode,
  'is_day': instance.isDay,
};
