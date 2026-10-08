import 'package:collection/collection.dart';
import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:country_finder/shared/country_sorting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'countries_list_provider.freezed.dart';
part 'countries_list_provider.g.dart';

final _log = Logger('CountriesListNotifier');

sealed class ViewState {
  const ViewState();
}

final class ViewLoading extends ViewState {
  const ViewLoading();
}

final class ViewLoaded extends ViewState {
  const ViewLoaded();
}

final class ViewFailed extends ViewState {
  const ViewFailed(this.error);

  final DomainError error;
}

@freezed
abstract class CountriesListState with _$CountriesListState {
  const factory CountriesListState({
    required ViewState viewState,
    required List<Country> countries,
    required bool isOffline,
    DateTime? cacheDate,
    required SortOption sortOption,
  }) = _CountriesListState;
}

/// The single, app-wide source of the country list shared by every tab.
@Riverpod(keepAlive: true)
class CountriesList extends _$CountriesList {
  bool _isLoadInFlight = false;

  @override
  CountriesListState build() => CountriesListState(
    viewState: const ViewLoading(),
    countries: const [],
    isOffline: false,
    sortOption: ref.read(sortOptionRepositoryProvider).load(),
  );

  Future<void> load() => _performLoad(forceNetwork: false);

  /// Tapping Retry always attempts a real request, never trusting a
  /// possibly stale "offline" reading from the network monitor.
  Future<void> retry() => _performLoad(forceNetwork: true);

  Future<void> _performLoad({required bool forceNetwork}) async {
    // Several tabs call load() on first appearance; only the first one runs.
    if (_isLoadInFlight) return;
    _isLoadInFlight = true;
    state = state.copyWith(viewState: const ViewLoading());
    try {
      final result = await ref
          .read(countriesRepositoryProvider)
          .fetchCountries(forceNetwork: forceNetwork);
      if (!ref.mounted) return;
      state = state.copyWith(
        countries: result.countries,
        isOffline: result.isFromCache,
        cacheDate: result.cacheDate,
        viewState: const ViewLoaded(),
      );
    } on DomainError catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(viewState: ViewFailed(e));
    } on Object catch (e, st) {
      // The repository contract only throws DomainError; anything else is a
      // bug, but it still needs a retry path.
      _log.severe('Unexpected error loading countries', e, st);
      if (!ref.mounted) return;
      state = state.copyWith(
        viewState: const ViewFailed(DecodingFailedError()),
      );
    } finally {
      _isLoadInFlight = false;
    }
  }

  Future<void> setSortOption(SortOption option) async {
    state = state.copyWith(sortOption: option);
    try {
      await ref.read(sortOptionRepositoryProvider).save(option);
    } on Object catch (e, st) {
      _log.warning('Failed to persist sort option', e, st);
    }
  }

  Future<void> selectSortField(SortField field) =>
      setSortOption(state.sortOption.selecting(field));

  List<Country> filtered(String query) =>
      filterCountries(state.countries, query, state.sortOption);

  Country? countryByAlpha3(String alpha3Code) =>
      state.countries.firstWhereOrNull((c) => c.alpha3Code == alpha3Code);
}

/// The list a tab shows for [query], recomputed only when the countries,
/// the sort option or the query change.
@riverpod
List<Country> filteredCountries(Ref ref, String query) {
  final countries = ref.watch(countriesListProvider.select((s) => s.countries));
  final sortOption = ref.watch(
    countriesListProvider.select((s) => s.sortOption),
  );
  return filterCountries(countries, query, sortOption);
}
