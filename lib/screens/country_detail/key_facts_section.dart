import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/material_card.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/screens/country_detail/section_heading.dart';
import 'package:country_finder/shared/country_formatter.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';

class _Fact {
  const _Fact(this.icon, this.tint, this.label, this.value);

  final AppIcon icon;
  final SystemTint tint;
  final String label;
  final String value;
}

class KeyFactsSection extends StatelessWidget {
  const KeyFactsSection({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = CountryFormatter(l10n);
    final c = country;
    final facts = [
      _Fact(
        AppIcon.buildingColumns,
        SystemTint.blue,
        l10n.factCapital,
        p.capital(c),
      ),
      _Fact(
        AppIcon.globeEuropeAfrica,
        SystemTint.teal,
        l10n.factRegion,
        c.region,
      ),
      _Fact(
        AppIcon.person2,
        SystemTint.green,
        l10n.factPopulation,
        p.population(c),
      ),
      _Fact(AppIcon.ruler, SystemTint.orange, l10n.factArea, p.area(c)),
      _Fact(AppIcon.chartBar, SystemTint.mint, l10n.factDensity, p.density(c)),
      _Fact(
        AppIcon.phone,
        SystemTint.pink,
        l10n.factCallingCode,
        p.callingCodes(c),
      ),
      _Fact(
        AppIcon.banknote,
        SystemTint.yellow,
        l10n.factCurrencies,
        p.currencies(c),
      ),
      _Fact(
        AppIcon.characterBubble,
        SystemTint.purple,
        l10n.factLanguages,
        p.languages(c),
      ),
      _Fact(
        AppIcon.clock,
        SystemTint.indigo,
        l10n.factTimezones,
        p.timezones(c),
      ),
      _Fact(
        AppIcon.location,
        SystemTint.red,
        l10n.factCoordinates,
        p.coordinates(c),
      ),
    ];
    final separator = AppColors.of(context).separator;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.medium,
      children: [
        SectionHeading(l10n.keyFactsAbout(c.name)),
        MaterialCard(
          child: Column(
            children: [
              for (final (index, fact) in facts.indexed) ...[
                if (index > 0)
                  Divider(
                    height: StrokeWidth.hairline,
                    thickness: StrokeWidth.hairline,
                    indent: factRowDividerInset,
                    color: separator,
                  ),
                FactRow(
                  icon: fact.icon,
                  tint: fact.tint,
                  label: fact.label,
                  value: fact.value,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class FactRow extends StatelessWidget {
  const FactRow({
    super.key,
    required this.icon,
    required this.tint,
    required this.label,
    required this.value,
  });

  final AppIcon icon;
  final SystemTint tint;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final text = AppText.of(context);
    final tintColor = colors.system(tint);
    return Padding(
      padding: const EdgeInsets.all(Spacing.medium),
      child: Row(
        spacing: Spacing.medium,
        children: [
          Container(
            width: IconSize.factBadge,
            height: IconSize.factBadge,
            decoration: BoxDecoration(
              color: tintColor.withValues(alpha: AppOpacity.factBadgeTint),
              borderRadius: BorderRadius.circular(CornerRadius.small),
            ),
            child: AdaptiveIcon(
              icon,
              color: tintColor,
              size: IconSize.factBadgeIcon,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.xxSmall,
              children: [
                Text(
                  label.toUpperCase(),
                  style: text.caption2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.secondaryLabel,
                  ),
                ),
                Text(value, style: text.headline),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
