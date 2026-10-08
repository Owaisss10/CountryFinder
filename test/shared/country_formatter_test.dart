import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/models/weather.dart';
import 'package:country_finder/shared/country_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

void main() {
  final formatter = CountryFormatter(
    lookupAppLocalizations(const Locale('en')),
  );

  test('capital falls back to "No capital"', () {
    expect(formatter.capital(country()), 'Paris');
    expect(formatter.capital(country(capital: null)), 'No capital');
  });

  test('population is grouped', () {
    expect(formatter.population(country(population: 1234567)), '1,234,567');
    expect(formatter.population(country()), '-');
  });

  test('area has no decimals and a km² unit', () {
    expect(formatter.area(country(area: 551695.4)), '551,695 km²');
    expect(formatter.area(country()), '-');
  });

  test('density has one decimal', () {
    expect(
      formatter.density(country(populationDensity: 119.46)),
      '119.5 / km²',
    );
    expect(formatter.density(country()), '-');
  });

  test('calling codes get a + prefix', () {
    expect(formatter.callingCodes(country(callingCodes: ['33'])), '+33');
    expect(
      formatter.callingCodes(country(callingCodes: ['1', '264'])),
      '+1, +264',
    );
    expect(formatter.callingCodes(country(callingCodes: [])), '-');
  });

  test('currencies show code — name, or whichever part exists', () {
    expect(
      formatter.currencies(
        country(
          currencies: const [
            Currency(code: 'EUR', name: 'Euro'),
            Currency(code: 'USD'),
            Currency(name: 'Pound'),
          ],
        ),
      ),
      'EUR — Euro, USD, Pound',
    );
    expect(formatter.currencies(country()), '-');
  });

  test('languages and timezones are joined', () {
    expect(
      formatter.languages(
        country(
          languages: const [
            Language(name: 'French'),
            Language(name: 'Breton'),
          ],
        ),
      ),
      'French, Breton',
    );
    expect(formatter.timezones(country(timezones: ['UTC+01:00'])), 'UTC+01:00');
    expect(formatter.timezones(country()), '-');
  });

  test('coordinates need exactly two values', () {
    expect(formatter.coordinates(country(latlng: [46, 2.5])), '46, 2.5');
    expect(formatter.coordinates(country(latlng: [1])), '-');
  });

  test('temperature is rounded to whole degrees', () {
    expect(formatter.temperature(sampleWeather), '21°C');
  });

  test('every weather condition and sort field has text', () {
    for (final condition in WeatherCondition.values) {
      expect(formatter.weatherDescription(condition), isNotEmpty);
    }
    expect(
      formatter.weatherDescription(WeatherCondition.partlyCloudy),
      'Partly cloudy',
    );
    expect(formatter.sortFieldTitle(SortField.population), 'Population');
  });
}
