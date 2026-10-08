import 'package:country_finder/components/empty_state_view.dart';
import 'package:country_finder/components/list_map_switcher.dart';
import 'package:country_finder/components/tab_root_scaffold.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/providers/favorites_provider.dart';
import 'package:country_finder/providers/selected_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(favoritesProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedTabProvider, (_, tab) {
      if (tab == AppTab.favorites) {
        ref.read(favoritesProvider.notifier).refresh();
      }
    });
    final l10n = AppLocalizations.of(context);
    final favorites = ref.watch(favoritesProvider.select((s) => s.favorites));
    return ListMapSwitcher(
      tab: AppTab.favorites,
      countries: favorites,
      list: TabRootScaffold(
        tab: AppTab.favorites,
        countText: l10n.favoritesCount(favorites.length),
        countries: favorites,
        emptyState: EmptyStateContent.noFavorites,
      ),
    );
  }
}
