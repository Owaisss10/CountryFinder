import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_shadows.dart';
import 'package:flutter/widgets.dart';

/// A small star badge marking a favorite on the map: on a favorite's pin,
/// or on a cluster with at least one favorite inside. Decorative; the pin or
/// cluster announces it to screen readers.
class FavoriteBadge extends StatelessWidget {
  const FavoriteBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      width: MapStyle.favoriteBadgeSize,
      height: MapStyle.favoriteBadgeSize,
      decoration: BoxDecoration(
        color: colors.system(SystemTint.yellow),
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.background,
          width: MapStyle.favoriteBadgeRing,
        ),
        boxShadow: [AppShadows.floating(context)],
      ),
      child: Center(
        child: AdaptiveIcon(
          AppIcon.starFill,
          size: MapStyle.favoriteBadgeIconSize,
          color: colors.onTint,
        ),
      ),
    );
  }
}
