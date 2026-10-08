// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The single, app-wide source of the country list shared by every tab.

@ProviderFor(CountriesList)
final countriesListProvider = CountriesListProvider._();

/// The single, app-wide source of the country list shared by every tab.
final class CountriesListProvider
    extends $NotifierProvider<CountriesList, CountriesListState> {
  /// The single, app-wide source of the country list shared by every tab.
  CountriesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countriesListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countriesListHash();

  @$internal
  @override
  CountriesList create() => CountriesList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountriesListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountriesListState>(value),
    );
  }
}

String _$countriesListHash() => r'98f05ae3d22611e16f413b3a35fbf2c63c46e9d3';

/// The single, app-wide source of the country list shared by every tab.

abstract class _$CountriesList extends $Notifier<CountriesListState> {
  CountriesListState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CountriesListState, CountriesListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CountriesListState, CountriesListState>,
              CountriesListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The list a tab shows for [query], recomputed only when the countries,
/// the sort option or the query change.

@ProviderFor(filteredCountries)
final filteredCountriesProvider = FilteredCountriesFamily._();

/// The list a tab shows for [query], recomputed only when the countries,
/// the sort option or the query change.

final class FilteredCountriesProvider
    extends $FunctionalProvider<List<Country>, List<Country>, List<Country>>
    with $Provider<List<Country>> {
  /// The list a tab shows for [query], recomputed only when the countries,
  /// the sort option or the query change.
  FilteredCountriesProvider._({
    required FilteredCountriesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredCountriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredCountriesHash();

  @override
  String toString() {
    return r'filteredCountriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Country>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Country> create(Ref ref) {
    final argument = this.argument as String;
    return filteredCountries(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Country> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Country>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredCountriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredCountriesHash() => r'a35380833aaf91f7d27454f645a43b621b1fab52';

/// The list a tab shows for [query], recomputed only when the countries,
/// the sort option or the query change.

final class FilteredCountriesFamily extends $Family
    with $FunctionalFamilyOverride<List<Country>, String> {
  FilteredCountriesFamily._()
    : super(
        retry: null,
        name: r'filteredCountriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The list a tab shows for [query], recomputed only when the countries,
  /// the sort option or the query change.

  FilteredCountriesProvider call(String query) =>
      FilteredCountriesProvider._(argument: query, from: this);

  @override
  String toString() => r'filteredCountriesProvider';
}
