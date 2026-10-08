import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/country_row_view.dart';
import 'package:country_finder/components/empty_state_view.dart';
import 'package:country_finder/components/error_view.dart';
import 'package:country_finder/components/loading_view.dart';
import 'package:country_finder/components/offline_banner.dart';
import 'package:country_finder/components/view_mode_toggle.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/favorites_provider.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Loading / error / empty / list states shared by the tabs, built as
/// a sliver so it sits under each tab's large-title bar.
class CountriesListStateView extends ConsumerStatefulWidget {
  const CountriesListStateView({
    super.key,
    required this.countries,
    required this.emptyState,
    required this.onSelect,
  });

  final List<Country> countries;
  final EmptyStateContent emptyState;
  final ValueChanged<Country> onSelect;

  @override
  ConsumerState<CountriesListStateView> createState() =>
      _CountriesListStateViewState();
}

class _CountriesListStateViewState
    extends ConsumerState<CountriesListStateView> {
  @override
  void initState() {
    super.initState();
    // Deferred: providers can't be modified while the tree is building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ref.read(countriesListProvider).countries.isEmpty) {
        ref.read(countriesListProvider.notifier).load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final viewState = ref.watch(
      countriesListProvider.select((s) => s.viewState),
    );
    final notifier = ref.read(countriesListProvider.notifier);

    switch (viewState) {
      case ViewLoading():
        return SliverFillRemaining(
          hasScrollBody: false,
          child: LoadingView(message: l10n.loadingCountries),
        );
      case ViewFailed(:final error):
        return SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorView(
            message: error.message(l10n),
            onRetry: notifier.retry,
          ),
        );
      case ViewLoaded() when widget.countries.isEmpty:
        return SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyStateView(
            icon: widget.emptyState.icon,
            title: widget.emptyState.title(l10n),
            message: widget.emptyState.message(l10n),
          ),
        );
      case ViewLoaded():
        return _LoadedList(
          countries: widget.countries,
          onSelect: widget.onSelect,
        );
    }
  }
}

class _LoadedList extends ConsumerWidget {
  const _LoadedList({required this.countries, required this.onSelect});

  final List<Country> countries;
  final ValueChanged<Country> onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(
      countriesListProvider.select((s) => s.isOffline),
    );
    final cacheDate = ref.watch(
      countriesListProvider.select((s) => s.cacheDate),
    );

    return SliverMainAxisGroup(
      slivers: [
        if (isOffline)
          PinnedHeaderSliver(
            child: OfflineBanner(
              cacheDate: cacheDate,
              onRetry: ref.read(countriesListProvider.notifier).retry,
            ),
          ),
        SliverList.separated(
          itemCount: countries.length,
          itemBuilder: (context, index) => _SwipeableRow(
            key: ValueKey(countries[index].alpha3Code),
            country: countries[index],
            onTap: () => onSelect(countries[index]),
          ),
          separatorBuilder: (context, _) => Divider(
            height: StrokeWidth.hairline,
            thickness: StrokeWidth.hairline,
            indent: ListRow.dividerIndent,
            color: AppColors.of(context).separator,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: ViewModeToggle.reservedHeight(context)),
        ),
      ],
    );
  }
}

class _SwipeableRow extends ConsumerWidget {
  const _SwipeableRow({super.key, required this.country, required this.onTap});

  final Country country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isFavorite = ref.watch(
      favoritesProvider.select((s) => s.isFavorite(country.alpha3Code)),
    );
    final colors = AppColors.of(context);
    final row = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.large,
        vertical: Spacing.xSmall,
      ),
      child: Row(
        children: [
          Expanded(child: CountryRowView(country: country)),
          if (context.isCupertino)
            AdaptiveIcon(
              AppIcon.chevronRight,
              size: ListRow.disclosureSize,
              color: colors.tertiaryLabel,
            ),
        ],
      ),
    );

    return Slidable(
      key: ValueKey('slidable-${country.alpha3Code}'),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: ListRow.swipeActionExtentRatio,
        children: [
          SlidableAction(
            onPressed: (_) =>
                ref.read(favoritesProvider.notifier).toggle(country.alpha3Code),
            backgroundColor: colors.system(SystemTint.yellow),
            foregroundColor: colors.onTint,
            icon: (isFavorite ? AppIcon.starSlashFill : AppIcon.starFill).of(
              context,
            ),
            label: isFavorite ? l10n.unfavoriteAction : l10n.favoriteAction,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          splashFactory: context.isCupertino ? NoSplash.splashFactory : null,
          child: row,
        ),
      ),
    );
  }
}
