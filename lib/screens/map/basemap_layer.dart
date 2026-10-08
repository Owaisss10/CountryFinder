import 'package:country_finder/core/constants.dart';
import 'package:country_finder/models/map_data.dart';
import 'package:country_finder/providers/country_map_provider.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The map itself: every country's land with hairline borders, drawn in the
/// theme's colors from the bundled outlines. The sea is the map's background.
class BasemapLayer extends ConsumerStatefulWidget {
  const BasemapLayer({super.key});

  @override
  ConsumerState<BasemapLayer> createState() => _BasemapLayerState();
}

class _BasemapLayerState extends ConsumerState<BasemapLayer> {
  // Building ~300 polygons is cheap, but a new list makes the layer
  // re-project every point, so it's only rebuilt when its inputs change.
  List<Polygon> _polygons = const [];
  (List<CountryShape>, Color, Color)? _builtFrom;

  @override
  Widget build(BuildContext context) {
    final shapes =
        ref.watch(mapDataProvider).value?.shapes ?? const <CountryShape>[];
    final colors = AppColors.of(context);
    final inputs = (shapes, colors.mapLand, colors.mapBorder);
    if (inputs != _builtFrom) {
      _builtFrom = inputs;
      _polygons = [
        for (final shape in shapes)
          for (final polygon in shape.polygons)
            Polygon(
              points: polygon.first,
              holePointsList: polygon.length > 1 ? polygon.sublist(1) : null,
              color: colors.mapLand,
              borderColor: colors.mapBorder,
              borderStrokeWidth: StrokeWidth.hairline,
            ),
      ];
    }
    return PolygonLayer(polygons: _polygons);
  }
}
