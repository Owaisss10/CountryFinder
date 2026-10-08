import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Pumps a MaterialApp with the app's themes in [mode] and returns what
  /// [read] sees inside it.
  Future<T> readInApp<T>(
    WidgetTester tester,
    ThemeMode mode,
    T Function(BuildContext context) read,
  ) async {
    late T value;
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme(Brightness.light),
        darkTheme: appTheme(Brightness.dark),
        themeMode: mode,
        home: Builder(
          builder: (context) {
            value = read(context);
            return const SizedBox();
          },
        ),
      ),
    );
    // Switching modes between calls animates the theme; read the end state.
    await tester.pumpAndSettle();
    return value;
  }

  // The luminance cut-off Flutter's nav bar uses to pick a light or dark
  // status bar.
  bool isDark(Color color) => color.computeLuminance() < 0.179;

  testWidgets('the iOS bar background follows dark mode', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      final dark = await readInApp(
        tester,
        ThemeMode.dark,
        (context) => AppColors.of(context).bar,
      );
      expect(isDark(dark), isTrue);

      final light = await readInApp(
        tester,
        ThemeMode.light,
        (context) => AppColors.of(context).bar,
      );
      expect(isDark(light), isFalse);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('the accent is the theme color on iOS as well', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      for (final mode in [ThemeMode.light, ThemeMode.dark]) {
        final (accent, primary, cupertinoPrimary) = await readInApp(
          tester,
          mode,
          (context) => (
            AppColors.of(context).accent,
            Theme.of(context).colorScheme.primary,
            CupertinoTheme.of(context).primaryColor,
          ),
        );
        expect(accent, primary, reason: '$mode');
        expect(cupertinoPrimary, primary, reason: '$mode');
      }
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}
