import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/adaptive_large_title_bar.dart';
import 'package:country_finder/components/empty_state_view.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/providers/country_detail_provider.dart';
import 'package:country_finder/providers/favorites_provider.dart';
import 'package:country_finder/screens/country_detail/detail_header.dart';
import 'package:country_finder/screens/country_detail/key_facts_section.dart';
import 'package:country_finder/screens/country_detail/neighbours_section.dart';
import 'package:country_finder/screens/country_detail/weather_section.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryDetailScreen extends ConsumerStatefulWidget {
  const CountryDetailScreen({
    super.key,
    required this.alpha3Code,
    required this.tab,
  });

  final String alpha3Code;

  /// The tab whose stack this screen lives in; neighbours push onto it.
  final AppTab tab;

  @override
  ConsumerState<CountryDetailScreen> createState() =>
      _CountryDetailScreenState();
}

class _CountryDetailScreenState extends ConsumerState<CountryDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final notifier = ref.read(
        countryDetailProvider(widget.alpha3Code).notifier,
      );
      if (ref.read(countryDetailProvider(widget.alpha3Code)).country != null) {
        notifier.loadWeather();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final country = ref.watch(
      countryDetailProvider(widget.alpha3Code).select((s) => s.country),
    );
    final colors = AppColors.of(context);

    if (country == null) {
      return Scaffold(
        backgroundColor: colors.background,
        body: CustomScrollView(
          slivers: [
            const AdaptiveLargeTitleBar(title: ''),
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyStateView(
                icon: AppIcon.questionmarkCircle,
                title: l10n.countryNotFound,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          AdaptiveLargeTitleBar(
            title: country.name,
            trailing: _FavoriteButton(alpha3Code: country.alpha3Code),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.all(Spacing.screen),
              sliver: SliverList.list(
                children: [
                  DetailHeader(country: country),
                  const SizedBox(height: Spacing.xLarge),
                  WeatherSection(alpha3Code: widget.alpha3Code),
                  const SizedBox(height: Spacing.xLarge),
                  KeyFactsSection(country: country),
                  const SizedBox(height: Spacing.xLarge),
                  NeighboursSection(
                    alpha3Code: widget.alpha3Code,
                    tab: widget.tab,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends ConsumerWidget {
  const _FavoriteButton({required this.alpha3Code});

  final String alpha3Code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(
      favoritesProvider.select((s) => s.isFavorite(alpha3Code)),
    );
    final l10n = AppLocalizations.of(context);
    final icon = AdaptiveIcon(
      isFavorite ? AppIcon.starFill : AppIcon.star,
      color: AppColors.of(context).system(SystemTint.yellow),
    );
    void toggle() => ref.read(favoritesProvider.notifier).toggle(alpha3Code);
    final tooltip = isFavorite ? l10n.unfavoriteAction : l10n.favoriteAction;
    if (context.isCupertino) {
      return Semantics(
        button: true,
        label: tooltip,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          onPressed: toggle,
          child: icon,
        ),
      );
    }
    return IconButton(onPressed: toggle, tooltip: tooltip, icon: icon);
  }
}
