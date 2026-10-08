import 'package:country_finder/models/country.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_provider.g.dart';

final _log = Logger('FavoritesNotifier');

class FavoritesState {
  const FavoritesState({
    this.order = const [],
    this.codes = const {},
    this.favorites = const [],
  });

  /// Favorite codes, most recently added first.
  final List<String> order;

  /// Same codes as [order], for O(1) membership checks.
  final Set<String> codes;

  /// [order] resolved against the loaded countries; unknown codes skipped.
  final List<Country> favorites;

  bool isFavorite(String alpha3Code) => codes.contains(alpha3Code);
}

@Riverpod(keepAlive: true)
class Favorites extends _$Favorites {
  @override
  FavoritesState build() {
    // Countries load asynchronously and may still be empty when favorites
    // are first resolved, so rebuild whenever the list changes.
    ref.listen(
      countriesListProvider.select((s) => s.countries),
      (_, countries) => _rebuild(state.order, countries),
    );
    Future.microtask(refresh);
    return const FavoritesState();
  }

  Future<void> refresh() async {
    List<String> order;
    try {
      final entries = await ref.read(favoritesRepositoryProvider).fetchAll();
      order = [for (final e in entries) e.alpha3Code];
    } on Object catch (e, st) {
      _log.warning('Failed to load favorites', e, st);
      order = const [];
    }
    if (!ref.mounted) return;
    _rebuild(order, ref.read(countriesListProvider).countries);
  }

  /// Persistence errors are logged, never surfaced to the UI.
  Future<void> toggle(String alpha3Code) async {
    final repository = ref.read(favoritesRepositoryProvider);
    try {
      if (state.isFavorite(alpha3Code)) {
        await repository.remove(alpha3Code);
      } else {
        await repository.add(alpha3Code);
      }
    } on Object catch (e, st) {
      _log.warning('Failed to toggle favorite $alpha3Code', e, st);
      return;
    }
    await refresh();
  }

  void _rebuild(List<String> order, List<Country> countries) {
    final index = {for (final c in countries) c.alpha3Code: c};
    state = FavoritesState(
      order: order,
      codes: order.toSet(),
      favorites: [for (final code in order) ?index[code]],
    );
  }
}
