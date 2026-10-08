import 'package:country_finder/core/app_router.dart';
import 'package:country_finder/core/logging.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:country_finder/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLogging();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    // Holds every provider's state; the Riverpod version of a top-level
    // MultiBlocProvider.
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const CountryFinderApp(),
    ),
  );
}

class CountryFinderApp extends StatefulWidget {
  const CountryFinderApp({super.key, this.router});

  /// Injectable for tests; defaults to the app router.
  final GoRouter? router;

  @override
  State<CountryFinderApp> createState() => _CountryFinderAppState();
}

class _CountryFinderAppState extends State<CountryFinderApp> {
  late final GoRouter _router = widget.router ?? createRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // App name in the Android task switcher; not localized.
      title: 'CountryFinder',
      routerConfig: _router,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
