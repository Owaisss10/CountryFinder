import 'package:country_finder/shared/platform.dart';
import 'package:flutter/material.dart';

/// iOS text styles (Dynamic Type sizes at the default setting) on Cupertino,
/// the nearest Material 3 roles on Android.
class AppText {
  AppText.of(BuildContext context)
    : _cupertino = context.isCupertino,
      _theme = Theme.of(context).textTheme;

  final bool _cupertino;
  final TextTheme _theme;

  TextStyle _ios(double size, [FontWeight weight = FontWeight.w400]) =>
      TextStyle(fontSize: size, fontWeight: weight, letterSpacing: -0.2);

  TextStyle get body =>
      _cupertino ? _ios(17) : (_theme.bodyLarge ?? const TextStyle());
  TextStyle get headline => _cupertino
      ? _ios(17, FontWeight.w600)
      : (_theme.titleMedium ?? const TextStyle());
  TextStyle get subheadline =>
      _cupertino ? _ios(15) : (_theme.bodyMedium ?? const TextStyle());
  TextStyle get footnote =>
      _cupertino ? _ios(13) : (_theme.bodySmall ?? const TextStyle());
  TextStyle get caption =>
      _cupertino ? _ios(12) : (_theme.labelMedium ?? const TextStyle());
  TextStyle get caption2 =>
      _cupertino ? _ios(11) : (_theme.labelSmall ?? const TextStyle());
  TextStyle get title2 =>
      _cupertino ? _ios(22) : (_theme.headlineSmall ?? const TextStyle());
}
