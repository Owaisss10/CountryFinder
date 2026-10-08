import 'package:country_finder/core/app_tab.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_tab_provider.g.dart';

/// The tab currently on screen, so tab roots can react to being shown
/// (Favorites refreshes).
@Riverpod(keepAlive: true)
class SelectedTab extends _$SelectedTab {
  @override
  AppTab build() => AppTab.countries;

  void select(AppTab tab) => state = tab;
}
