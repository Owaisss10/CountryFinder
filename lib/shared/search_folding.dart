import 'package:diacritic/diacritic.dart';

// Characters `removeDiacritics` leaves alone or that lowercase differently
// per locale. Mapped explicitly so folding never depends on the device
// language (e.g. Turkish İ/ı).
const Map<String, String> _extraFolds = {
  'İ': 'i',
  'I': 'i',
  'ı': 'i',
  'ß': 'ss',
  'ẞ': 'ss',
  // Apostrophes are dropped, so "cote d'ivoire", "cote d’ivoire" (the curly
  // one iOS types by default) and "cote divoire" all match.
  "'": '',
  '’': '',
  '‘': '',
  'ʼ': '',
  '`': '',
};

/// Case- and diacritic-folded form used for search, applied to both the
/// query and the candidate: "Côte d'Ivoire" → "cote divoire",
/// "Türkiye" → "turkiye".
String foldForSearch(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(_extraFolds[char] ?? char);
  }
  // Strip diacritics before lowercasing, and strip again after: some
  // lowercase forms (e.g. from combined characters) only map once lowered.
  return removeDiacritics(removeDiacritics(buffer.toString()).toLowerCase());
}
