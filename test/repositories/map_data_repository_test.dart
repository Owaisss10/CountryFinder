import 'dart:io';

import 'package:country_finder/repositories/map_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  test('parses outlines with holes, and pin spots', () {
    const json =
        '{"shapes":[{"c":"AAA",'
        '"p":[[[0,0,10,0,10,10],[2,2,4,2,4,4]],[[20,20,21,20,21,21]]]}],'
        '"pins":{"AAA":[5,3,10]}}';
    final data = parseMapData(json);
    final shape = data.shapes.single;
    expect(shape.code, 'AAA');
    expect(shape.polygons, hasLength(2));
    final [outline, hole] = shape.polygons.first;
    expect(outline, [
      const LatLng(0, 0),
      const LatLng(0, 10),
      const LatLng(10, 10),
    ]);
    expect(hole.first, const LatLng(2, 2));
    expect(data.pins['AAA']?.point, const LatLng(3, 5));
    expect(data.pins['AAA']?.landSize, 10);
  });

  group('the bundled map data', () {
    final data = parseMapData(
      File(AssetMapDataRepository.assetPath).readAsStringSync(),
    );

    test('has drawable outlines with countries.dev\'s codes', () {
      expect(data.shapes, hasLength(242));
      expect(
        data.shapes.map((s) => s.code),
        containsAll(['FRA', 'AUS', 'ALA', 'PSE', 'SSD', 'ESH', 'UNK']),
      );
      for (final shape in data.shapes) {
        for (final polygon in shape.polygons) {
          expect(polygon.first.length, greaterThanOrEqualTo(3));
        }
      }
    });

    test('puts pins at capitals', () {
      // Every country in the saved API response has a pin, except the US
      // Minor Outlying Islands, which have no capital, outline or
      // coordinates.
      expect(data.pins, hasLength(249));
      void expectNear(String code, double lat, double lng) {
        final point = data.pins[code]?.point;
        expect(point, isNotNull, reason: code);
        expect(point!.latitude, closeTo(lat, 0.2), reason: code);
        expect(point.longitude, closeTo(lng, 0.2), reason: code);
      }

      expectNear('FRA', 48.86, 2.35); // Paris
      expectNear('USA', 38.9, -77.04); // Washington
      expectNear('AUS', -35.28, 149.13); // Canberra
      expectNear('NZL', -41.29, 174.78); // Wellington
      expectNear('DNK', 55.68, 12.57); // Copenhagen, "København" in the data
      expectNear('BDI', -3.43, 29.92); // Gitega, not the old Bujumbura
      expectNear('BOL', -19.04, -65.26); // Sucre, as countries.dev lists it
    });

    test('knows how big the land under each pin is', () {
      expect(data.pins['USA']!.landSize, greaterThan(40));
      expect(data.pins['MLT']!.landSize, lessThan(1)); // Malta
      expect(data.pins['TKL']!.landSize, 0); // Tokelau: no outline
    });
  });
}
