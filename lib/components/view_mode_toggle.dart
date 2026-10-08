import 'dart:math' as math;

import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_shadows.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Floating capsule at the bottom of the Countries tab that switches between
/// the list and the map. It names the view it switches to.
class ViewModeToggle extends StatelessWidget {
  const ViewModeToggle({
    super.key,
    required this.showingMap,
    required this.onPressed,
  });

  final bool showingMap;
  final VoidCallback onPressed;

  /// Approximate button height plus its bottom padding, scaled with the
  /// text, so the list's last row and the map's card can clear it.
  static double reservedHeight(BuildContext context) =>
      math.max(
        MediaQuery.textScalerOf(context).scale(ChipStyle.textLineHeight) +
            Spacing.medium * 2,
        _minHeight(context),
      ) +
      ChipStyle.bottomPadding +
      Spacing.small;

  /// The platform's minimum tap size.
  static double _minHeight(BuildContext context) => context.isCupertino
      ? kMinInteractiveDimensionCupertino
      : kMinInteractiveDimension;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppColors.of(context);
    final label = showingMap ? l10n.showList : l10n.showMap;
    return Padding(
      padding: const EdgeInsets.only(bottom: ChipStyle.bottomPadding),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          shadows: [AppShadows.floating(context)],
        ),
        child: Material(
          color: context.isCupertino
              ? colors.material
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          shape: StadiumBorder(
            side: BorderSide(
              color: colors.separator.withValues(alpha: AppOpacity.chipBorder),
              width: StrokeWidth.hairline,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            key: const ValueKey('view-mode-toggle'),
            onTap: onPressed,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: _minHeight(context)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.xLarge,
                  vertical: Spacing.medium,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AdaptiveIcon(
                      showingMap ? AppIcon.listBullet : AppIcon.map,
                      size: IconSize.toggleIcon,
                      color: colors.accent,
                    ),
                    const SizedBox(width: Spacing.small),
                    Text(
                      label,
                      style: AppText.of(context).subheadline.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
