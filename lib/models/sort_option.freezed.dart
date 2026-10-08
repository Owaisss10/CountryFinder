// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SortOption {

 SortField get field; SortDirection get direction;
/// Create a copy of SortOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SortOptionCopyWith<SortOption> get copyWith => _$SortOptionCopyWithImpl<SortOption>(this as SortOption, _$identity);

  /// Serializes this SortOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SortOption&&(identical(other.field, field) || other.field == field)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,direction);

@override
String toString() {
  return 'SortOption(field: $field, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $SortOptionCopyWith<$Res>  {
  factory $SortOptionCopyWith(SortOption value, $Res Function(SortOption) _then) = _$SortOptionCopyWithImpl;
@useResult
$Res call({
 SortField field, SortDirection direction
});




}
/// @nodoc
class _$SortOptionCopyWithImpl<$Res>
    implements $SortOptionCopyWith<$Res> {
  _$SortOptionCopyWithImpl(this._self, this._then);

  final SortOption _self;
  final $Res Function(SortOption) _then;

/// Create a copy of SortOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? direction = null,}) {
  return _then(SortOption(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as SortField,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [SortOption].
extension SortOptionPatterns on SortOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SortOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SortOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SortOption value)  $default,){
final _that = this;
switch (_that) {
case _SortOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SortOption value)?  $default,){
final _that = this;
switch (_that) {
case _SortOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SortField field,  SortDirection direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SortOption() when $default != null:
return $default(_that.field,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SortField field,  SortDirection direction)  $default,) {final _that = this;
switch (_that) {
case _SortOption():
return $default(_that.field,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SortField field,  SortDirection direction)?  $default,) {final _that = this;
switch (_that) {
case _SortOption() when $default != null:
return $default(_that.field,_that.direction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SortOption extends SortOption {
  const _SortOption({required this.field, required this.direction}): super._();
  factory _SortOption.fromJson(Map<String, dynamic> json) => _$SortOptionFromJson(json);

@override final  SortField field;
@override final  SortDirection direction;

/// Create a copy of SortOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SortOptionCopyWith<_SortOption> get copyWith => __$SortOptionCopyWithImpl<_SortOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SortOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SortOption&&(identical(other.field, field) || other.field == field)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,direction);

@override
String toString() {
  return 'SortOption(field: $field, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$SortOptionCopyWith<$Res> implements $SortOptionCopyWith<$Res> {
  factory _$SortOptionCopyWith(_SortOption value, $Res Function(_SortOption) _then) = __$SortOptionCopyWithImpl;
@override @useResult
$Res call({
 SortField field, SortDirection direction
});




}
/// @nodoc
class __$SortOptionCopyWithImpl<$Res>
    implements _$SortOptionCopyWith<$Res> {
  __$SortOptionCopyWithImpl(this._self, this._then);

  final _SortOption _self;
  final $Res Function(_SortOption) _then;

/// Create a copy of SortOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? direction = null,}) {
  return _then(_SortOption(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as SortField,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}


}

// dart format on
