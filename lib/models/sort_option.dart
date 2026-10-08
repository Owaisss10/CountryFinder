import 'package:freezed_annotation/freezed_annotation.dart';

part 'sort_option.freezed.dart';
part 'sort_option.g.dart';

enum SortField { name, population, area }

enum SortDirection {
  ascending,
  descending;

  SortDirection get toggled => this == ascending ? descending : ascending;
}

@freezed
abstract class SortOption with _$SortOption {
  const SortOption._();

  const factory SortOption({
    required SortField field,
    required SortDirection direction,
  }) = _SortOption;

  factory SortOption.fromJson(Map<String, dynamic> json) =>
      _$SortOptionFromJson(json);

  static const SortOption defaultOption = SortOption(
    field: SortField.name,
    direction: SortDirection.ascending,
  );

  /// Picking the active field flips its direction; picking another field
  /// switches to it, ascending.
  SortOption selecting(SortField newField) => newField == field
      ? copyWith(direction: direction.toggled)
      : SortOption(field: newField, direction: SortDirection.ascending);
}
