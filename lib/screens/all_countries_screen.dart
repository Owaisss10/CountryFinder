import 'package:country_finder/components/empty_state_view.dart';
import 'package:country_finder/components/list_map_switcher.dart';
import 'package:country_finder/components/sort_menu_button.dart';
import 'package:country_finder/components/tab_root_scaffold.dart';
import 'package:country_finder/components/title_bar_search.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/providers/search_query_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Every country, sortable and searchable from the bar under the title, or
/// shown on the map. A floating button switches between the two.
class AllCountriesScreen extends ConsumerStatefulWidget {
  const AllCountriesScreen({super.key});

  @override
  ConsumerState<AllCountriesScreen> createState() => _AllCountriesScreenState();
}

class _AllCountriesScreenState extends ConsumerState<AllCountriesScreen> {
  late final TextEditingController _controller = TextEditingController(
    text: ref.read(searchQueryProvider),
  );
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String query) =>
      ref.read(searchQueryProvider.notifier).update(query);

  void _cancel() {
    _controller.clear();
    _onChanged('');
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = ref.watch(searchQueryProvider);
    final countries = ref.watch(filteredCountriesProvider(query));
    final total = ref.watch(
      countriesListProvider.select((s) => s.countries.length),
    );
    final searching = query.isNotEmpty;
    return ListMapSwitcher(
      tab: AppTab.countries,
      countries: countries,
      list: TabRootScaffold(
        tab: AppTab.countries,
        countText: searching
            ? l10n.filteredOfTotalCountries(countries.length, total)
            : l10n.countriesCount(total),
        countries: countries,
        emptyState: searching
            ? EmptyStateContent.noSearchResults
            : EmptyStateContent.noCountries,
        trailing: const SortMenuButton(),
        search: TitleBarSearch(
          controller: _controller,
          focusNode: _focusNode,
          placeholder: l10n.searchPlaceholder,
          onChanged: _onChanged,
          onCancel: _cancel,
        ),
      ),
    );
  }
}
