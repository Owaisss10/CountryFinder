import 'package:country_finder/core/constants.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The single source of the app's colors. Widgets ask for a role (`label`,
/// `accent`, `bar`, ...) and get the iOS system color on Cupertino or the
/// Material 3 color-scheme color on Android, resolved for light or dark mode.
/// No other file defines a color.
class AppColors {
  AppColors.of(BuildContext context)
    : _context = context,
      _cupertino = context.isCupertino,
      _scheme = Theme.of(context).colorScheme;

  /// The brand color. The Material color scheme is generated from it
  /// (theme/app_theme.dart), and [accent] comes from that scheme.
  static const Color seed = Colors.orange;

  final BuildContext _context;
  final bool _cupertino;
  final ColorScheme _scheme;

  Color _resolve(Color color) => CupertinoDynamicColor.resolve(color, _context);

  Color get label =>
      _cupertino ? _resolve(CupertinoColors.label) : _scheme.onSurface;

  Color get secondaryLabel => _cupertino
      ? _resolve(CupertinoColors.secondaryLabel)
      : _scheme.onSurfaceVariant;

  Color get tertiaryLabel =>
      _cupertino ? _resolve(CupertinoColors.tertiaryLabel) : _scheme.outline;

  Color get separator =>
      _cupertino ? _resolve(CupertinoColors.separator) : _scheme.outlineVariant;

  Color get background =>
      _cupertino ? _resolve(CupertinoColors.systemBackground) : _scheme.surface;

  Color get secondaryBackground => _cupertino
      ? _resolve(CupertinoColors.secondarySystemBackground)
      : _scheme.surfaceContainerHighest;

  /// Fill of the translucent "thinMaterial" surfaces (cards, count chip).
  Color get material => _cupertino
      ? _resolve(
          CupertinoColors.secondarySystemBackground,
        ).withValues(alpha: AppOpacity.materialFill)
      : _scheme.surfaceContainer;

  /// Background of the top navigation bar and the bottom tab bar.
  ///
  /// On iOS this is the Cupertino theme's own bar color. It's resolved here
  /// because Flutter doesn't adapt it to dark mode for Cupertino widgets
  /// inside a MaterialApp, which left the large-title bar light in dark mode.
  Color get bar => _cupertino
      ? _resolve(CupertinoTheme.of(_context).barBackgroundColor)
      : _scheme.surfaceContainer;

  /// Map tab: the sea, behind the countries.
  Color get mapWater => _cupertino
      ? _resolve(CupertinoColors.systemGroupedBackground)
      : _scheme.surfaceContainerLow;

  /// Map tab: land, drawn from the country outlines.
  Color get mapLand => _cupertino
      ? _resolve(CupertinoColors.secondarySystemGroupedBackground)
      : _scheme.surfaceContainerHighest;

  /// Map tab: the hairline between countries.
  Color get mapBorder => separator;

  /// The app's accent on both platforms: the theme's primary color, derived
  /// from [seed]. Cupertino widgets (tab bar, back button, action sheets)
  /// read the same color from the theme.
  Color get accent => _scheme.primary;

  /// Text and icons drawn on the [accent], like a map cluster's count.
  Color get onAccent => _scheme.onPrimary;

  /// Drop shadows, like the count chip's.
  Color get shadow => _scheme.shadow;

  /// Text and icons drawn on a [SystemTint] fill, like the swipe action.
  Color get onTint => CupertinoColors.white;

  Color system(SystemTint tint) => _resolve(tint.color);
}

/// iOS system tint colors, used on both platforms so fact badges and other
/// accents look the same everywhere.
enum SystemTint {
  blue(CupertinoColors.systemBlue),
  teal(CupertinoColors.systemTeal),
  green(CupertinoColors.systemGreen),
  orange(CupertinoColors.systemOrange),
  mint(CupertinoColors.systemMint),
  pink(CupertinoColors.systemPink),
  yellow(CupertinoColors.systemYellow),
  purple(CupertinoColors.systemPurple),
  indigo(CupertinoColors.systemIndigo),
  red(CupertinoColors.systemRed);

  const SystemTint(this.color);

  final CupertinoDynamicColor color;
}
