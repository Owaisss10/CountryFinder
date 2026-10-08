// The single source of layout values. Most are copied 1:1 from the iOS app's
// Constants.swift; the rest cover Flutter-only details. Widgets use these
// instead of inline numbers.

abstract final class Spacing {
  static const double none = 0;
  static const double xxSmall = 2;
  static const double xSmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double xLarge = 24;

  /// Default screen padding (SwiftUI's default `.padding()`).
  static const double screen = 16;
}

abstract final class CornerRadius {
  static const double small = 4;
  static const double medium = 8;
  static const double large = 14;
}

abstract final class IconSize {
  static const double flagWidth = 40;
  static const double flagHeight = 28;
  static const double stateIcon = 40;
  static const double factBadge = 36;
  static const double detailFlagWidth = 140;
  static const double detailFlagHeight = 98;
  static const double weatherIcon = 28;
  static const double toggleIcon = 20;

  /// The tinted symbol inside a fact badge.
  static const double factBadgeIcon = 18;

  /// The up/down chevron next to the active field in the sort menu.
  static const double sortDirection = 16;

  /// Placeholder icon size as a fraction of the flag's height.
  static const double flagPlaceholderScale = 0.5;
}

/// The search bar on Android, at Material's standard height.
abstract final class SearchStyle {
  static const double materialBarHeight = 56;
}

/// The Map tab: camera limits and marker sizes.
abstract final class MapStyle {
  /// The camera starts here, showing Europe, Africa and much of Asia.
  static const double initialLatitude = 20;
  static const double initialLongitude = 10;
  static const double initialZoom = 2;
  static const double minZoom = 1;

  /// Country level: the bundled outlines are simplified, so closer zoom
  /// would show blocky coastlines.
  static const double maxZoom = 6;

  /// How far one tap on a zoom button zooms.
  static const double zoomStep = 1;

  /// After a pin is selected, the map pans until the pin's tip is at least
  /// this far above its card.
  static const double pinRevealMargin = Spacing.large;

  /// Each zoom button is at least iOS's minimum tap size.
  static const double zoomButtonSize = 44;

  /// Flag markers keep the list's 10:7 flag proportions.
  static const double markerFlagWidth = 30;
  static const double markerFlagHeight = 21;

  /// The ring around a marker: the background color, or the accent when
  /// selected.
  static const double markerBorder = 2;

  /// The pointer under a pin's flag; its tip marks the country's location.
  static const double pinPointerWidth = 10;
  static const double pinPointerHeight = 6;

  /// The star badge on a favorite's pin, and on a cluster containing one.
  static const double favoriteBadgeSize = 16;
  static const double favoriteBadgeIconSize = 10;
  static const double favoriteBadgeRing = 1.5;

  /// How much the selected pin grows, from its tip.
  static const double selectedPinScale = 1.25;

  /// Every pin also sits on a small land-colored dot. Real land drawn over it
  /// hides it; for islands too small to see at the current zoom, the dot
  /// shows them instead.
  static const double islandDotRadius = 4;

  /// Diameter of the circle that counts grouped markers.
  static const double clusterSize = 40;

  /// Markers closer than this many pixels are grouped into one circle.
  static const int clusterRadius = 45;
}

/// Activity indicator diameters. Material's default spinner is drawn larger
/// than iOS's.
abstract final class ProgressSize {
  static const double small = 14;

  /// iOS: the default `CupertinoActivityIndicator` size.
  static const double regular = 20;
  static const double regularMaterial = 32;

  static const double smallStroke = 2;
  static const double regularStroke = 4;
}

abstract final class StrokeWidth {
  static const double hairline = 0.5;
}

abstract final class AppOpacity {
  static const double chipBorder = 0.5;
  static const double chipShadow = 0.12;
  static const double factBadgeTint = 0.15;
  static const double bannerBackgroundTint = 0.2;
  static const double skeletonPulseLow = 0.5;

  /// The translucent "thinMaterial" fill on iOS.
  static const double materialFill = 0.7;
}

abstract final class AppAnimation {
  static const Duration skeletonPulse = Duration(milliseconds: 800);
  static const Duration mapZoom = Duration(milliseconds: 250);
  static const Duration mapPan = Duration(milliseconds: 250);
  static const Duration pinSelect = Duration(milliseconds: 150);
}

abstract final class SkeletonSize {
  static const double primaryLineWidth = 70;
  static const double primaryLineHeight = 24;
  static const double secondaryLineWidth = 120;
  static const double secondaryLineHeight = 14;
}

abstract final class ChipStyle {
  static const double shadowBlur = 8;
  static const double shadowOffsetY = 2;
  static const double bottomPadding = Spacing.small;

  /// Line height of the chip's footnote text at 1x text scale, used to
  /// reserve room under the list so the last row can scroll clear of it.
  static const double textLineHeight = 20;
}

abstract final class ListRow {
  /// Leading inset of row dividers: row padding + flag + spacing.
  static const double dividerIndent =
      Spacing.large + IconSize.flagWidth + Spacing.medium;
  static const double disclosureSize = 14;
  static const double swipeActionExtentRatio = 0.25;
}

/// Leading inset of the dividers between fact rows: row padding + badge + spacing.
const double factRowDividerInset =
    Spacing.medium + IconSize.factBadge + Spacing.medium;

/// Blur radius of the translucent "thinMaterial" cards on iOS.
const double materialBlurSigma = 20;
