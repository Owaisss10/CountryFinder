// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Currency _$CurrencyFromJson(Map<String, dynamic> json) => _Currency(
  code: json['code'] as String?,
  name: json['name'] as String?,
  symbol: json['symbol'] as String?,
);

Map<String, dynamic> _$CurrencyToJson(_Currency instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'symbol': instance.symbol,
};

_Language _$LanguageFromJson(Map<String, dynamic> json) =>
    _Language(name: json['name'] as String);

Map<String, dynamic> _$LanguageToJson(_Language instance) => <String, dynamic>{
  'name': instance.name,
};

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
  name: json['name'] as String,
  nativeName: json['nativeName'] as String?,
  altSpellings: (json['altSpellings'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  capital: json['capital'] as String?,
  region: json['region'] as String,
  subregion: json['subregion'] as String?,
  population: (json['population'] as num?)?.toInt(),
  area: (json['area'] as num?)?.toDouble(),
  currencies: (json['currencies'] as List<dynamic>?)
      ?.map((e) => Currency.fromJson(e as Map<String, dynamic>))
      .toList(),
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
      .toList(),
  alpha2Code: json['alpha2Code'] as String,
  alpha3Code: json['alpha3Code'] as String,
  borders: (json['borders'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  flagPng: _uriOrNull(_readFlagPng(json, 'flagPng')),
  flagSvg: _uriOrNull(_readFlagSvg(json, 'flagSvg')),
  populationDensity: (json['populationDensity'] as num?)?.toDouble(),
  callingCodes: (json['callingCodes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  timezones: (json['timezones'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  latlng: (json['latlng'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
  'name': instance.name,
  'nativeName': instance.nativeName,
  'altSpellings': instance.altSpellings,
  'capital': instance.capital,
  'region': instance.region,
  'subregion': instance.subregion,
  'population': instance.population,
  'area': instance.area,
  'currencies': instance.currencies,
  'languages': instance.languages,
  'alpha2Code': instance.alpha2Code,
  'alpha3Code': instance.alpha3Code,
  'borders': instance.borders,
  'flagPng': instance.flagPng?.toString(),
  'flagSvg': instance.flagSvg?.toString(),
  'populationDensity': instance.populationDensity,
  'callingCodes': instance.callingCodes,
  'timezones': instance.timezones,
  'latlng': instance.latlng,
};
