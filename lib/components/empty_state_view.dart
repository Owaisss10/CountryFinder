import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    this.message,
  });

  final AppIcon icon;
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final text = AppText.of(context);
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Spacing.medium,
          children: [
            AdaptiveIcon(
              icon,
              size: IconSize.stateIcon,
              color: colors.secondaryLabel,
            ),
            Text(title, style: text.headline, textAlign: TextAlign.center),
            if (message case final message?)
              Text(
                message,
                textAlign: TextAlign.center,
                style: text.subheadline.copyWith(color: colors.secondaryLabel),
              ),
          ],
        ),
      ),
    );
  }
}

/// Per-tab content of the empty list state.
enum EmptyStateContent {
  noCountries,
  noSearchResults,
  noFavorites;

  AppIcon get icon => switch (this) {
    noCountries => AppIcon.globe,
    noSearchResults => AppIcon.search,
    noFavorites => AppIcon.star,
  };

  String title(AppLocalizations l10n) => switch (this) {
    noCountries => l10n.emptyCountriesTitle,
    noSearchResults => l10n.emptySearchTitle,
    noFavorites => l10n.emptyFavoritesTitle,
  };

  String message(AppLocalizations l10n) => switch (this) {
    noCountries => l10n.emptyCountriesMessage,
    noSearchResults => l10n.emptySearchMessage,
    noFavorites => l10n.emptyFavoritesMessage,
  };
}
