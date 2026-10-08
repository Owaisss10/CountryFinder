import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/providers/selected_tab_provider.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Hosts the tabs with the bottom bar: CupertinoTabBar on iOS,
/// NavigationBar on Android. Each tab keeps its own back stack.
class TabShellScreen extends ConsumerWidget {
  const TabShellScreen({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _onTap(WidgetRef ref, int index) {
    // Tapping the current tab pops it back to its root, as on iOS.
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
    ref.read(selectedTabProvider.notifier).select(AppTab.values[index]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final Widget bar;
    if (context.isCupertino) {
      bar = CupertinoTabBar(
        backgroundColor: AppColors.of(context).bar,
        currentIndex: shell.currentIndex,
        onTap: (i) => _onTap(ref, i),
        items: [
          for (final tab in AppTab.values)
            BottomNavigationBarItem(
              icon: AdaptiveIcon(tab.icon),
              activeIcon: AdaptiveIcon(tab.selectedIcon),
              label: tab.title(l10n),
            ),
        ],
      );
    } else {
      bar = NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) => _onTap(ref, i),
        destinations: [
          for (final tab in AppTab.values)
            NavigationDestination(
              icon: AdaptiveIcon(tab.icon),
              selectedIcon: AdaptiveIcon(tab.selectedIcon),
              label: tab.title(l10n),
            ),
        ],
      );
    }
    return Scaffold(body: shell, bottomNavigationBar: bar);
  }
}
