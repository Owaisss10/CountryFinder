import 'package:country_finder/components/flag_image.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/shared/country_formatter.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    final text = AppText.of(context);
    final formatter = CountryFormatter(AppLocalizations.of(context));
    return Column(
      spacing: Spacing.medium,
      children: [
        FlagImage(
          url: country.flagPng,
          svgUrl: country.flagSvg,
          width: IconSize.detailFlagWidth,
          height: IconSize.detailFlagHeight,
        ),
        Column(
          spacing: Spacing.xxSmall,
          children: [
            Text(
              country.name,
              textAlign: TextAlign.center,
              style: text.title2.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              formatter.capital(country),
              style: text.subheadline.copyWith(
                color: AppColors.of(context).secondaryLabel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
