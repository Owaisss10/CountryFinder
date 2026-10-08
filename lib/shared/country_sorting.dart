import 'package:collection/collection.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/shared/search_folding.dart';

/// Natural, case- and accent-insensitive name order: "Åland Islands" sorts
/// with the A's and "Country 2" before "Country 10".
List<Country> sortedByName(Iterable<Country> countries) {
  // Fold each name once up front instead of on every comparison.
  final keyed = [for (final c in countries) (c, foldForSearch(c.name))];
  mergeSort(
    keyed,
    compare: (a, b) {
      final folded = compareAsciiLowerCaseNatural(a.$2, b.$2);
      return folded != 0 ? folded : a.$1.name.compareTo(b.$1.name);
    },
  );
  return [for (final e in keyed) e.$1];
}

extension CountrySorting on List<Country> {
  List<Country> sortedBy(SortOption option) {
    switch (option.field) {
      case SortField.name:
        return _applyDirection(sortedByName(this), option.direction);
      case SortField.population:
        return _sortedByOptional(option.direction, (c) => c.population);
      case SortField.area:
        return _sortedByOptional(option.direction, (c) => c.area);
    }
  }

  // Missing values sort last in both directions. Reversing one combined
  // ascending list would move them to the front for descending, so known and
  // unknown values are handled separately and unknowns always appended.
  List<Country> _sortedByOptional(
    SortDirection direction,
    num? Function(Country) value,
  ) {
    final known = <(Country, num)>[];
    final unknown = <Country>[];
    for (final country in this) {
      final v = value(country);
      if (v == null) {
        unknown.add(country);
      } else {
        known.add((country, v));
      }
    }
    // mergeSort is stable, so ties keep their incoming order.
    mergeSort(known, compare: (a, b) => a.$2.compareTo(b.$2));
    final ascending = known.map((e) => e.$1).toList();
    return [..._applyDirection(ascending, direction), ...unknown];
  }
}

List<Country> _applyDirection(
  List<Country> ascending,
  SortDirection direction,
) => direction == SortDirection.ascending
    ? ascending
    : ascending.reversed.toList();

/// What every list tab shows: matching countries in the chosen order.
List<Country> filterCountries(
  List<Country> countries,
  String query,
  SortOption option,
) {
  final matches = query.isEmpty
      ? countries
      : countries.where((c) => c.matches(query)).toList();
  return matches.sortedBy(option);
}
