import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/screens/all_countries_screen.dart';
import 'package:country_finder/screens/country_detail/country_detail_screen.dart';
import 'package:country_finder/screens/favorites_screen.dart';
import 'package:country_finder/screens/tab_shell_screen.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// The root screen of each tab.
Widget tabRoot(AppTab tab) => switch (tab) {
  AppTab.countries => const AllCountriesScreen(),
  AppTab.favorites => const FavoritesScreen(),
};

/// iOS pages carry a title so the next screen's back button can show it.
Page<void> _page(
  BuildContext context,
  GoRouterState state,
  Widget child, {
  String? title,
}) {
  if (context.isCupertino) {
    return CupertinoPage(key: state.pageKey, title: title, child: child);
  }
  return MaterialPage(key: state.pageKey, child: child);
}

GoRoute _detailRoute(AppTab tab) => GoRoute(
  path: 'country/:alpha3Code',
  // On the root navigator so the tab bar is hidden. Neighbours push
  // further detail pages onto the same stack.
  parentNavigatorKey: rootNavigatorKey,
  pageBuilder: (context, state) {
    final code = state.pathParameters['alpha3Code'] ?? '';
    return _page(
      context,
      state,
      CountryDetailScreen(alpha3Code: code, tab: tab),
    );
  },
);

/// One branch per tab, so each tab keeps its own back stack.
GoRouter createRouter() => GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppTab.countries.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => TabShellScreen(shell: shell),
      branches: [
        for (final tab in AppTab.values)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: tab.path,
                pageBuilder: (context, state) => _page(
                  context,
                  state,
                  tabRoot(tab),
                  title: tab.title(AppLocalizations.of(context)),
                ),
                routes: [_detailRoute(tab)],
              ),
            ],
          ),
      ],
    ),
  ],
);
