import 'dart:convert';
import 'dart:isolate';

import 'package:country_finder/models/map_data.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

/// Outlines and pin spots for the Map tab.
abstract interface class MapDataRepository {
  Future<MapData> load();
}

/// Reads the map data bundled with the app (built by
/// tool/build_map_data.dart from Natural Earth's public-domain data), so the
/// map needs no tile server and works offline.
class AssetMapDataRepository implements MapDataRepository {
  AssetMapDataRepository(this._bundle);

  static const assetPath = 'assets/map/map_data.json';

  final AssetBundle _bundle;

  @override
  Future<MapData> load() async {
    final json = await _bundle.loadString(assetPath);
    // About 100,000 points: parsed off the UI isolate to avoid jank.
    return Isolate.run(() => parseMapData(json));
  }
}

/// Parses the asset format:
/// {"shapes": [{"c": code, "p": [[ring, ...], ...]}],
///  "pins": {code: [lon, lat, landSize], ...}}
/// where a ring is a flat [lon, lat, lon, lat, ...] list and a polygon's
/// first ring is its outline, the rest its holes.
MapData parseMapData(String json) {
  final data = jsonDecode(json) as Map<String, dynamic>;
  return MapData(
    shapes: [
      for (final shape in data['shapes'] as List<dynamic>)
        CountryShape(
          code: shape['c'] as String,
          polygons: [
            for (final polygon in shape['p'] as List<dynamic>)
              [
                for (final ring in polygon as List<dynamic>)
                  _ring(ring as List),
              ],
          ],
        ),
    ],
    pins: {
      for (final MapEntry(:key, :value)
          in (data['pins'] as Map<String, dynamic>).entries)
        key: PinSpot(
          point: _ring(value as List).first,
          landSize: (value[2] as num).toDouble(),
        ),
    },
  );
}

List<LatLng> _ring(List<dynamic> flat) => [
  for (var i = 0; i + 1 < flat.length; i += 2)
    LatLng((flat[i + 1] as num).toDouble(), (flat[i] as num).toDouble()),
];
