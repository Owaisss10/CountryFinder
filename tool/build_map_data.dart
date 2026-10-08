// Builds assets/map/map_data.json, everything the Map tab draws, from
// Natural Earth's public-domain data and a countries.dev response:
//
//   dart run tool/build_map_data.dart \
//     ne_50m_admin_0_countries.geojson \
//     ne_10m_populated_places_simple.geojson \
//     countries.json \
//     assets/map/map_data.json
//
// - Country outlines (1:50m):
//   https://github.com/nvkelso/natural-earth-vector/blob/master/geojson/ne_50m_admin_0_countries.geojson
// - Populated places, for capital cities (1:10m):
//   https://github.com/nvkelso/natural-earth-vector/blob/master/geojson/ne_10m_populated_places_simple.geojson
// - countries.json: the response of GET https://countries.dev/countries,
//   for each country's code and capital name.
//
// Output: {"shapes": [{"c": code, "p": [[outerRing, hole, ...], ...]}],
//          "pins": {code: [lon, lat, landSize], ...}}
// - shapes: outlines; "c" is the ISO alpha-3 code as countries.dev uses it,
//   "p" the polygons, each an outer ring then any holes, every ring a flat
//   [lon, lat, lon, lat, ...] list.
// - pins: where each countries.dev country's pin goes: its capital city when
//   Natural Earth has it, otherwise a spot on its land, otherwise the API's
//   coordinates. landSize is the size in degrees (the larger of width and
//   height) of the landmass under the pin, or 0 if there's none to draw; the
//   app shows a small island dot while that land is too small to see.
// Coordinates are rounded to two decimal places (about 1 km), plenty for
// country-level zoom.

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:country_finder/shared/search_folding.dart';

const _decimals = 2;

/// Horizontal lines tried across the largest island when looking for a spot
/// on land.
const _scanLines = 15;

/// Stretches of land at least this share of the widest one count as wide
/// enough for a pin; the one nearest the island's centre wins.
const _minWidthShare = 0.5;

/// A pin this close to a coastline (in degrees, about 50 km) counts as on
/// that land: simplified coastlines can leave a seaside capital just offshore.
const _coastSnap = 0.5;

/// Codes where countries.dev differs from Natural Earth.
const _codeAliases = {
  // Kosovo has no ISO code; countries.dev uses the UN's interim "UNK".
  'KOS': 'UNK',
  // Natural Earth's own codes where they differ from ISO.
  'SDS': 'SSD',
  'PSX': 'PSE',
  'SAH': 'ESH',
  'ALD': 'ALA',
};

/// How strongly a place counts as a country's capital, best first.
const _capitalRank = {
  'Admin-0 capital': 0,
  'Admin-0 region capital': 1,
  'Admin-0 capital alt': 2,
  'Admin-1 capital': 3,
  'Admin-1 region capital': 4,
};

typedef _Polygon = List<List<double>>;

void main(List<String> args) {
  if (args.length != 4) {
    stderr.writeln(
      'Usage: dart run tool/build_map_data.dart <countries.geojson> '
      '<places.geojson> <countries.dev.json> <output.json>',
    );
    exit(64);
  }
  final outlines = _read(args[0])['features'] as List<dynamic>;
  final places = (_read(args[1])['features'] as List<dynamic>)
      .map((f) => f['properties'] as Map<String, dynamic>)
      .toList();
  final countries = (jsonDecode(File(args[2]).readAsStringSync()) as List)
      .cast<Map<String, dynamic>>();

  final shapes = _shapes(outlines);
  final allPolygons = [
    for (final shape in shapes) ...(shape['p'] as List<_Polygon>),
  ];
  final landPoints = {
    for (final shape in shapes)
      shape['c'] as String: _landPoint(shape['p'] as List<_Polygon>),
  };

  final pins = <String, List<double>>{};
  final sources = <String, List<String>>{};
  for (final country in countries) {
    final code = country['alpha3Code'] as String;
    final capital = _capital(country, places);
    final latlng = (country['latlng'] as List?)?.cast<num>();
    final api = latlng != null && latlng.length == 2
        ? [latlng[1].toDouble(), latlng[0].toDouble()]
        : null;
    final (point, source) = switch ((capital, landPoints[code], api)) {
      (final List<double> c, _, _) => (c, 'capital'),
      (_, final List<double> l, _) => (l, 'land point'),
      (_, _, final List<double> a) => (a, 'API coordinates'),
      _ => (null, 'none'),
    };
    (sources[source] ??= []).add(code);
    if (point == null) continue;
    final rounded = [_round(point[0]), _round(point[1])];
    pins[code] = [...rounded, _round(_landSize(rounded, allPolygons))];
  }

  final text = jsonEncode({'shapes': shapes, 'pins': pins});
  File(args[3])
    ..createSync(recursive: true)
    ..writeAsStringSync(text);
  final points = allPolygons.fold(
    0,
    (sum, polygon) => sum + polygon.fold(0, (s, ring) => s + ring.length ~/ 2),
  );
  stdout
    ..writeln('${shapes.length} outlines, $points points')
    ..writeln('${pins.length} pins, ${text.length} bytes');
  for (final MapEntry(:key, :value) in sources.entries) {
    final list = key == 'capital' ? '' : ': ${value.join(', ')}';
    stdout.writeln('  ${value.length} at $key$list');
  }
}

Map<String, dynamic> _read(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

/// Outlines keyed by countries.dev's codes, sorted by code.
List<Map<String, Object>> _shapes(List<dynamic> features) {
  final ownCodes = {
    for (final feature in features)
      (feature['properties'] as Map<String, dynamic>)['ADM0_A3'] as String,
  };
  final shapes = <Map<String, Object>>[];
  for (final feature in features) {
    final properties = feature['properties'] as Map<String, dynamic>;
    final geometry = feature['geometry'] as Map<String, dynamic>;
    final coordinates = geometry['coordinates'] as List<dynamic>;
    final polygons = geometry['type'] == 'Polygon'
        ? [coordinates]
        : coordinates;

    final outPolygons = <_Polygon>[];
    for (final polygon in polygons.cast<List<dynamic>>()) {
      final rings = [
        for (final ring in polygon.cast<List<dynamic>>()) _flatRing(ring),
      ];
      // A polygon without a drawable outer ring is dropped entirely.
      if (rings.first == null) continue;
      outPolygons.add(rings.whereType<List<double>>().toList());
    }
    if (outPolygons.isNotEmpty) {
      shapes.add({'c': _codeFor(properties, ownCodes), 'p': outPolygons});
    }
  }
  shapes.sort((a, b) => (a['c'] as String).compareTo(b['c'] as String));
  final codes = shapes.map((s) => s['c']).toList();
  final duplicates = codes.where(
    (c) => codes.indexOf(c) != codes.lastIndexOf(c),
  );
  if (duplicates.isNotEmpty) {
    stderr.writeln('Duplicate codes: ${duplicates.toSet()}');
    exit(65);
  }
  return shapes;
}

/// The outline's ISO alpha-3 code, as countries.dev uses it.
///
/// Natural Earth's own "ADM0_A3" differs from ISO for a few places, so
/// "ISO_A3_EH" is preferred. But some territories carry their sovereign's ISO
/// code there (Australia's Indian Ocean Territories have "AUS"), so it's only
/// used when no other place already has that code as its own.
String _codeFor(Map<String, dynamic> properties, Set<String> ownCodes) {
  final own = properties['ADM0_A3'] as String;
  final iso = properties['ISO_A3_EH'] as String?;
  final usable =
      iso != null && iso != '-99' && (iso == own || !ownCodes.contains(iso));
  final code = usable ? iso : own;
  return _codeAliases[code] ?? code;
}

/// The country's capital as [lon, lat]: the place in the country whose name
/// matches countries.dev's capital, best-ranked first; failing that,
/// Natural Earth's own national capital for the country.
List<double>? _capital(
  Map<String, dynamic> country,
  List<Map<String, dynamic>> places,
) {
  final alpha2 = country['alpha2Code'] as String?;
  final alpha3 = country['alpha3Code'] as String;
  final inCountry = places.where((p) {
    final adm0 = p['adm0_a3'] as String?;
    return p['iso_a2'] == alpha2 || (_codeAliases[adm0] ?? adm0) == alpha3;
  }).toList();
  if (inCountry.isEmpty) return null;

  int rank(Map<String, dynamic> p) => _capitalRank[p['featurecla']] ?? 9;
  int byRankThenSize(Map<String, dynamic> a, Map<String, dynamic> b) {
    final byRank = rank(a).compareTo(rank(b));
    if (byRank != 0) return byRank;
    return ((b['pop_max'] as num?) ?? 0).compareTo((a['pop_max'] as num?) ?? 0);
  }

  final wanted = _nameKey(country['capital'] as String?);
  final named = wanted.isEmpty
      ? <Map<String, dynamic>>[]
      : inCountry.where((p) => _placeKeys(p).contains(wanted)).toList();
  final fallback = inCountry.where((p) => rank(p) <= 2).toList();
  final chosen = [
    ...named..sort(byRankThenSize),
    ...fallback..sort(byRankThenSize),
  ];
  if (chosen.isEmpty) return null;
  final place = chosen.first;
  return [
    (place['longitude'] as num).toDouble(),
    (place['latitude'] as num).toDouble(),
  ];
}

/// Every name a place goes by, as comparison keys.
Set<String> _placeKeys(Map<String, dynamic> place) => {
  for (final field in ['name', 'nameascii', 'ls_name', 'namealt', 'namepar'])
    for (final name in ((place[field] as String?) ?? '').split('|'))
      _nameKey(name),
}..remove('');

/// A name reduced for comparison: accents, case, punctuation and spacing
/// dropped, "St." spelled out ("St. George's" matches "Saint George's").
String _nameKey(String? name) => foldForSearch(name ?? '')
    .replaceAll(RegExp(r'\bst\.?\s'), 'saint ')
    .replaceAll(RegExp('[^a-z0-9]'), '');

/// The size (larger of width and height, in degrees) of the landmass the
/// point is on, or the nearest one within [_coastSnap]; 0 if none.
double _landSize(List<double> point, List<_Polygon> polygons) {
  _Polygon? land = polygons.firstWhere(
    (polygon) => _inRing(point, polygon.first),
    orElse: () => const [],
  );
  if (land.isEmpty) {
    var nearest = double.infinity;
    land = null;
    for (final polygon in polygons) {
      final distance = _distanceToRing(point, polygon.first);
      if (distance < nearest && distance <= _coastSnap) {
        nearest = distance;
        land = polygon;
      }
    }
  }
  if (land == null) return 0;
  final ring = land.first;
  final lons = [for (var i = 0; i < ring.length; i += 2) ring[i]];
  final lats = [for (var i = 1; i < ring.length; i += 2) ring[i]];
  return math.max(
    lons.reduce(math.max) - lons.reduce(math.min),
    lats.reduce(math.max) - lats.reduce(math.min),
  );
}

/// Shortest distance, in degrees, from the point to the ring's edges.
double _distanceToRing(List<double> point, List<double> ring) {
  final (px, py) = (point[0], point[1]);
  var best = double.infinity;
  final n = ring.length ~/ 2;
  for (var i = 0, j = n - 1; i < n; j = i++) {
    final (ax, ay, bx, by) = (
      ring[2 * j],
      ring[2 * j + 1],
      ring[2 * i],
      ring[2 * i + 1],
    );
    final (dx, dy) = (bx - ax, by - ay);
    final lengthSquared = dx * dx + dy * dy;
    final t = lengthSquared == 0
        ? 0.0
        : (((px - ax) * dx + (py - ay) * dy) / lengthSquared).clamp(0.0, 1.0);
    final (cx, cy) = (ax + t * dx - px, ay + t * dy - py);
    best = math.min(best, math.sqrt(cx * cx + cy * cy));
  }
  return best;
}

/// Ray casting: an odd number of crossings means inside.
bool _inRing(List<double> point, List<double> ring) {
  final (x, y) = (point[0], point[1]);
  var inside = false;
  final n = ring.length ~/ 2;
  for (var i = 0, j = n - 1; i < n; j = i++) {
    final (xi, yi, xj, yj) = (
      ring[2 * i],
      ring[2 * i + 1],
      ring[2 * j],
      ring[2 * j + 1],
    );
    if ((yi > y) != (yj > y) && x < (xj - xi) * (y - yi) / (yj - yi) + xi) {
      inside = !inside;
    }
  }
  return inside;
}

/// A central spot on the largest polygon: horizontal lines cut it into
/// stretches of land (holes excluded); of the stretches that are reasonably
/// wide, the middle of the one nearest the polygon's centre. Used when a
/// country's capital isn't known.
List<double> _landPoint(List<_Polygon> polygons) {
  final largest = polygons.reduce(
    (a, b) => _area(a.first) >= _area(b.first) ? a : b,
  );
  final outline = largest.first;
  final lats = [for (var i = 1; i < outline.length; i += 2) outline[i]];
  final lons = [for (var i = 0; i < outline.length; i += 2) outline[i]];
  final (south, north) = (lats.reduce(math.min), lats.reduce(math.max));
  final centre = (
    (lons.reduce(math.min) + lons.reduce(math.max)) / 2,
    (south + north) / 2,
  );

  final stretches = <({double x, double y, double width})>[];
  for (var line = 1; line <= _scanLines; line++) {
    final y = south + (north - south) * line / (_scanLines + 1);
    final crossings = [
      for (final ring in largest)
        for (var i = 0, n = ring.length ~/ 2, j = n - 1; i < n; j = i++)
          if ((ring[2 * i + 1] > y) != (ring[2 * j + 1] > y))
            ring[2 * i] +
                (ring[2 * j] - ring[2 * i]) *
                    (y - ring[2 * i + 1]) /
                    (ring[2 * j + 1] - ring[2 * i + 1]),
    ]..sort();
    // Crossings pair up into stretches of land, from west to east.
    for (var k = 0; k + 1 < crossings.length; k += 2) {
      stretches.add((
        x: (crossings[k] + crossings[k + 1]) / 2,
        y: y,
        width: crossings[k + 1] - crossings[k],
      ));
    }
  }
  if (stretches.isEmpty) return [outline[0], outline[1]];

  final widest = stretches.map((s) => s.width).reduce(math.max);
  double distance(({double x, double y, double width}) s) =>
      math.pow(s.x - centre.$1, 2) + math.pow(s.y - centre.$2, 2).toDouble();
  final chosen = stretches
      .where((s) => s.width >= widest * _minWidthShare)
      .reduce((a, b) => distance(a) <= distance(b) ? a : b);
  return [chosen.x, chosen.y];
}

/// Shoelace formula, in square degrees.
double _area(List<double> ring) {
  var sum = 0.0;
  final n = ring.length ~/ 2;
  for (var i = 0, j = n - 1; i < n; j = i++) {
    sum += ring[2 * j] * ring[2 * i + 1] - ring[2 * i] * ring[2 * j + 1];
  }
  return sum.abs() / 2;
}

/// The ring flattened and rounded, without consecutive duplicate points, or
/// null if fewer than three distinct points remain.
List<double>? _flatRing(List<dynamic> ring) {
  final out = <double>[];
  double? prevLon;
  double? prevLat;
  for (final point in ring.cast<List<dynamic>>()) {
    final lon = _round((point[0] as num).toDouble());
    final lat = _round((point[1] as num).toDouble());
    if (lon == prevLon && lat == prevLat) continue;
    out
      ..add(lon)
      ..add(lat);
    prevLon = lon;
    prevLat = lat;
  }
  return out.length >= 6 ? out : null;
}

double _round(double value) => double.parse(value.toStringAsFixed(_decimals));
