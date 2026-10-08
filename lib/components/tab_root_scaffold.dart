import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/components/title_bar_search.dart';
import 'package:country_finder/components/material_search_header.dart';
import 'package:country_finder/components/cupertino_search_title_bar.dart';
import 'package:country_finder/components/adaptive_large_title_bar.dart';
import 'package:country_finder/components/countries_list_state_view.dart';
import 'package:country_finder/components/empty_state_view.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Large-title bar (optionally with a search field), a row counting what's
/// listed, and the shared list state view.
class TabRootScaffold extends StatelessWidget {
  const TabRootScaffold({
    super.key,
    required this.tab,
    required this.countText,
    required this.countries,
    required this.emptyState,
    this.trailing,
    this.search,
  });

  final AppTab tab;
  final String countText;
  final List<Country> countries;
  final EmptyStateContent emptyState;
  final Widget? trailing;

  /// When set, the title bar hosts a search field: built into the large
  /// title on iOS, a bar under it on Android.
  final TitleBarSearch? search;

  @override
  Widget build(BuildContext context) {
    final title = tab.title(AppLocalizations.of(context));
    return ColoredBox(
      color: AppColors.of(context).background,
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          if (search case final search? when context.isCupertino)
            CupertinoSearchTitleBar(
              title: title,
              trailing: trailing,
              search: search,
            )
          else
            AdaptiveLargeTitleBar(title: title, trailing: trailing),
          if (search case final search? when !context.isCupertino)
            MaterialSearchHeader(search: search),
          SliverToBoxAdapter(child: _CountRow(text: countText)),
          CountriesListStateView(
            countries: countries,
            emptyState: emptyState,
            onSelect: (country) =>
                context.push(tab.detailPath(country.alpha3Code)),
          ),
        ],
      ),
    );
  }
}

/// "x countries", or "x of y countries" while searching.
class _CountRow extends StatelessWidget {
  const _CountRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Spacing.large,
        Spacing.xSmall,
        Spacing.large,
        Spacing.small,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppText.of(
          context,
        ).footnote.copyWith(color: AppColors.of(context).secondaryLabel),
      ),
    );
  }
}
