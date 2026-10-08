// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'countries_list_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CountriesListState {

 ViewState get viewState; List<Country> get countries; bool get isOffline; DateTime? get cacheDate; SortOption get sortOption;
/// Create a copy of CountriesListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountriesListStateCopyWith<CountriesListState> get copyWith => _$CountriesListStateCopyWithImpl<CountriesListState>(this as CountriesListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountriesListState&&(identical(other.viewState, viewState) || other.viewState == viewState)&&const DeepCollectionEquality().equals(other.countries, countries)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.cacheDate, cacheDate) || other.cacheDate == cacheDate)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption));
}


@override
int get hashCode => Object.hash(runtimeType,viewState,const DeepCollectionEquality().hash(countries),isOffline,cacheDate,sortOption);

@override
String toString() {
  return 'CountriesListState(viewState: $viewState, countries: $countries, isOffline: $isOffline, cacheDate: $cacheDate, sortOption: $sortOption)';
}


}

/// @nodoc
abstract mixin class $CountriesListStateCopyWith<$Res>  {
  factory $CountriesListStateCopyWith(CountriesListState value, $Res Function(CountriesListState) _then) = _$CountriesListStateCopyWithImpl;
@useResult
$Res call({
 ViewState viewState, List<Country> countries, bool isOffline, DateTime? cacheDate, SortOption sortOption
});


$SortOptionCopyWith<$Res> get sortOption;

}
/// @nodoc
class _$CountriesListStateCopyWithImpl<$Res>
    implements $CountriesListStateCopyWith<$Res> {
  _$CountriesListStateCopyWithImpl(this._self, this._then);

  final CountriesListState _self;
  final $Res Function(CountriesListState) _then;

/// Create a copy of CountriesListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? viewState = null,Object? countries = null,Object? isOffline = null,Object? cacheDate = freezed,Object? sortOption = null,}) {
  return _then(CountriesListState(
viewState: null == viewState ? _self.viewState : viewState // ignore: cast_nullable_to_non_nullable
as ViewState,countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,cacheDate: freezed == cacheDate ? _self.cacheDate : cacheDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sortOption: null == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as SortOption,
  ));
}
/// Create a copy of CountriesListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SortOptionCopyWith<$Res> get sortOption {
  
  return $SortOptionCopyWith<$Res>(_self.sortOption, (value) {
    return _then(_self.copyWith(sortOption: value));
  });
}
}


/// Adds pattern-matching-related methods to [CountriesListState].
extension CountriesListStatePatterns on CountriesListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CountriesListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CountriesListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CountriesListState value)  $default,){
final _that = this;
switch (_that) {
case _CountriesListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CountriesListState value)?  $default,){
final _that = this;
switch (_that) {
case _CountriesListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ViewState viewState,  List<Country> countries,  bool isOffline,  DateTime? cacheDate,  SortOption sortOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CountriesListState() when $default != null:
return $default(_that.viewState,_that.countries,_that.isOffline,_that.cacheDate,_that.sortOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ViewState viewState,  List<Country> countries,  bool isOffline,  DateTime? cacheDate,  SortOption sortOption)  $default,) {final _that = this;
switch (_that) {
case _CountriesListState():
return $default(_that.viewState,_that.countries,_that.isOffline,_that.cacheDate,_that.sortOption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ViewState viewState,  List<Country> countries,  bool isOffline,  DateTime? cacheDate,  SortOption sortOption)?  $default,) {final _that = this;
switch (_that) {
case _CountriesListState() when $default != null:
return $default(_that.viewState,_that.countries,_that.isOffline,_that.cacheDate,_that.sortOption);case _:
  return null;

}
}

}

/// @nodoc


class _CountriesListState implements CountriesListState {
  const _CountriesListState({required this.viewState, required  List<Country> countries, required this.isOffline, this.cacheDate, required this.sortOption}): _countries = countries;
  

@override final  ViewState viewState;
 final  List<Country> _countries;
@override List<Country> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

@override final  bool isOffline;
@override final  DateTime? cacheDate;
@override final  SortOption sortOption;

/// Create a copy of CountriesListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountriesListStateCopyWith<_CountriesListState> get copyWith => __$CountriesListStateCopyWithImpl<_CountriesListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountriesListState&&(identical(other.viewState, viewState) || other.viewState == viewState)&&const DeepCollectionEquality().equals(other._countries, _countries)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.cacheDate, cacheDate) || other.cacheDate == cacheDate)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption));
}


@override
int get hashCode => Object.hash(runtimeType,viewState,const DeepCollectionEquality().hash(_countries),isOffline,cacheDate,sortOption);

@override
String toString() {
  return 'CountriesListState(viewState: $viewState, countries: $countries, isOffline: $isOffline, cacheDate: $cacheDate, sortOption: $sortOption)';
}


}

/// @nodoc
abstract mixin class _$CountriesListStateCopyWith<$Res> implements $CountriesListStateCopyWith<$Res> {
  factory _$CountriesListStateCopyWith(_CountriesListState value, $Res Function(_CountriesListState) _then) = __$CountriesListStateCopyWithImpl;
@override @useResult
$Res call({
 ViewState viewState, List<Country> countries, bool isOffline, DateTime? cacheDate, SortOption sortOption
});


@override $SortOptionCopyWith<$Res> get sortOption;

}
/// @nodoc
class __$CountriesListStateCopyWithImpl<$Res>
    implements _$CountriesListStateCopyWith<$Res> {
  __$CountriesListStateCopyWithImpl(this._self, this._then);

  final _CountriesListState _self;
  final $Res Function(_CountriesListState) _then;

/// Create a copy of CountriesListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? viewState = null,Object? countries = null,Object? isOffline = null,Object? cacheDate = freezed,Object? sortOption = null,}) {
  return _then(_CountriesListState(
viewState: null == viewState ? _self.viewState : viewState // ignore: cast_nullable_to_non_nullable
as ViewState,countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,cacheDate: freezed == cacheDate ? _self.cacheDate : cacheDate // ignore: cast_nullable_to_non_nullable
as DateTime?,sortOption: null == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as SortOption,
  ));
}

/// Create a copy of CountriesListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SortOptionCopyWith<$Res> get sortOption {
  
  return $SortOptionCopyWith<$Res>(_self.sortOption, (value) {
    return _then(_self.copyWith(sortOption: value));
  });
}
}

// dart format on
