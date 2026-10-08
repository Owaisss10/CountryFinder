import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/theme/app_icons.dart';

/// The bottom-bar tabs, in display order, and their routes.
enum AppTab {
  countries('/countries'),
  favorites('/favorites');

  const AppTab(this.path);

  final String path;

  /// A country's detail route inside this tab's stack,
  /// e.g. `/countries/country/FRA`.
  String detailPath(String alpha3Code) => '$path/country/$alpha3Code';

  String title(AppLocalizations l10n) => switch (this) {
    countries => l10n.tabCountries,
    favorites => l10n.tabFavorites,
  };

  /// Shown while the tab isn't selected.
  AppIcon get icon => switch (this) {
    countries => AppIcon.flag,
    favorites => AppIcon.star,
  };

  /// Shown while the tab is selected: the filled version.
  AppIcon get selectedIcon => switch (this) {
    countries => AppIcon.flagFill,
    favorites => AppIcon.starFill,
  };
}
