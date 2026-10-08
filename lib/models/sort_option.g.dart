// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SortOption _$SortOptionFromJson(Map<String, dynamic> json) => _SortOption(
  field: $enumDecode(_$SortFieldEnumMap, json['field']),
  direction: $enumDecode(_$SortDirectionEnumMap, json['direction']),
);

Map<String, dynamic> _$SortOptionToJson(_SortOption instance) =>
    <String, dynamic>{
      'field': _$SortFieldEnumMap[instance.field]!,
      'direction': _$SortDirectionEnumMap[instance.direction]!,
    };

const _$SortFieldEnumMap = {
  SortField.name: 'name',
  SortField.population: 'population',
  SortField.area: 'area',
};

const _$SortDirectionEnumMap = {
  SortDirection.ascending: 'ascending',
  SortDirection.descending: 'descending',
};
