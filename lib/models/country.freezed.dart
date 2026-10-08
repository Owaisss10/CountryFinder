// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Currency {

 String? get code; String? get name; String? get symbol;
/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyCopyWith<Currency> get copyWith => _$CurrencyCopyWithImpl<Currency>(this as Currency, _$identity);

  /// Serializes this Currency to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Currency&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,symbol);

@override
String toString() {
  return 'Currency(code: $code, name: $name, symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class $CurrencyCopyWith<$Res>  {
  factory $CurrencyCopyWith(Currency value, $Res Function(Currency) _then) = _$CurrencyCopyWithImpl;
@useResult
$Res call({
 String? code, String? name, String? symbol
});




}
/// @nodoc
class _$CurrencyCopyWithImpl<$Res>
    implements $CurrencyCopyWith<$Res> {
  _$CurrencyCopyWithImpl(this._self, this._then);

  final Currency _self;
  final $Res Function(Currency) _then;

/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,Object? symbol = freezed,}) {
  return _then(Currency(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Currency].
extension CurrencyPatterns on Currency {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Currency value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Currency() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Currency value)  $default,){
final _that = this;
switch (_that) {
case _Currency():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Currency value)?  $default,){
final _that = this;
switch (_that) {
case _Currency() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? code,  String? name,  String? symbol)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Currency() when $default != null:
return $default(_that.code,_that.name,_that.symbol);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? code,  String? name,  String? symbol)  $default,) {final _that = this;
switch (_that) {
case _Currency():
return $default(_that.code,_that.name,_that.symbol);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? code,  String? name,  String? symbol)?  $default,) {final _that = this;
switch (_that) {
case _Currency() when $default != null:
return $default(_that.code,_that.name,_that.symbol);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Currency implements Currency {
  const _Currency({this.code, this.name, this.symbol});
  factory _Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);

@override final  String? code;
@override final  String? name;
@override final  String? symbol;

/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyCopyWith<_Currency> get copyWith => __$CurrencyCopyWithImpl<_Currency>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrencyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Currency&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,symbol);

@override
String toString() {
  return 'Currency(code: $code, name: $name, symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class _$CurrencyCopyWith<$Res> implements $CurrencyCopyWith<$Res> {
  factory _$CurrencyCopyWith(_Currency value, $Res Function(_Currency) _then) = __$CurrencyCopyWithImpl;
@override @useResult
$Res call({
 String? code, String? name, String? symbol
});




}
/// @nodoc
class __$CurrencyCopyWithImpl<$Res>
    implements _$CurrencyCopyWith<$Res> {
  __$CurrencyCopyWithImpl(this._self, this._then);

  final _Currency _self;
  final $Res Function(_Currency) _then;

/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,Object? symbol = freezed,}) {
  return _then(_Currency(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Language {

 String get name;
/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageCopyWith<Language> get copyWith => _$LanguageCopyWithImpl<Language>(this as Language, _$identity);

  /// Serializes this Language to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Language&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'Language(name: $name)';
}


}

/// @nodoc
abstract mixin class $LanguageCopyWith<$Res>  {
  factory $LanguageCopyWith(Language value, $Res Function(Language) _then) = _$LanguageCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$LanguageCopyWithImpl<$Res>
    implements $LanguageCopyWith<$Res> {
  _$LanguageCopyWithImpl(this._self, this._then);

  final Language _self;
  final $Res Function(Language) _then;

/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(Language(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Language].
extension LanguagePatterns on Language {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Language value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Language() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Language value)  $default,){
final _that = this;
switch (_that) {
case _Language():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Language value)?  $default,){
final _that = this;
switch (_that) {
case _Language() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Language() when $default != null:
return $default(_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _Language():
return $default(_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _Language() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Language implements Language {
  const _Language({required this.name});
  factory _Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

@override final  String name;

/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageCopyWith<_Language> get copyWith => __$LanguageCopyWithImpl<_Language>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanguageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Language&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'Language(name: $name)';
}


}

/// @nodoc
abstract mixin class _$LanguageCopyWith<$Res> implements $LanguageCopyWith<$Res> {
  factory _$LanguageCopyWith(_Language value, $Res Function(_Language) _then) = __$LanguageCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$LanguageCopyWithImpl<$Res>
    implements _$LanguageCopyWith<$Res> {
  __$LanguageCopyWithImpl(this._self, this._then);

  final _Language _self;
  final $Res Function(_Language) _then;

/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_Language(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Country {

 String get name; String? get nativeName; List<String>? get altSpellings; String? get capital; String get region; String? get subregion; int? get population; double? get area; List<Currency>? get currencies; List<Language>? get languages; String get alpha2Code; String get alpha3Code; List<String>? get borders;@JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull) Uri? get flagPng;@JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull) Uri? get flagSvg; double? get populationDensity; List<String>? get callingCodes; List<String>? get timezones; List<double>? get latlng;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.name, name) || other.name == name)&&(identical(other.nativeName, nativeName) || other.nativeName == nativeName)&&const DeepCollectionEquality().equals(other.altSpellings, altSpellings)&&(identical(other.capital, capital) || other.capital == capital)&&(identical(other.region, region) || other.region == region)&&(identical(other.subregion, subregion) || other.subregion == subregion)&&(identical(other.population, population) || other.population == population)&&(identical(other.area, area) || other.area == area)&&const DeepCollectionEquality().equals(other.currencies, currencies)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.alpha2Code, alpha2Code) || other.alpha2Code == alpha2Code)&&(identical(other.alpha3Code, alpha3Code) || other.alpha3Code == alpha3Code)&&const DeepCollectionEquality().equals(other.borders, borders)&&(identical(other.flagPng, flagPng) || other.flagPng == flagPng)&&(identical(other.flagSvg, flagSvg) || other.flagSvg == flagSvg)&&(identical(other.populationDensity, populationDensity) || other.populationDensity == populationDensity)&&const DeepCollectionEquality().equals(other.callingCodes, callingCodes)&&const DeepCollectionEquality().equals(other.timezones, timezones)&&const DeepCollectionEquality().equals(other.latlng, latlng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,nativeName,const DeepCollectionEquality().hash(altSpellings),capital,region,subregion,population,area,const DeepCollectionEquality().hash(currencies),const DeepCollectionEquality().hash(languages),alpha2Code,alpha3Code,const DeepCollectionEquality().hash(borders),flagPng,flagSvg,populationDensity,const DeepCollectionEquality().hash(callingCodes),const DeepCollectionEquality().hash(timezones),const DeepCollectionEquality().hash(latlng)]);

@override
String toString() {
  return 'Country(name: $name, nativeName: $nativeName, altSpellings: $altSpellings, capital: $capital, region: $region, subregion: $subregion, population: $population, area: $area, currencies: $currencies, languages: $languages, alpha2Code: $alpha2Code, alpha3Code: $alpha3Code, borders: $borders, flagPng: $flagPng, flagSvg: $flagSvg, populationDensity: $populationDensity, callingCodes: $callingCodes, timezones: $timezones, latlng: $latlng)';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
 String name, String? nativeName, List<String>? altSpellings, String? capital, String region, String? subregion, int? population, double? area, List<Currency>? currencies, List<Language>? languages, String alpha2Code, String alpha3Code, List<String>? borders,@JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull) Uri? flagPng,@JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull) Uri? flagSvg, double? populationDensity, List<String>? callingCodes, List<String>? timezones, List<double>? latlng
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? nativeName = freezed,Object? altSpellings = freezed,Object? capital = freezed,Object? region = null,Object? subregion = freezed,Object? population = freezed,Object? area = freezed,Object? currencies = freezed,Object? languages = freezed,Object? alpha2Code = null,Object? alpha3Code = null,Object? borders = freezed,Object? flagPng = freezed,Object? flagSvg = freezed,Object? populationDensity = freezed,Object? callingCodes = freezed,Object? timezones = freezed,Object? latlng = freezed,}) {
  return _then(Country(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nativeName: freezed == nativeName ? _self.nativeName : nativeName // ignore: cast_nullable_to_non_nullable
as String?,altSpellings: freezed == altSpellings ? _self.altSpellings : altSpellings // ignore: cast_nullable_to_non_nullable
as List<String>?,capital: freezed == capital ? _self.capital : capital // ignore: cast_nullable_to_non_nullable
as String?,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,subregion: freezed == subregion ? _self.subregion : subregion // ignore: cast_nullable_to_non_nullable
as String?,population: freezed == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double?,currencies: freezed == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>?,alpha2Code: null == alpha2Code ? _self.alpha2Code : alpha2Code // ignore: cast_nullable_to_non_nullable
as String,alpha3Code: null == alpha3Code ? _self.alpha3Code : alpha3Code // ignore: cast_nullable_to_non_nullable
as String,borders: freezed == borders ? _self.borders : borders // ignore: cast_nullable_to_non_nullable
as List<String>?,flagPng: freezed == flagPng ? _self.flagPng : flagPng // ignore: cast_nullable_to_non_nullable
as Uri?,flagSvg: freezed == flagSvg ? _self.flagSvg : flagSvg // ignore: cast_nullable_to_non_nullable
as Uri?,populationDensity: freezed == populationDensity ? _self.populationDensity : populationDensity // ignore: cast_nullable_to_non_nullable
as double?,callingCodes: freezed == callingCodes ? _self.callingCodes : callingCodes // ignore: cast_nullable_to_non_nullable
as List<String>?,timezones: freezed == timezones ? _self.timezones : timezones // ignore: cast_nullable_to_non_nullable
as List<String>?,latlng: freezed == latlng ? _self.latlng : latlng // ignore: cast_nullable_to_non_nullable
as List<double>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Country].
extension CountryPatterns on Country {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Country value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Country value)  $default,){
final _that = this;
switch (_that) {
case _Country():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Country value)?  $default,){
final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? nativeName,  List<String>? altSpellings,  String? capital,  String region,  String? subregion,  int? population,  double? area,  List<Currency>? currencies,  List<Language>? languages,  String alpha2Code,  String alpha3Code,  List<String>? borders, @JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull)  Uri? flagPng, @JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull)  Uri? flagSvg,  double? populationDensity,  List<String>? callingCodes,  List<String>? timezones,  List<double>? latlng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.name,_that.nativeName,_that.altSpellings,_that.capital,_that.region,_that.subregion,_that.population,_that.area,_that.currencies,_that.languages,_that.alpha2Code,_that.alpha3Code,_that.borders,_that.flagPng,_that.flagSvg,_that.populationDensity,_that.callingCodes,_that.timezones,_that.latlng);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? nativeName,  List<String>? altSpellings,  String? capital,  String region,  String? subregion,  int? population,  double? area,  List<Currency>? currencies,  List<Language>? languages,  String alpha2Code,  String alpha3Code,  List<String>? borders, @JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull)  Uri? flagPng, @JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull)  Uri? flagSvg,  double? populationDensity,  List<String>? callingCodes,  List<String>? timezones,  List<double>? latlng)  $default,) {final _that = this;
switch (_that) {
case _Country():
return $default(_that.name,_that.nativeName,_that.altSpellings,_that.capital,_that.region,_that.subregion,_that.population,_that.area,_that.currencies,_that.languages,_that.alpha2Code,_that.alpha3Code,_that.borders,_that.flagPng,_that.flagSvg,_that.populationDensity,_that.callingCodes,_that.timezones,_that.latlng);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? nativeName,  List<String>? altSpellings,  String? capital,  String region,  String? subregion,  int? population,  double? area,  List<Currency>? currencies,  List<Language>? languages,  String alpha2Code,  String alpha3Code,  List<String>? borders, @JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull)  Uri? flagPng, @JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull)  Uri? flagSvg,  double? populationDensity,  List<String>? callingCodes,  List<String>? timezones,  List<double>? latlng)?  $default,) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.name,_that.nativeName,_that.altSpellings,_that.capital,_that.region,_that.subregion,_that.population,_that.area,_that.currencies,_that.languages,_that.alpha2Code,_that.alpha3Code,_that.borders,_that.flagPng,_that.flagSvg,_that.populationDensity,_that.callingCodes,_that.timezones,_that.latlng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Country extends Country {
  const _Country({required this.name, this.nativeName,  List<String>? altSpellings, this.capital, required this.region, this.subregion, this.population, this.area,  List<Currency>? currencies,  List<Language>? languages, required this.alpha2Code, required this.alpha3Code,  List<String>? borders, @JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull) this.flagPng, @JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull) this.flagSvg, this.populationDensity,  List<String>? callingCodes,  List<String>? timezones,  List<double>? latlng}): _altSpellings = altSpellings,_currencies = currencies,_languages = languages,_borders = borders,_callingCodes = callingCodes,_timezones = timezones,_latlng = latlng,super._();
  factory _Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

@override final  String name;
@override final  String? nativeName;
 final  List<String>? _altSpellings;
@override List<String>? get altSpellings {
  final value = _altSpellings;
  if (value == null) return null;
  if (_altSpellings is EqualUnmodifiableListView) return _altSpellings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? capital;
@override final  String region;
@override final  String? subregion;
@override final  int? population;
@override final  double? area;
 final  List<Currency>? _currencies;
@override List<Currency>? get currencies {
  final value = _currencies;
  if (value == null) return null;
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Language>? _languages;
@override List<Language>? get languages {
  final value = _languages;
  if (value == null) return null;
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String alpha2Code;
@override final  String alpha3Code;
 final  List<String>? _borders;
@override List<String>? get borders {
  final value = _borders;
  if (value == null) return null;
  if (_borders is EqualUnmodifiableListView) return _borders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull) final  Uri? flagPng;
@override@JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull) final  Uri? flagSvg;
@override final  double? populationDensity;
 final  List<String>? _callingCodes;
@override List<String>? get callingCodes {
  final value = _callingCodes;
  if (value == null) return null;
  if (_callingCodes is EqualUnmodifiableListView) return _callingCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _timezones;
@override List<String>? get timezones {
  final value = _timezones;
  if (value == null) return null;
  if (_timezones is EqualUnmodifiableListView) return _timezones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<double>? _latlng;
@override List<double>? get latlng {
  final value = _latlng;
  if (value == null) return null;
  if (_latlng is EqualUnmodifiableListView) return _latlng;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.name, name) || other.name == name)&&(identical(other.nativeName, nativeName) || other.nativeName == nativeName)&&const DeepCollectionEquality().equals(other._altSpellings, _altSpellings)&&(identical(other.capital, capital) || other.capital == capital)&&(identical(other.region, region) || other.region == region)&&(identical(other.subregion, subregion) || other.subregion == subregion)&&(identical(other.population, population) || other.population == population)&&(identical(other.area, area) || other.area == area)&&const DeepCollectionEquality().equals(other._currencies, _currencies)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.alpha2Code, alpha2Code) || other.alpha2Code == alpha2Code)&&(identical(other.alpha3Code, alpha3Code) || other.alpha3Code == alpha3Code)&&const DeepCollectionEquality().equals(other._borders, _borders)&&(identical(other.flagPng, flagPng) || other.flagPng == flagPng)&&(identical(other.flagSvg, flagSvg) || other.flagSvg == flagSvg)&&(identical(other.populationDensity, populationDensity) || other.populationDensity == populationDensity)&&const DeepCollectionEquality().equals(other._callingCodes, _callingCodes)&&const DeepCollectionEquality().equals(other._timezones, _timezones)&&const DeepCollectionEquality().equals(other._latlng, _latlng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,nativeName,const DeepCollectionEquality().hash(_altSpellings),capital,region,subregion,population,area,const DeepCollectionEquality().hash(_currencies),const DeepCollectionEquality().hash(_languages),alpha2Code,alpha3Code,const DeepCollectionEquality().hash(_borders),flagPng,flagSvg,populationDensity,const DeepCollectionEquality().hash(_callingCodes),const DeepCollectionEquality().hash(_timezones),const DeepCollectionEquality().hash(_latlng)]);

@override
String toString() {
  return 'Country(name: $name, nativeName: $nativeName, altSpellings: $altSpellings, capital: $capital, region: $region, subregion: $subregion, population: $population, area: $area, currencies: $currencies, languages: $languages, alpha2Code: $alpha2Code, alpha3Code: $alpha3Code, borders: $borders, flagPng: $flagPng, flagSvg: $flagSvg, populationDensity: $populationDensity, callingCodes: $callingCodes, timezones: $timezones, latlng: $latlng)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
 String name, String? nativeName, List<String>? altSpellings, String? capital, String region, String? subregion, int? population, double? area, List<Currency>? currencies, List<Language>? languages, String alpha2Code, String alpha3Code, List<String>? borders,@JsonKey(readValue: _readFlagPng, fromJson: _uriOrNull) Uri? flagPng,@JsonKey(readValue: _readFlagSvg, fromJson: _uriOrNull) Uri? flagSvg, double? populationDensity, List<String>? callingCodes, List<String>? timezones, List<double>? latlng
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? nativeName = freezed,Object? altSpellings = freezed,Object? capital = freezed,Object? region = null,Object? subregion = freezed,Object? population = freezed,Object? area = freezed,Object? currencies = freezed,Object? languages = freezed,Object? alpha2Code = null,Object? alpha3Code = null,Object? borders = freezed,Object? flagPng = freezed,Object? flagSvg = freezed,Object? populationDensity = freezed,Object? callingCodes = freezed,Object? timezones = freezed,Object? latlng = freezed,}) {
  return _then(_Country(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nativeName: freezed == nativeName ? _self.nativeName : nativeName // ignore: cast_nullable_to_non_nullable
as String?,altSpellings: freezed == altSpellings ? _self._altSpellings : altSpellings // ignore: cast_nullable_to_non_nullable
as List<String>?,capital: freezed == capital ? _self.capital : capital // ignore: cast_nullable_to_non_nullable
as String?,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,subregion: freezed == subregion ? _self.subregion : subregion // ignore: cast_nullable_to_non_nullable
as String?,population: freezed == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double?,currencies: freezed == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>?,languages: freezed == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>?,alpha2Code: null == alpha2Code ? _self.alpha2Code : alpha2Code // ignore: cast_nullable_to_non_nullable
as String,alpha3Code: null == alpha3Code ? _self.alpha3Code : alpha3Code // ignore: cast_nullable_to_non_nullable
as String,borders: freezed == borders ? _self._borders : borders // ignore: cast_nullable_to_non_nullable
as List<String>?,flagPng: freezed == flagPng ? _self.flagPng : flagPng // ignore: cast_nullable_to_non_nullable
as Uri?,flagSvg: freezed == flagSvg ? _self.flagSvg : flagSvg // ignore: cast_nullable_to_non_nullable
as Uri?,populationDensity: freezed == populationDensity ? _self.populationDensity : populationDensity // ignore: cast_nullable_to_non_nullable
as double?,callingCodes: freezed == callingCodes ? _self._callingCodes : callingCodes // ignore: cast_nullable_to_non_nullable
as List<String>?,timezones: freezed == timezones ? _self._timezones : timezones // ignore: cast_nullable_to_non_nullable
as List<String>?,latlng: freezed == latlng ? _self._latlng : latlng // ignore: cast_nullable_to_non_nullable
as List<double>?,
  ));
}


}

// dart format on
