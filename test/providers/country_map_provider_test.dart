import 'dart:async';

import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/models/map_data.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/country_map_provider.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:country_finder/repositories/map_data_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

import '../support/fixtures.dart';
import '../support/test_container.dart';

void main() {
  final fra = country();
  final esp = country(name: 'Spain', alpha3Code: 'ESP', latlng: [40, -4]);
  final nowhere = country(name: 'Nowhere', alpha3Code: 'NWH', latlng: null);

  /// A container with the countries loaded and the map providers alive.
  Future<ProviderContainer> loaded({MapDataRepository? mapData}) async {
    final container = testContainer(
      countries: FakeCountriesRepository(
        (_) async => CountriesFetchResult(
          countries: [fra, esp, nowhere],
          isFromCache: false,
        ),
      ),
      mapData: mapData ?? FakeMapDataRepository(sampleMapData),
    );
    container.listen(mapPinsProvider, (_, _) {});
    container.listen(selectedMapCountryProvider(AppTab.countries), (_, _) {});
    await container.read(countriesListProvider.notifier).load();
    await container
        .read(mapDataProvider.future)
        .catchError((Object _) => const MapData(shapes: [], pins: {}));
    return container;
  }

  test('pins sit at the capital from the map data, else the API '
      'coordinates; countries with neither are left off', () async {
    final container = await loaded(
      mapData: FakeMapDataRepository(
        const MapData(
          shapes: [],
          pins: {
            // Paris, on large land.
            'FRA': PinSpot(point: LatLng(48.86, 2.35), landSize: 13),
          },
        ),
      ),
    );
    final pins = container.read(mapPinsProvider);
    expect(pins.map((p) => p.country), [fra, esp]);
    expect(pins.map((p) => p.point), [
      const LatLng(48.86, 2.35),
      const LatLng(40, -4),
    ]);
    // No land is known under the API's coordinates.
    expect(pins.map((p) => p.landSize), [13, 0]);
  });

  test('pins wait for the map data, so they never jump', () async {
    final mapData = Completer<MapData>();
    final container = testContainer(
      countries: FakeCountriesRepository(
        (_) async => CountriesFetchResult(countries: [fra], isFromCache: false),
      ),
      mapData: _PendingMapData(mapData.future),
    );
    container.listen(mapPinsProvider, (_, _) {});
    await container.read(countriesListProvider.notifier).load();
    expect(container.read(mapPinsProvider), isEmpty);

    mapData.complete(sampleMapData);
    await container.read(mapDataProvider.future);
    expect(container.read(mapPinsProvider).single.point, const LatLng(46, 2));
  });

  test('if the map data fails to load, pins use the API coordinates', () async {
    final container = await loaded(mapData: _FailingMapData());
    expect(container.read(mapPinsProvider).map((p) => p.point), [
      const LatLng(46, 2),
      const LatLng(40, -4),
    ]);
  });

  test(
    'selecting a pin exposes its country; tapping the map clears it',
    () async {
      final container = await loaded();
      final selection = container.read(
        mapSelectionProvider(AppTab.countries).notifier,
      );

      selection.select('FRA');
      expect(container.read(selectedMapCountryProvider(AppTab.countries)), fra);

      selection.clearSelection();
      expect(
        container.read(selectedMapCountryProvider(AppTab.countries)),
        isNull,
      );
    },
  );

  test('a selection that is no longer on the map shows no card', () async {
    final container = await loaded();
    container
        .read(mapSelectionProvider(AppTab.countries).notifier)
        .select('NWH');
    expect(
      container.read(selectedMapCountryProvider(AppTab.countries)),
      isNull,
    );
  });
}

class _PendingMapData implements MapDataRepository {
  _PendingMapData(this._result);

  final Future<MapData> _result;

  @override
  Future<MapData> load() => _result;
}

class _FailingMapData implements MapDataRepository {
  @override
  Future<MapData> load() async => throw StateError('asset missing');
}
