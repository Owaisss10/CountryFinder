// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_map_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The code of the country whose pin is selected on a tab's map, or null.
/// Each tab has its own; kept alive so it survives switching tabs.

@ProviderFor(MapSelection)
final mapSelectionProvider = MapSelectionFamily._();

/// The code of the country whose pin is selected on a tab's map, or null.
/// Each tab has its own; kept alive so it survives switching tabs.
final class MapSelectionProvider
    extends $NotifierProvider<MapSelection, String?> {
  /// The code of the country whose pin is selected on a tab's map, or null.
  /// Each tab has its own; kept alive so it survives switching tabs.
  MapSelectionProvider._({
    required MapSelectionFamily super.from,
    required AppTab super.argument,
  }) : super(
         retry: null,
         name: r'mapSelectionProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mapSelectionHash();

  @override
  String toString() {
    return r'mapSelectionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MapSelection create() => MapSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MapSelectionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mapSelectionHash() => r'79193b5310f171f004fba6fa1e7b70cefc2742be';

/// The code of the country whose pin is selected on a tab's map, or null.
/// Each tab has its own; kept alive so it survives switching tabs.

final class MapSelectionFamily extends $Family
    with $ClassFamilyOverride<MapSelection, String?, String?, String?, AppTab> {
  MapSelectionFamily._()
    : super(
        retry: null,
        name: r'mapSelectionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// The code of the country whose pin is selected on a tab's map, or null.
  /// Each tab has its own; kept alive so it survives switching tabs.

  MapSelectionProvider call(AppTab tab) =>
      MapSelectionProvider._(argument: tab, from: this);

  @override
  String toString() => r'mapSelectionProvider';
}

/// The code of the country whose pin is selected on a tab's map, or null.
/// Each tab has its own; kept alive so it survives switching tabs.

abstract class _$MapSelection extends $Notifier<String?> {
  late final _$args = ref.$arg as AppTab;
  AppTab get tab => _$args;

  String? build(AppTab tab);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// The map's outlines and pin spots. Loaded once and kept.

@ProviderFor(mapData)
final mapDataProvider = MapDataProvider._();

/// The map's outlines and pin spots. Loaded once and kept.

final class MapDataProvider
    extends $FunctionalProvider<AsyncValue<MapData>, MapData, FutureOr<MapData>>
    with $FutureModifier<MapData>, $FutureProvider<MapData> {
  /// The map's outlines and pin spots. Loaded once and kept.
  MapDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapDataProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapDataHash();

  @$internal
  @override
  $FutureProviderElement<MapData> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<MapData> create(Ref ref) {
    return mapData(ref);
  }
}

String _$mapDataHash() => r'd4af9b643a2a2904321742207e5892b6cf79a101';

/// One pin per country, at its capital (or, for the few places whose capital
/// isn't in the map data, a spot on their land), falling back to the API's
/// coordinates for countries the map data doesn't know.

@ProviderFor(mapPins)
final mapPinsProvider = MapPinsProvider._();

/// One pin per country, at its capital (or, for the few places whose capital
/// isn't in the map data, a spot on their land), falling back to the API's
/// coordinates for countries the map data doesn't know.

final class MapPinsProvider
    extends $FunctionalProvider<List<MapPin>, List<MapPin>, List<MapPin>>
    with $Provider<List<MapPin>> {
  /// One pin per country, at its capital (or, for the few places whose capital
  /// isn't in the map data, a spot on their land), falling back to the API's
  /// coordinates for countries the map data doesn't know.
  MapPinsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapPinsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapPinsHash();

  @$internal
  @override
  $ProviderElement<List<MapPin>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<MapPin> create(Ref ref) {
    return mapPins(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MapPin> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MapPin>>(value),
    );
  }
}

String _$mapPinsHash() => r'527963d5a72d21861774872860f0a1b878179568';

/// The selected pin's country, as long as it's still on the map (a reload
/// could drop it).

@ProviderFor(selectedMapCountry)
final selectedMapCountryProvider = SelectedMapCountryFamily._();

/// The selected pin's country, as long as it's still on the map (a reload
/// could drop it).

final class SelectedMapCountryProvider
    extends $FunctionalProvider<Country?, Country?, Country?>
    with $Provider<Country?> {
  /// The selected pin's country, as long as it's still on the map (a reload
  /// could drop it).
  SelectedMapCountryProvider._({
    required SelectedMapCountryFamily super.from,
    required AppTab super.argument,
  }) : super(
         retry: null,
         name: r'selectedMapCountryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedMapCountryHash();

  @override
  String toString() {
    return r'selectedMapCountryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Country?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Country? create(Ref ref) {
    final argument = this.argument as AppTab;
    return selectedMapCountry(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Country? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Country?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedMapCountryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedMapCountryHash() =>
    r'8dbcf5feab2db7e1371a4bfd81a845d0c2249af3';

/// The selected pin's country, as long as it's still on the map (a reload
/// could drop it).

final class SelectedMapCountryFamily extends $Family
    with $FunctionalFamilyOverride<Country?, AppTab> {
  SelectedMapCountryFamily._()
    : super(
        retry: null,
        name: r'selectedMapCountryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The selected pin's country, as long as it's still on the map (a reload
  /// could drop it).

  SelectedMapCountryProvider call(AppTab tab) =>
      SelectedMapCountryProvider._(argument: tab, from: this);

  @override
  String toString() => r'selectedMapCountryProvider';
}
