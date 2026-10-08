import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/country_row_view.dart';
import 'package:country_finder/components/material_card.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/providers/country_detail_provider.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NeighboursSection extends ConsumerWidget {
  const NeighboursSection({
    super.key,
    required this.alpha3Code,
    required this.tab,
  });

  final String alpha3Code;
  final AppTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neighbours = ref.watch(
      countryDetailProvider(alpha3Code).select((s) => s.neighbours),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.medium,
      children: [
        Text(
          AppLocalizations.of(context).neighbours,
          style: AppText.of(context).headline,
        ),
        if (neighbours.isEmpty)
          const _NoNeighboursCard()
        else
          Column(
            spacing: Spacing.small,
            children: [
              for (final neighbour in neighbours)
                _NeighbourCard(
                  country: neighbour,
                  onTap: () =>
                      context.push(tab.detailPath(neighbour.alpha3Code)),
                ),
            ],
          ),
      ],
    );
  }
}

/// Shown for countries without a land border.
class _NoNeighboursCard extends StatelessWidget {
  const _NoNeighboursCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = AppText.of(context);
    final colors = AppColors.of(context);
    return MaterialCard(
      padding: const EdgeInsets.all(Spacing.medium),
      child: Row(
        spacing: Spacing.medium,
        children: [
          AdaptiveIcon(AppIcon.waterWaves, color: colors.secondaryLabel),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.noLandBordersTitle,
                  style: text.subheadline.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  l10n.noLandBordersMessage,
                  style: text.caption.copyWith(color: colors.secondaryLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A neighbouring country; tapping it opens its detail screen.
class _NeighbourCard extends StatelessWidget {
  const _NeighbourCard({required this.country, required this.onTap});

  final Country country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: MaterialCard(
          padding: const EdgeInsets.all(Spacing.small),
          child: Row(
            children: [
              Expanded(child: CountryRowView(country: country)),
              AdaptiveIcon(
                AppIcon.chevronRight,
                size: ListRow.disclosureSize,
                color: AppColors.of(context).tertiaryLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
