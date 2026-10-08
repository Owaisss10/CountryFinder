import 'package:country_finder/components/flag_image.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/screens/map/favorite_badge.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_shadows.dart';
import 'package:flutter/widgets.dart';

/// A country's pin: its flag in a frame with a pointer underneath, whose tip
/// marks the location. A favorite gets a star badge on the frame's top-right
/// corner. While selected, the pin turns the accent color and grows from its
/// tip.
class CountryMarker extends StatelessWidget {
  const CountryMarker({
    super.key,
    required this.country,
    required this.selected,
    required this.favorite,
    required this.onTap,
  });

  /// The marker's size, for placing it on the map.
  static const double width =
      MapStyle.markerFlagWidth + MapStyle.markerBorder * 2;
  static const double height =
      MapStyle.markerFlagHeight +
      MapStyle.markerBorder * 2 +
      MapStyle.pinPointerHeight;

  final Country country;
  final bool selected;
  final bool favorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    const badgeOverhang = MapStyle.favoriteBadgeSize / 2;
    return Semantics(
      button: true,
      selected: selected,
      label: favorite
          ? AppLocalizations.of(context).mapFavoritePin(country.name)
          : country.name,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          scale: selected ? MapStyle.selectedPinScale : 1,
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : AppAnimation.pinSelect,
          // The tip stays on the location while the pin grows.
          alignment: Alignment.bottomCenter,
          child: Stack(
            // The badge straddles the frame's corner, half outside it.
            clipBehavior: Clip.none,
            children: [
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: selected ? colors.accent : colors.background,
                  shape: const _PinShape(),
                  shadows: [AppShadows.floating(context)],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    MapStyle.markerBorder,
                    MapStyle.markerBorder,
                    MapStyle.markerBorder,
                    MapStyle.markerBorder + MapStyle.pinPointerHeight,
                  ),
                  child: FlagImage(
                    url: country.flagPng,
                    svgUrl: country.flagSvg,
                    width: MapStyle.markerFlagWidth,
                    height: MapStyle.markerFlagHeight,
                  ),
                ),
              ),
              if (favorite)
                const Positioned(
                  top: -badgeOverhang,
                  right: -badgeOverhang,
                  child: FavoriteBadge(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A rounded frame with a triangular pointer centred under it. The frame's
/// corners follow the flag's, plus the frame's own width.
class _PinShape extends ShapeBorder {
  const _PinShape();

  static const _radius = Radius.circular(
    CornerRadius.small + MapStyle.markerBorder,
  );

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final frame = Rect.fromLTRB(
      rect.left,
      rect.top,
      rect.right,
      rect.bottom - MapStyle.pinPointerHeight,
    );
    final halfPointer = MapStyle.pinPointerWidth / 2;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(frame, _radius))
      ..moveTo(frame.center.dx - halfPointer, frame.bottom)
      ..lineTo(frame.center.dx, rect.bottom)
      ..lineTo(frame.center.dx + halfPointer, frame.bottom)
      ..close();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
