import 'dart:async';

import 'package:country_finder/core/app_router.dart';
import 'package:country_finder/core/domain_error.dart';
import 'package:country_finder/main.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:country_finder/repositories/countries_repository.dart';
import 'package:country_finder/screens/map/cluster_marker.dart';
import 'package:country_finder/screens/map/favorite_badge.dart';
import 'package:country_finder/screens/map/selected_country_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../support/fixtures.dart';

void main() {
  final fra = country(population: 67000000, area: 551695, borders: ['ESP']);
  // France (default 46, 2) and Spain sit close enough to group on the map;
  // Iceland stands alone.
  final esp = country(
    name: 'Spain',
    alpha3Code: 'ESP',
    capital: 'Madrid',
    borders: ['FRA'],
    latlng: [40, -4],
  );
  final isl = country(
    name: 'Iceland',
    alpha3Code: 'ISL',
    capital: null,
    latlng: [65, -18],
  );
  final countries = [fra, isl, esp];

  late FakeCountriesRepository countriesRepo;
  late InMemoryFavoritesRepository favoritesRepo;
  late MockWeatherRepository weatherRepo;
  late GoRouter router;

  setUp(() {
    countriesRepo = FakeCountriesRepository(
      (_) async =>
          CountriesFetchResult(countries: countries, isFromCache: false),
    );
    favoritesRepo = InMemoryFavoritesRepository();
    weatherRepo = MockWeatherRepository();
    when(
      () => weatherRepo.fetchWeather(any(), any()),
    ).thenAnswer((_) async => sampleWeather);
  });

  Future<void> pumpApp(WidgetTester tester) async {
    router = createRouter();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          countriesRepositoryProvider.overrideWithValue(countriesRepo),
          favoritesRepositoryProvider.overrideWithValue(favoritesRepo),
          weatherRepositoryProvider.overrideWithValue(weatherRepo),
          sortOptionRepositoryProvider.overrideWithValue(
            InMemorySortOptionRepository(),
          ),
          mapDataRepositoryProvider.overrideWithValue(
            FakeMapDataRepository(sampleMapData),
          ),
        ],
        child: CountryFinderApp(router: router),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
  }

  Future<void> openTab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> openMap(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('view-mode-toggle')));
    await tester.pumpAndSettle();
  }

  testWidgets('loading then loaded list with count row', (tester) async {
    final completer = Completer<CountriesFetchResult>();
    countriesRepo.handler = (_) => completer.future;
    await pumpApp(tester);
    expect(find.text('Loading countries…'), findsOneWidget);

    completer.complete(
      CountriesFetchResult(countries: countries, isFromCache: false),
    );
    await tester.pumpAndSettle();
    expect(find.text('Loading countries…'), findsNothing);
    expect(find.text('France'), findsOneWidget);
    expect(find.text('Madrid'), findsOneWidget);
    expect(find.text('No capital'), findsOneWidget);
    expect(find.text('3 countries'), findsOneWidget);
    // Icon-only button; its label is the tooltip.
    expect(find.byTooltip('Sort: Name'), findsOneWidget);
    expect(find.text('Sort: Name'), findsNothing);
    expect(find.textContaining('Offline'), findsNothing);
  });

  testWidgets('error state retries with a forced network call', (tester) async {
    countriesRepo.handler = (_) async => throw const RateLimitedError();
    await pumpApp(tester);
    await tester.pumpAndSettle();
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(
      find.text(
        'Too many requests right now. Please wait a moment and try again.',
      ),
      findsOneWidget,
    );

    countriesRepo.handler = (_) async =>
        CountriesFetchResult(countries: countries, isFromCache: false);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(countriesRepo.calls, [false, true]);
    expect(find.text('France'), findsOneWidget);
  });

  testWidgets('offline banner shows for cached data, with and without a date', (
    tester,
  ) async {
    countriesRepo.handler = (_) async => CountriesFetchResult(
      countries: countries,
      isFromCache: true,
      cacheDate: DateTime.now().subtract(const Duration(hours: 5)),
    );
    await pumpApp(tester);
    await tester.pumpAndSettle();
    expect(
      find.text('Offline — showing data saved 5 hours ago'),
      findsOneWidget,
    );

    countriesRepo.handler = (_) async =>
        CountriesFetchResult(countries: countries, isFromCache: true);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Offline — showing saved data'), findsOneWidget);
    expect(countriesRepo.calls.last, isTrue);
  });

  testWidgets('sort menu toggles direction of the active field', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.pumpAndSettle();
    double y(String name) => tester.getTopLeft(find.text(name)).dy;
    expect(y('France') < y('Spain'), isTrue);

    await tester.tap(find.byTooltip('Sort: Name'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Name').last);
    await tester.pumpAndSettle();
    expect(y('Spain') < y('France'), isTrue);
  });

  testWidgets('searching the countries list filters and shows "x of y"', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.pumpAndSettle();
    expect(find.text('3 countries'), findsOneWidget);
    // Search lives on the Countries tab now; there's no Search tab.
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Search'),
      ),
      findsNothing,
    );

    await tester.enterText(find.byType(TextField), 'spa');
    await tester.pumpAndSettle();
    expect(find.text('1 of 3 countries'), findsOneWidget);
    expect(find.text('Spain'), findsOneWidget);
    expect(find.text('France'), findsNothing);

    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pumpAndSettle();
    expect(find.text('No countries found'), findsOneWidget);
    expect(find.text('Try a different search term.'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear search'));
    await tester.pumpAndSettle();
    expect(find.text('3 countries'), findsOneWidget);
  });

  testWidgets('the search bar scrolls away, but stays while searching', (
    tester,
  ) async {
    final many = [
      for (var i = 1; i <= 40; i++)
        country(name: 'Land $i', alpha3Code: 'L${'$i'.padLeft(2, '0')}'),
    ];
    countriesRepo.handler = (_) async =>
        CountriesFetchResult(countries: many, isFromCache: false);
    await pumpApp(tester);
    await tester.pumpAndSettle();
    final searchBar = find.byType(SearchBar).hitTestable();
    Future<void> scrollBy(double dy) async {
      await tester.drag(find.byType(CustomScrollView), Offset(0, dy));
      await tester.pumpAndSettle();
    }

    await scrollBy(-500);
    expect(searchBar, findsNothing);
    await scrollBy(1000);
    expect(searchBar, findsOneWidget);

    // With a search typed, scrolling the results keeps the bar in place.
    await tester.enterText(find.byType(TextField), 'Land');
    await tester.pumpAndSettle();
    await scrollBy(-500);
    expect(searchBar, findsOneWidget);
  });

  testWidgets('iOS: tapping the search field searches; Cancel ends it', (
    tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await pumpApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CupertinoSearchTextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(CupertinoSearchTextField), 'spa');
      await tester.pumpAndSettle();
      expect(find.text('1 of 3 countries'), findsOneWidget);

      await tester.tap(find.text('Cancel').last);
      await tester.pumpAndSettle();
      expect(find.text('3 countries'), findsOneWidget);
      expect(find.text('France'), findsOneWidget);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('the selected tab shows a filled icon', (tester) async {
    await pumpApp(tester);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.flag), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsOneWidget);

    await openTab(tester, 'Favorites');
    expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  group('map view', () {
    /// A phone-sized portrait screen, so every test pin is in view.
    void usePhoneScreen(WidgetTester tester) {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }

    testWidgets('zoom buttons split and regroup pins, within limits', (
      tester,
    ) async {
      usePhoneScreen(tester);
      await pumpApp(tester);
      await tester.pumpAndSettle();
      await openMap(tester);
      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byTooltip('Zoom in'));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsNothing);
      expect(find.byKey(const ValueKey('map-marker-FRA')), findsOneWidget);
      expect(find.byKey(const ValueKey('map-marker-ESP')), findsOneWidget);

      await tester.tap(find.byTooltip('Zoom out'));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);

      // One more step reaches the minimum zoom, which disables zooming out.
      await tester.tap(find.byTooltip('Zoom out'));
      await tester.pumpAndSettle();
      final zoomOut = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.remove),
      );
      expect(zoomOut.onPressed, isNull);
    });

    testWidgets('favorites get a star on their pin and on their group', (
      tester,
    ) async {
      usePhoneScreen(tester);
      await favoritesRepo.add('ESP');
      await favoritesRepo.add('ISL');
      await pumpApp(tester);
      await tester.pumpAndSettle();
      await openMap(tester);

      Finder starOn(Finder target) =>
          find.descendant(of: target, matching: find.byType(FavoriteBadge));
      expect(
        starOn(find.byKey(const ValueKey('map-marker-ISL'))),
        findsOneWidget,
      );
      // Spain is grouped with France; the group shows the star.
      expect(starOn(find.byType(ClusterMarker)), findsOneWidget);

      await tester.tap(find.byTooltip('Zoom in'));
      await tester.pumpAndSettle();
      expect(
        starOn(find.byKey(const ValueKey('map-marker-ESP'))),
        findsOneWidget,
      );
      expect(
        starOn(find.byKey(const ValueKey('map-marker-FRA'))),
        findsNothing,
      );
    });

    testWidgets('a tapped pin near the bottom pans up above its card', (
      tester,
    ) async {
      usePhoneScreen(tester);
      // Far south, so its pin starts where the card is about to appear.
      final south = country(
        name: 'Southland',
        alpha3Code: 'SLD',
        latlng: [-70, 10],
      );
      countriesRepo.handler = (_) async => CountriesFetchResult(
        countries: [...countries, south],
        isFromCache: false,
      );
      await pumpApp(tester);
      await tester.pumpAndSettle();
      await openMap(tester);

      await tester.tap(find.byKey(const ValueKey('map-marker-SLD')));
      await tester.pumpAndSettle();
      final pinTip = tester.getRect(
        find.byKey(const ValueKey('map-marker-SLD')),
      );
      final card = tester.getRect(find.byType(SelectedCountryCard));
      expect(pinTip.bottom, lessThanOrEqualTo(card.top));
    });

    testWidgets('pins only searched countries and keeps the list scroll', (
      tester,
    ) async {
      usePhoneScreen(tester);
      await pumpApp(tester);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'ice');
      await tester.pumpAndSettle();
      await openMap(tester);
      expect(find.byKey(const ValueKey('map-marker-ISL')), findsOneWidget);
      expect(find.text('2'), findsNothing);
      expect(find.byKey(const ValueKey('map-marker-FRA')), findsNothing);

      // Back to the list: the search is still there.
      await openMap(tester);
      expect(find.text('1 of 3 countries'), findsOneWidget);
    });

    testWidgets('favorites get their own map', (tester) async {
      usePhoneScreen(tester);
      await favoritesRepo.add('ISL');
      await pumpApp(tester);
      await tester.pumpAndSettle();
      await openTab(tester, 'Favorites');
      await openMap(tester);
      expect(find.byKey(const ValueKey('map-marker-ISL')), findsOneWidget);
      expect(find.byKey(const ValueKey('map-marker-FRA')), findsNothing);

      await tester.tap(find.byKey(const ValueKey('map-marker-ISL')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Iceland'));
      await tester.pumpAndSettle();
      expect(find.text('KEY FACTS ABOUT ICELAND'), findsOneWidget);
      // Opened in the Favorites tab's own stack.
      expect(
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        '/favorites/country/ISL',
      );
    });

    testWidgets('each tab remembers its own selected pin', (tester) async {
      usePhoneScreen(tester);
      await favoritesRepo.add('ISL');
      await pumpApp(tester);
      await tester.pumpAndSettle();
      await openMap(tester);
      await tester.tap(find.byKey(const ValueKey('map-marker-ISL')));
      await tester.pumpAndSettle();
      expect(find.byType(SelectedCountryCard), findsOneWidget);

      await openTab(tester, 'Favorites');
      await openMap(tester);
      expect(find.byType(SelectedCountryCard), findsNothing);

      await openTab(tester, 'Countries');
      expect(find.byType(SelectedCountryCard), findsOneWidget);
    });

    testWidgets('groups nearby pins and opens a tapped country', (
      tester,
    ) async {
      usePhoneScreen(tester);
      await pumpApp(tester);
      await tester.pumpAndSettle();
      await openMap(tester);

      // France and Spain share one counted circle; Iceland has its own pin.
      expect(find.text('2'), findsOneWidget);
      // No favorites yet, so no stars.
      expect(find.byType(FavoriteBadge), findsNothing);
      expect(find.byKey(const ValueKey('map-marker-ISL')), findsOneWidget);
      // The basemap draws the (fake) country outlines. France's pin sits on
      // that large land, so only Spain and Iceland (no land in the fake
      // data) get island dots.
      expect(
        tester.widget<PolygonLayer>(find.byType(PolygonLayer)).polygons,
        hasLength(1),
      );
      expect(
        tester.widget<CircleLayer>(find.byType(CircleLayer)).circles,
        hasLength(2),
      );

      await tester.tap(find.byKey(const ValueKey('map-marker-ISL')));
      await tester.pumpAndSettle();
      expect(find.text('Iceland'), findsOneWidget);

      // The card sits beside the zoom buttons in the corner, not over them.
      final card = tester.getRect(find.byType(SelectedCountryCard));
      for (final button in ['Zoom in', 'Zoom out']) {
        expect(card.overlaps(tester.getRect(find.byTooltip(button))), isFalse);
      }

      await tester.tap(find.text('Iceland'));
      await tester.pumpAndSettle();
      expect(find.text('KEY FACTS ABOUT ICELAND'), findsOneWidget);
    });
  });

  testWidgets('favorites tab shows empty state, then favorites', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.pumpAndSettle();
    await openTab(tester, 'Favorites');
    expect(find.text('No favorites yet'), findsOneWidget);
    expect(find.text('0 favorites'), findsOneWidget);

    await favoritesRepo.add('ESP');
    await openTab(tester, 'Countries');
    await openTab(tester, 'Favorites');
    expect(find.text('Spain'), findsOneWidget);
    expect(find.text('1 favorite'), findsOneWidget);
  });

  testWidgets('detail shows every section and hides the tab bar', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('France'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text('WEATHER IN PARIS'), findsOneWidget);
    expect(find.text('21°C'), findsOneWidget);
    expect(find.text('Partly cloudy'), findsOneWidget);
    expect(find.text('KEY FACTS ABOUT FRANCE'), findsOneWidget);
    expect(find.text('67,000,000'), findsOneWidget);
    expect(find.text('551,695 km²'), findsOneWidget);
    await reveal(tester, find.text('Neighbours'));
    expect(find.text('Neighbours'), findsOneWidget);
    expect(find.text('Spain'), findsOneWidget);
    await tester.drag(
      find.byType(CustomScrollView).last,
      const Offset(0, 2000),
    );
    await tester.pumpAndSettle();

    // Favorite toggle from the app bar doesn't reload the weather.
    await tester.tap(find.byTooltip('Favorite'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Unfavorite'), findsOneWidget);
    verify(() => weatherRepo.fetchWeather(any(), any())).called(1);

    // A neighbour pushes onto the same stack; back returns to France.
    await reveal(tester, find.text('Spain'));
    await tester.tap(find.text('Spain'));
    await tester.pumpAndSettle();
    expect(find.text('WEATHER IN MADRID'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    // Back on France, still scrolled to its neighbours.
    expect(find.text('WEATHER IN MADRID'), findsNothing);
    expect(find.text('Neighbours'), findsOneWidget);
    expect(find.text('Spain'), findsOneWidget);
  });

  testWidgets('weather failure only affects the weather card', (tester) async {
    var fail = true;
    when(() => weatherRepo.fetchWeather(any(), any())).thenAnswer((_) async {
      if (fail) throw const WeatherUnavailableError();
      return sampleWeather;
    });
    await pumpApp(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Iceland'));
    await tester.pumpAndSettle();

    expect(find.text('WEATHER IN NO CAPITAL'), findsOneWidget);
    expect(
      find.text('Weather data isn\'t available right now. Please try again.'),
      findsOneWidget,
    );
    expect(find.text('KEY FACTS ABOUT ICELAND'), findsOneWidget);
    await reveal(tester, find.text('No land borders'));
    expect(find.text('No land borders'), findsOneWidget);
    await tester.drag(
      find.byType(CustomScrollView).last,
      const Offset(0, 2000),
    );
    await tester.pumpAndSettle();

    fail = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Partly cloudy'), findsOneWidget);
  });

  testWidgets('unknown code shows Country not found', (tester) async {
    await pumpApp(tester);
    await tester.pumpAndSettle();
    unawaited(router.push('/countries/country/XXX'));
    await tester.pumpAndSettle();
    expect(find.text('Country not found'), findsOneWidget);
  });

  testWidgets('iOS renders the Cupertino variant', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await pumpApp(tester);
      await tester.pumpAndSettle();
      expect(find.text('France'), findsOneWidget);
      expect(find.text('3 countries'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(find.bySemanticsLabel('Sort: Name'), findsOneWidget);
      // Selected tab filled, the others outlined.
      expect(find.byIcon(CupertinoIcons.flag_fill), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.star), findsOneWidget);
      // The search field sits under the large title.
      expect(find.byType(CupertinoSearchTextField), findsOneWidget);
      await tester.tap(find.text('France'));
      await tester.pumpAndSettle();
      expect(find.text('KEY FACTS ABOUT FRANCE'), findsOneWidget);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('iOS dark mode: the large-title bar is dark too', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    try {
      await pumpApp(tester);
      await tester.pumpAndSettle();
      final background = tester.widget<DecoratedBox>(
        find
            .descendant(
              of: find.byType(CupertinoSliverNavigationBar),
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      final color = (background.decoration as BoxDecoration).color;
      // Below this luminance Flutter treats the bar as dark, so its white
      // title stays readable.
      expect(color?.computeLuminance(), lessThan(0.179));
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}
