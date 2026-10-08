import 'package:latlong2/latlong.dart';

/// Everything the Map tab draws, bundled with the app (built by
/// tool/build_map_data.dart).
class MapData {
  const MapData({required this.shapes, required this.pins});

  /// Country outlines: the map itself.
  final List<CountryShape> shapes;

  /// Where each country's pin goes, by ISO alpha-3 code.
  final Map<String, PinSpot> pins;
}

/// A country's outline: one or more polygons (mainland and islands), each an
/// outer ring followed by any holes.
class CountryShape {
  const CountryShape({required this.code, required this.polygons});

  /// The ISO alpha-3 code, matching `Country.alpha3Code`.
  final String code;

  final List<List<List<LatLng>>> polygons;
}

/// Where a country's pin goes: its capital city, or a spot on its land when
/// the capital isn't known.
class PinSpot {
  const PinSpot({required this.point, required this.landSize});

  final LatLng point;

  /// How big the landmass under the pin is, in degrees (the larger of its
  /// width and height); 0 if there's no outline there. While that land is
  /// smaller than the pin's island dot, the dot shows instead.
  final double landSize;
}
