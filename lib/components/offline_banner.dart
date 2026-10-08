import 'package:country_finder/components/adaptive_button.dart';
import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/shared/relative_date.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';

/// Shown pinned above the list whenever the data came from the cache.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    super.key,
    required this.cacheDate,
    required this.onRetry,
    this.now = DateTime.now,
  });

  final DateTime? cacheDate;
  final VoidCallback onRetry;
  final DateTime Function() now;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = AppText.of(context);
    final colors = AppColors.of(context);
    final date = cacheDate;
    final message = date == null
        ? l10n.offlineSaved
        : l10n.offlineSavedAt(relativeDate(l10n, date, now()));
    return ColoredBox(
      // Opaque base so rows don't show through the tinted, pinned banner.
      color: colors.background,
      child: ColoredBox(
        color: colors
            .system(SystemTint.yellow)
            .withValues(alpha: AppOpacity.bannerBackgroundTint),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.medium,
            vertical: Spacing.small,
          ),
          child: Row(
            spacing: Spacing.small,
            children: [
              AdaptiveIcon(
                AppIcon.wifiSlash,
                size: text.footnote.fontSize,
                color: colors.label,
              ),
              Expanded(
                child: Text(
                  message,
                  style: text.footnote.copyWith(color: colors.label),
                ),
              ),
              AdaptiveButton(
                onPressed: onRetry,
                child: Text(
                  l10n.retry,
                  style: text.footnote.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
