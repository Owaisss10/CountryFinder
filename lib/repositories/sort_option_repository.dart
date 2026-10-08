import 'dart:convert';

import 'package:country_finder/models/sort_option.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _log = Logger('SortOptionRepository');

/// Remembers the list sort choice across launches.
abstract interface class SortOptionRepository {
  SortOption load();
  Future<void> save(SortOption option);
}

class SharedPrefsSortOptionRepository implements SortOptionRepository {
  SharedPrefsSortOptionRepository(this._prefs);

  static const key = 'sortOption';

  final SharedPreferences _prefs;

  @override
  SortOption load() {
    final raw = _prefs.getString(key);
    if (raw == null) return SortOption.defaultOption;
    try {
      return SortOption.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object catch (e) {
      _log.warning('Ignoring unreadable saved sort option', e);
      return SortOption.defaultOption;
    }
  }

  @override
  Future<void> save(SortOption option) async {
    final saved = await _prefs.setString(key, jsonEncode(option.toJson()));
    if (!saved) _log.warning('Failed to save sort option');
  }
}
