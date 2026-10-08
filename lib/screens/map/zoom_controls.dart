import 'dart:math' as math;

import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/floating_panel.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Zoom in and out buttons, stacked in the map's bottom-right corner. Each tap
/// zooms one level, animated unless the system asks for reduced motion.
/// Placed inside the FlutterMap so it can read and move the camera.
class ZoomControls extends StatefulWidget {
  const ZoomControls({super.key});

  @override
  State<ZoomControls> createState() => _ZoomControlsState();
}

class _ZoomControlsState extends State<ZoomControls>
    with SingleTickerProviderStateMixin {
  // Keeps a zoom that lands exactly on a limit inside the camera's bounds,
  // despite floating-point rounding.
  static const _limitTolerance = 0.001;

  late final AnimationController _animation;

  // The zoom in progress: where it started and the camera it moves.
  Tween<double>? _zoom;
  LatLng? _center;
  MapController? _controller;

  void _onTick() {
    final (zoom, center, controller) = (_zoom, _center, _controller);
    if (zoom == null || center == null || controller == null) return;
    final t = Curves.easeInOut.transform(_animation.value);
    controller.move(center, zoom.transform(t));
  }

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: AppAnimation.mapZoom,
    )..addListener(_onTick);
  }

  /// The furthest the camera can zoom out. The map keeps the world filling
  /// its height (CameraConstraint.containLatitude), so on tall screens this
  /// is above MapStyle.minZoom.
  double _minZoom(MapCamera camera) {
    final worldHeightAtZoom0 = camera.crs.scale(0);
    final fillHeight =
        math.log(camera.nonRotatedSize.height / worldHeightAtZoom0) / math.ln2;
    return math.max(MapStyle.minZoom, fillHeight) + _limitTolerance;
  }

  void _zoomBy(double delta) {
    final camera = MapCamera.of(context);
    final controller = MapController.of(context);
    final target = (camera.zoom + delta).clamp(
      _minZoom(camera),
      MapStyle.maxZoom,
    );
    if (MediaQuery.disableAnimationsOf(context)) {
      controller.move(camera.center, target);
      return;
    }
    _controller = controller;
    _center = camera.center;
    _zoom = Tween(begin: camera.zoom, end: target);
    _animation.forward(from: 0);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final camera = MapCamera.of(context);
    final zoom = camera.zoom;
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.large),
        child: FloatingPanel(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ZoomButton(
                icon: AppIcon.zoomIn,
                label: l10n.mapZoomIn,
                onPressed: zoom < MapStyle.maxZoom - _limitTolerance
                    ? () => _zoomBy(MapStyle.zoomStep)
                    : null,
              ),
              SizedBox(
                width: MapStyle.zoomButtonSize,
                child: Divider(
                  height: StrokeWidth.hairline,
                  thickness: StrokeWidth.hairline,
                  color: AppColors.of(context).separator,
                ),
              ),
              _ZoomButton(
                icon: AppIcon.zoomOut,
                label: l10n.mapZoomOut,
                onPressed: zoom > _minZoom(camera) + _limitTolerance
                    ? () => _zoomBy(-MapStyle.zoomStep)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One zoom button; disabled (and greyed) when [onPressed] is null.
class _ZoomButton extends StatelessWidget {
  const _ZoomButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final AppIcon icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final glyph = AdaptiveIcon(
      icon,
      color: onPressed == null ? colors.tertiaryLabel : colors.accent,
    );
    if (context.isCupertino) {
      return Semantics(
        button: true,
        enabled: onPressed != null,
        label: label,
        excludeSemantics: true,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          minimumSize: const Size.square(MapStyle.zoomButtonSize),
          onPressed: onPressed,
          child: glyph,
        ),
      );
    }
    return IconButton(
      tooltip: label,
      onPressed: onPressed,
      // Same footprint as on iOS, so the selected-country card's gap for the
      // buttons fits both platforms.
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(
        width: MapStyle.zoomButtonSize,
        height: MapStyle.zoomButtonSize,
      ),
      icon: glyph,
    );
  }
}
