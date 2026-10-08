import 'package:collection/collection.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/map_data.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_map_provider.g.dart';

/// The code of the country whose pin is selected on a tab's map, or null.
/// Each tab has its own; kept alive so it survives switching tabs.
@Riverpod(keepAlive: true)
class MapSelection extends _$MapSelection {
  @override
  String? build(AppTab tab) => null;

  void select(String alpha3Code) => state = alpha3Code;

  void clearSelection() => state = null;
}

/// A country's pin on the map.
class MapPin {
  const MapPin({
    required this.country,
    required this.point,
    required this.landSize,
  });

  final Country country;

  /// Where the pin's tip points: the capital city when known.
  final LatLng point;

  /// See [PinSpot.landSize].
  final double landSize;
}

/// The map's outlines and pin spots. Loaded once and kept.
@Riverpod(keepAlive: true)
Future<MapData> mapData(Ref ref) => ref.watch(mapDataRepositoryProvider).load();

/// One pin per country, at its capital (or, for the few places whose capital
/// isn't in the map data, a spot on their land), falling back to the API's
/// coordinates for countries the map data doesn't know.
@riverpod
List<MapPin> mapPins(Ref ref) {
  final countries = ref.watch(countriesListProvider.select((s) => s.countries));
  final data = ref.watch(mapDataProvider);
  // Pins wait for the map data, so they don't jump to their capitals a moment
  // after appearing. If it fails to load, the API's coordinates are used.
  if (!data.hasValue && !data.hasError) return const [];
  final spots = data.value?.pins ?? const <String, PinSpot>{};
  return [
    for (final country in countries)
      if (spots[country.alpha3Code] ?? _apiSpot(country) case final spot?)
        MapPin(country: country, point: spot.point, landSize: spot.landSize),
  ];
}

/// The API's coordinates, with no known land under them.
PinSpot? _apiSpot(Country country) => switch (country.coordinates) {
  (:final latitude, :final longitude) => PinSpot(
    point: LatLng(latitude, longitude),
    landSize: 0,
  ),
  null => null,
};

/// The selected pin's country, as long as it's still on the map (a reload
/// could drop it).
@riverpod
Country? selectedMapCountry(Ref ref, AppTab tab) {
  final code = ref.watch(mapSelectionProvider(tab));
  if (code == null) return null;
  return ref
      .watch(mapPinsProvider)
      .firstWhereOrNull((pin) => pin.country.alpha3Code == code)
      ?.country;
}
