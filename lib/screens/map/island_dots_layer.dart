import 'package:country_finder/core/constants.dart';
import 'package:country_finder/providers/country_map_provider.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Small land-colored dots under pins whose land is too small to see at the
/// current zoom (or isn't in the outlines at all), so every pin points at
/// land. Drawn *under* the basemap, and dropped once the land is bigger than
/// the dot, so the real coastline takes over as you zoom in.
class IslandDotsLayer extends ConsumerWidget {
  const IslandDotsLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pins = ref.watch(mapPinsProvider);
    final camera = MapCamera.of(context);
    // Pixels per degree of longitude at this zoom.
    final pixelsPerDegree = camera.crs.scale(camera.zoom) / 360;
    final colors = AppColors.of(context);
    return CircleLayer(
      circles: [
        for (final pin in pins)
          if (pin.landSize * pixelsPerDegree < MapStyle.islandDotRadius * 2)
            CircleMarker(
              point: pin.point,
              radius: MapStyle.islandDotRadius,
              color: colors.mapLand,
              borderColor: colors.mapBorder,
              borderStrokeWidth: StrokeWidth.hairline,
            ),
      ],
    );
  }
}
