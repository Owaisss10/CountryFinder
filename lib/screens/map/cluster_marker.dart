import 'dart:math' as math;

import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/screens/map/favorite_badge.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_shadows.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/widgets.dart';

/// A circle standing in for nearby pins, showing how many it groups, with a
/// star badge if any of them is a favorite. Tapping it zooms in until the
/// pins separate.
class ClusterMarker extends StatelessWidget {
  const ClusterMarker({
    super.key,
    required this.count,
    required this.hasFavorite,
  });

  final int count;
  final bool hasFavorite;

  /// How far the circle's north-east edge sits in from its box's corner.
  static const double _edgeInset =
      MapStyle.clusterSize / 2 * (1 - math.sqrt1_2);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context);
    const badgeOffset = _edgeInset - MapStyle.favoriteBadgeSize / 2;
    final circle = DecoratedBox(
      decoration: BoxDecoration(
        color: colors.accent,
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.background,
          width: MapStyle.markerBorder,
        ),
        boxShadow: [AppShadows.floating(context)],
      ),
      child: Center(
        child: Text(
          '$count',
          style: AppText.of(context).footnote.copyWith(
            color: colors.onAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
    return Semantics(
      label: hasFavorite
          ? l10n.mapClusterWithFavorites(count)
          : l10n.countriesCount(count),
      excludeSemantics: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: circle),
          // Centred on the circle's north-east edge.
          if (hasFavorite)
            const Positioned(
              top: badgeOffset,
              right: badgeOffset,
              child: FavoriteBadge(),
            ),
        ],
      ),
    );
  }
}
