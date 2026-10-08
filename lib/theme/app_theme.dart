import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The light or dark app theme: Material 3 for Android widgets, with the
/// Cupertino override keeping iOS widgets in the same brightness. Every
/// color comes from [AppColors].
ThemeData appTheme(Brightness brightness) => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.seed,
    brightness: brightness,
  ),
  cupertinoOverrideTheme: CupertinoThemeData(brightness: brightness),
);
