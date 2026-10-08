import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/shared/country_sorting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

void main() {
  final a = country(name: 'Åland Islands', alpha3Code: 'ALA', population: 30);
  final b = country(
    name: 'Brazil',
    alpha3Code: 'BRA',
    population: 200,
    area: 8.5,
  );
  final c = country(name: 'chad', alpha3Code: 'TCD', area: 1.2);
  final d = country(name: 'Denmark', alpha3Code: 'DNK', population: 5);
  final all = [d, c, b, a];

  String codes(List<Country> list) => list.map((c) => c.alpha3Code).join(',');
  SortOption by(SortField field, SortDirection direction) =>
      SortOption(field: field, direction: direction);

  test('name ascending is case- and accent-insensitive', () {
    expect(
      codes(all.sortedBy(by(SortField.name, SortDirection.ascending))),
      'ALA,BRA,TCD,DNK',
    );
  });

  test('name descending reverses', () {
    expect(
      codes(all.sortedBy(by(SortField.name, SortDirection.descending))),
      'DNK,TCD,BRA,ALA',
    );
  });

  test('name order is natural', () {
    final list = [
      country(name: 'Country 10', alpha3Code: 'C10'),
      country(name: 'Country 2', alpha3Code: 'C02'),
    ];
    expect(codes(sortedByName(list)), 'C02,C10');
  });

  test('population: unknowns last in both directions', () {
    expect(
      codes(all.sortedBy(by(SortField.population, SortDirection.ascending))),
      'DNK,ALA,BRA,TCD',
    );
    expect(
      codes(all.sortedBy(by(SortField.population, SortDirection.descending))),
      'BRA,ALA,DNK,TCD',
    );
  });

  test('area: unknowns last, kept in their original order', () {
    expect(
      codes(all.sortedBy(by(SortField.area, SortDirection.ascending))),
      'TCD,BRA,DNK,ALA',
    );
    expect(
      codes(all.sortedBy(by(SortField.area, SortDirection.descending))),
      'BRA,TCD,DNK,ALA',
    );
  });

  test('selecting the active field toggles; another field resets to '
      'ascending', () {
    final byNameDesc = SortOption.defaultOption.selecting(SortField.name);
    expect(byNameDesc.direction, SortDirection.descending);
    expect(
      byNameDesc.selecting(SortField.name).direction,
      SortDirection.ascending,
    );
    expect(
      byNameDesc.selecting(SortField.area),
      by(SortField.area, SortDirection.ascending),
    );
  });

  test('filterCountries filters, then sorts', () {
    expect(
      codes(filterCountries(all, 'a', SortOption.defaultOption)),
      'ALA,BRA,TCD,DNK',
    );
    expect(codes(filterCountries(all, 'den', SortOption.defaultOption)), 'DNK');
  });
}
