import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/flag_image.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/providers/favorites_provider.dart';
import 'package:country_finder/shared/country_formatter.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Flag, name (with a star when favorited) and capital.
class CountryRowView extends ConsumerWidget {
  const CountryRowView({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(
      favoritesProvider.select((s) => s.isFavorite(country.alpha3Code)),
    );
    final text = AppText.of(context);
    final colors = AppColors.of(context);
    final formatter = CountryFormatter(AppLocalizations.of(context));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xSmall),
      child: Row(
        spacing: Spacing.medium,
        children: [
          FlagImage(url: country.flagPng, svgUrl: country.flagSvg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.xxSmall,
              children: [
                Row(
                  spacing: Spacing.xxSmall,
                  children: [
                    Flexible(
                      child: Text(
                        country.name,
                        style: text.body.copyWith(color: colors.label),
                      ),
                    ),
                    if (isFavorite)
                      AdaptiveIcon(
                        AppIcon.starFill,
                        size: text.caption.fontSize,
                        color: colors.system(SystemTint.yellow),
                      ),
                  ],
                ),
                Text(
                  formatter.capital(country),
                  style: text.subheadline.copyWith(
                    color: colors.secondaryLabel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
