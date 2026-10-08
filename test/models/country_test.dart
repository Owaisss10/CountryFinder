import 'package:country_finder/models/country.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fixtures.dart';

void main() {
  group('decoding', () {
    test('decodes with only the required keys present', () {
      final c = Country.fromJson({
        'name': 'Nowhere',
        'alpha3Code': 'NWH',
        'alpha2Code': 'NW',
        'region': 'Oceania',
      });
      expect(c.capital, isNull);
      expect(c.borders, isNull);
      expect(c.flagPng, isNull);
      expect(c.latlng, isNull);
    });

    test('an absent borders key decodes as null', () {
      expect(Country.fromJson(countryJson()).borders, isNull);
    });

    test('integer area and latlng decode as doubles', () {
      final c = Country.fromJson(countryJson(area: 100, latlng: [33, 65]));
      expect(c.area, 100.0);
      expect(c.latlng, [33.0, 65.0]);
    });

    test('nested flags decode to URLs', () {
      final c = Country.fromJson(
        countryJson(
          flags: {'png': 'https://x.test/a.png', 'svg': 'https://x.test/a.svg'},
        ),
      );
      expect(c.flagPng, Uri.parse('https://x.test/a.png'));
      expect(c.flagSvg, Uri.parse('https://x.test/a.svg'));
    });

    for (final flags in <Object>[
      'not-an-object',
      42,
      {'png': 7},
      <String, dynamic>{},
    ]) {
      test('malformed flags ($flags) decode to null instead of failing', () {
        expect(Country.fromJson(countryJson(flags: flags)).flagPng, isNull);
      });
    }

    test('a missing required key throws', () {
      expect(
        () => Country.fromJson({'name': 'No code', 'region': 'Europe'}),
        throwsA(anything),
      );
    });
  });

  test('coordinates need exactly two values', () {
    final c = country(latlng: [46, 2.5]);
    expect(c.coordinates, (latitude: 46.0, longitude: 2.5));
    expect(country(latlng: [1]).coordinates, isNull);
    expect(country(latlng: null).coordinates, isNull);
  });

  group('matches', () {
    test('an empty query matches everything', () {
      expect(country().matches(''), isTrue);
    });

    test('"cote" finds Ivory Coast via nativeName', () {
      final civ = country(
        name: 'Ivory Coast',
        alpha3Code: 'CIV',
        nativeName: "Côte d'Ivoire",
      );
      expect(civ.matches('cote'), isTrue);
    });

    test('Ivory Coast matches with any apostrophe, or none', () {
      final civ = country(
        name: 'Ivory Coast',
        alpha3Code: 'CIV',
        nativeName: "Côte d'Ivoire",
      );
      expect(civ.matches("cote d'ivoire"), isTrue);
      expect(civ.matches('Côte d’Ivoire'), isTrue);
      expect(civ.matches('cote divoire'), isTrue);
      expect(civ.matches('cote d ivoire'), isFalse);
    });

    test('"turkiye" finds Turkey via nativeName', () {
      final tur = country(
        name: 'Turkey',
        alpha3Code: 'TUR',
        nativeName: 'Türkiye',
      );
      expect(tur.matches('turkiye'), isTrue);
      expect(tur.matches('TÜRK'), isTrue);
    });

    test('is case-insensitive and checks altSpellings', () {
      final fra = country(altSpellings: ['FR', 'French Republic']);
      expect(fra.matches('FRA'), isTrue);
      expect(fra.matches('republic'), isTrue);
      expect(fra.matches('germany'), isFalse);
    });
  });
}
