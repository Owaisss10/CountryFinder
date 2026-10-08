// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Weather {

 double get temperature; double get windspeed; int get weathercode;@JsonKey(name: 'is_day', fromJson: _isDayFromJson) bool get isDay;
/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherCopyWith<Weather> get copyWith => _$WeatherCopyWithImpl<Weather>(this as Weather, _$identity);

  /// Serializes this Weather to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Weather&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.windspeed, windspeed) || other.windspeed == windspeed)&&(identical(other.weathercode, weathercode) || other.weathercode == weathercode)&&(identical(other.isDay, isDay) || other.isDay == isDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temperature,windspeed,weathercode,isDay);

@override
String toString() {
  return 'Weather(temperature: $temperature, windspeed: $windspeed, weathercode: $weathercode, isDay: $isDay)';
}


}

/// @nodoc
abstract mixin class $WeatherCopyWith<$Res>  {
  factory $WeatherCopyWith(Weather value, $Res Function(Weather) _then) = _$WeatherCopyWithImpl;
@useResult
$Res call({
 double temperature, double windspeed, int weathercode,@JsonKey(name: 'is_day', fromJson: _isDayFromJson) bool isDay
});




}
/// @nodoc
class _$WeatherCopyWithImpl<$Res>
    implements $WeatherCopyWith<$Res> {
  _$WeatherCopyWithImpl(this._self, this._then);

  final Weather _self;
  final $Res Function(Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? temperature = null,Object? windspeed = null,Object? weathercode = null,Object? isDay = null,}) {
  return _then(Weather(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,windspeed: null == windspeed ? _self.windspeed : windspeed // ignore: cast_nullable_to_non_nullable
as double,weathercode: null == weathercode ? _self.weathercode : weathercode // ignore: cast_nullable_to_non_nullable
as int,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Weather].
extension WeatherPatterns on Weather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Weather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Weather value)  $default,){
final _that = this;
switch (_that) {
case _Weather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Weather value)?  $default,){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double temperature,  double windspeed,  int weathercode, @JsonKey(name: 'is_day', fromJson: _isDayFromJson)  bool isDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.temperature,_that.windspeed,_that.weathercode,_that.isDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double temperature,  double windspeed,  int weathercode, @JsonKey(name: 'is_day', fromJson: _isDayFromJson)  bool isDay)  $default,) {final _that = this;
switch (_that) {
case _Weather():
return $default(_that.temperature,_that.windspeed,_that.weathercode,_that.isDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double temperature,  double windspeed,  int weathercode, @JsonKey(name: 'is_day', fromJson: _isDayFromJson)  bool isDay)?  $default,) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.temperature,_that.windspeed,_that.weathercode,_that.isDay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Weather extends Weather {
  const _Weather({required this.temperature, required this.windspeed, required this.weathercode, @JsonKey(name: 'is_day', fromJson: _isDayFromJson) required this.isDay}): super._();
  factory _Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

@override final  double temperature;
@override final  double windspeed;
@override final  int weathercode;
@override@JsonKey(name: 'is_day', fromJson: _isDayFromJson) final  bool isDay;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherCopyWith<_Weather> get copyWith => __$WeatherCopyWithImpl<_Weather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Weather&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.windspeed, windspeed) || other.windspeed == windspeed)&&(identical(other.weathercode, weathercode) || other.weathercode == weathercode)&&(identical(other.isDay, isDay) || other.isDay == isDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temperature,windspeed,weathercode,isDay);

@override
String toString() {
  return 'Weather(temperature: $temperature, windspeed: $windspeed, weathercode: $weathercode, isDay: $isDay)';
}


}

/// @nodoc
abstract mixin class _$WeatherCopyWith<$Res> implements $WeatherCopyWith<$Res> {
  factory _$WeatherCopyWith(_Weather value, $Res Function(_Weather) _then) = __$WeatherCopyWithImpl;
@override @useResult
$Res call({
 double temperature, double windspeed, int weathercode,@JsonKey(name: 'is_day', fromJson: _isDayFromJson) bool isDay
});




}
/// @nodoc
class __$WeatherCopyWithImpl<$Res>
    implements _$WeatherCopyWith<$Res> {
  __$WeatherCopyWithImpl(this._self, this._then);

  final _Weather _self;
  final $Res Function(_Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? temperature = null,Object? windspeed = null,Object? weathercode = null,Object? isDay = null,}) {
  return _then(_Weather(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,windspeed: null == windspeed ? _self.windspeed : windspeed // ignore: cast_nullable_to_non_nullable
as double,weathercode: null == weathercode ? _self.weathercode : weathercode // ignore: cast_nullable_to_non_nullable
as int,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
