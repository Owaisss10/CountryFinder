import 'package:country_finder/shared/search_folding.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
abstract class Currency with _$Currency {
  const factory Currency({String? code, String? name, String? symbol}) =
      _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
}

@freezed
abstract class Language with _$Language {
  const factory Language({required String name}) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}

@freezed
abstract class Country with _$Country {
  const Country._();

  const factory Country({
    required String name,
    // Some countries' commonly searched name only appears here, e.g. Ivory
    // Coast's nativeName is "Côte d'Ivoire", Turkey's is "Türkiye".
    String? nativeName,
    List<String>? altSpellings,
    String? capital,
    required String region,
    String? subregion,
    int? population,
    double? area,
    List<Currency>? currencies,
    List<Language>? languages,
    required String alpha2Code,
    required String alpha3Code,
    // The key is absent on about a third of records; absent and empty both
    // mean "no land borders".
    List<String>? borders,
    @JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull) Uri? flagPng,
    @JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull) Uri? flagSvg,
    double? populationDensity,
    List<String>? callingCodes,
    List<String>? timezones,
    // [latitude, longitude], in the API's own order.
    List<double>? latlng,
  }) = _Country;

  /// Throws if a required field is missing or has the wrong type; callers
  /// decoding a list skip such records.
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  String get id => alpha3Code;

  /// [latlng] as a named pair, or null unless it holds exactly two values.
  ({double latitude, double longitude})? get coordinates => switch (latlng) {
    [final latitude, final longitude] => (
      latitude: latitude,
      longitude: longitude,
    ),
    _ => null,
  };

  bool matches(String query) {
    if (query.isEmpty) return true;
    // Folded once and reused for every field below.
    final folded = foldForSearch(query);
    if (foldForSearch(name).contains(folded)) return true;
    final native = nativeName;
    if (native != null && foldForSearch(native).contains(folded)) return true;
    return altSpellings?.any((s) => foldForSearch(s).contains(folded)) ?? false;
  }
}

// `flags` may be missing, not an object, or hold non-string values; all of
// those decode to a null URL rather than failing the record.
Object? _readFlagPng(Map<dynamic, dynamic> json, String key) =>
    _readFlag(json, 'png');

Object? _readFlagSvg(Map<dynamic, dynamic> json, String key) =>
    _readFlag(json, 'svg');

Object? _readFlag(Map<dynamic, dynamic> json, String variant) {
  final flags = json['flags'];
  if (flags is! Map) return null;
  final value = flags[variant];
  return value is String ? value : null;
}

Uri? _uriOrNull(Object? value) =>
    value is String && value.isNotEmpty ? Uri.tryParse(value) : null;
