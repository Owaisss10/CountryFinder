import 'package:country_finder/shared/search_folding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('strips diacritics and case', () {
    expect(foldForSearch("Côte d'Ivoire"), 'cote divoire');
    expect(foldForSearch('Türkiye'), 'turkiye');
    expect(foldForSearch('ÅLAND'), 'aland');
  });

  test('drops straight and curly apostrophes', () {
    expect(foldForSearch("d'Ivoire"), 'divoire');
    expect(foldForSearch('d’Ivoire'), 'divoire');
    expect(foldForSearch('d‘Ivoire'), 'divoire');
    expect(foldForSearch('dʼIvoire'), 'divoire');
  });

  test('Turkish dotted and dotless i fold to i regardless of locale', () {
    expect(foldForSearch('İstanbul'), 'istanbul');
    expect(foldForSearch('Diyarbakır'), 'diyarbakir');
  });
}
