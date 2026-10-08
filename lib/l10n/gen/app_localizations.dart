import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @tabCountries.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get tabCountries;

  /// No description provided for @tabFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get tabFavorites;

  /// No description provided for @showMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get showMap;

  /// No description provided for @showList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get showList;

  /// No description provided for @mapZoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get mapZoomIn;

  /// No description provided for @mapZoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get mapZoomOut;

  /// No description provided for @mapFavoritePin.
  ///
  /// In en, this message translates to:
  /// **'{name}, favorite'**
  String mapFavoritePin(String name);

  /// No description provided for @mapClusterWithFavorites.
  ///
  /// In en, this message translates to:
  /// **'{count} countries, including favorites'**
  String mapClusterWithFavorites(int count);

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search countries'**
  String get searchPlaceholder;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @loadingCountries.
  ///
  /// In en, this message translates to:
  /// **'Loading countries…'**
  String get loadingCountries;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noCapital.
  ///
  /// In en, this message translates to:
  /// **'No capital'**
  String get noCapital;

  /// No description provided for @favoriteAction.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favoriteAction;

  /// No description provided for @unfavoriteAction.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get unfavoriteAction;

  /// No description provided for @sortLabel.
  ///
  /// In en, this message translates to:
  /// **'Sort: {field}'**
  String sortLabel(String field);

  /// No description provided for @sortFieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get sortFieldName;

  /// No description provided for @sortFieldPopulation.
  ///
  /// In en, this message translates to:
  /// **'Population'**
  String get sortFieldPopulation;

  /// No description provided for @sortFieldArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get sortFieldArea;

  /// No description provided for @factCapital.
  ///
  /// In en, this message translates to:
  /// **'Capital'**
  String get factCapital;

  /// No description provided for @factRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get factRegion;

  /// No description provided for @factPopulation.
  ///
  /// In en, this message translates to:
  /// **'Population'**
  String get factPopulation;

  /// No description provided for @factArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get factArea;

  /// No description provided for @factDensity.
  ///
  /// In en, this message translates to:
  /// **'Density'**
  String get factDensity;

  /// No description provided for @factCallingCode.
  ///
  /// In en, this message translates to:
  /// **'Calling code'**
  String get factCallingCode;

  /// No description provided for @factCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Currencies'**
  String get factCurrencies;

  /// No description provided for @factLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get factLanguages;

  /// No description provided for @factTimezones.
  ///
  /// In en, this message translates to:
  /// **'Timezones'**
  String get factTimezones;

  /// No description provided for @factCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get factCoordinates;

  /// No description provided for @areaValue.
  ///
  /// In en, this message translates to:
  /// **'{area} km²'**
  String areaValue(String area);

  /// No description provided for @densityValue.
  ///
  /// In en, this message translates to:
  /// **'{density} / km²'**
  String densityValue(String density);

  /// No description provided for @neighbours.
  ///
  /// In en, this message translates to:
  /// **'Neighbours'**
  String get neighbours;

  /// No description provided for @keyFactsAbout.
  ///
  /// In en, this message translates to:
  /// **'Key facts about {name}'**
  String keyFactsAbout(String name);

  /// No description provided for @weatherIn.
  ///
  /// In en, this message translates to:
  /// **'Weather in {capital}'**
  String weatherIn(String capital);

  /// No description provided for @temperatureCelsius.
  ///
  /// In en, this message translates to:
  /// **'{temperature}°C'**
  String temperatureCelsius(String temperature);

  /// No description provided for @countryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Country not found'**
  String get countryNotFound;

  /// No description provided for @emptyCountriesTitle.
  ///
  /// In en, this message translates to:
  /// **'No countries'**
  String get emptyCountriesTitle;

  /// No description provided for @emptyCountriesMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show right now.'**
  String get emptyCountriesMessage;

  /// No description provided for @emptySearchTitle.
  ///
  /// In en, this message translates to:
  /// **'No countries found'**
  String get emptySearchTitle;

  /// No description provided for @emptySearchMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term.'**
  String get emptySearchMessage;

  /// No description provided for @emptyFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get emptyFavoritesTitle;

  /// No description provided for @emptyFavoritesMessage.
  ///
  /// In en, this message translates to:
  /// **'Countries you favorite will show up here.'**
  String get emptyFavoritesMessage;

  /// No description provided for @noLandBordersTitle.
  ///
  /// In en, this message translates to:
  /// **'No land borders'**
  String get noLandBordersTitle;

  /// No description provided for @noLandBordersMessage.
  ///
  /// In en, this message translates to:
  /// **'This country doesn\'t share a land border with any other country.'**
  String get noLandBordersMessage;

  /// No description provided for @offlineSavedAt.
  ///
  /// In en, this message translates to:
  /// **'Offline — showing data saved {relativeDate}'**
  String offlineSavedAt(String relativeDate);

  /// No description provided for @offlineSaved.
  ///
  /// In en, this message translates to:
  /// **'Offline — showing saved data'**
  String get offlineSaved;

  /// No description provided for @countriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 country} other{{count} countries}}'**
  String countriesCount(int count);

  /// No description provided for @favoritesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 favorite} other{{count} favorites}}'**
  String favoritesCount(int count);

  /// No description provided for @filteredOfTotalCountries.
  ///
  /// In en, this message translates to:
  /// **'{filtered} of {total, plural, =1{1 country} other{{total} countries}}'**
  String filteredOfTotalCountries(int filtered, int total);

  /// No description provided for @relativeNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get relativeNow;

  /// No description provided for @relativeSecondsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 second ago} other{{count} seconds ago}}'**
  String relativeSecondsAgo(int count);

  /// No description provided for @relativeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute ago} other{{count} minutes ago}}'**
  String relativeMinutesAgo(int count);

  /// No description provided for @relativeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour ago} other{{count} hours ago}}'**
  String relativeHoursAgo(int count);

  /// No description provided for @relativeYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get relativeYesterday;

  /// No description provided for @relativeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String relativeDaysAgo(int count);

  /// No description provided for @relativeLastWeek.
  ///
  /// In en, this message translates to:
  /// **'last week'**
  String get relativeLastWeek;

  /// No description provided for @relativeWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} weeks ago'**
  String relativeWeeksAgo(int count);

  /// No description provided for @relativeLastMonth.
  ///
  /// In en, this message translates to:
  /// **'last month'**
  String get relativeLastMonth;

  /// No description provided for @relativeMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} months ago'**
  String relativeMonthsAgo(int count);

  /// No description provided for @relativeLastYear.
  ///
  /// In en, this message translates to:
  /// **'last year'**
  String get relativeLastYear;

  /// No description provided for @relativeYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} years ago'**
  String relativeYearsAgo(int count);

  /// No description provided for @noLocationForWeather.
  ///
  /// In en, this message translates to:
  /// **'No location data available for weather.'**
  String get noLocationForWeather;

  /// No description provided for @weatherClearSky.
  ///
  /// In en, this message translates to:
  /// **'Clear sky'**
  String get weatherClearSky;

  /// No description provided for @weatherMainlyClear.
  ///
  /// In en, this message translates to:
  /// **'Mainly clear'**
  String get weatherMainlyClear;

  /// No description provided for @weatherPartlyCloudy.
  ///
  /// In en, this message translates to:
  /// **'Partly cloudy'**
  String get weatherPartlyCloudy;

  /// No description provided for @weatherOvercast.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get weatherOvercast;

  /// No description provided for @weatherFoggy.
  ///
  /// In en, this message translates to:
  /// **'Foggy'**
  String get weatherFoggy;

  /// No description provided for @weatherDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Drizzle'**
  String get weatherDrizzle;

  /// No description provided for @weatherFreezingDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Freezing drizzle'**
  String get weatherFreezingDrizzle;

  /// No description provided for @weatherRain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get weatherRain;

  /// No description provided for @weatherFreezingRain.
  ///
  /// In en, this message translates to:
  /// **'Freezing rain'**
  String get weatherFreezingRain;

  /// No description provided for @weatherSnowfall.
  ///
  /// In en, this message translates to:
  /// **'Snowfall'**
  String get weatherSnowfall;

  /// No description provided for @weatherSnowGrains.
  ///
  /// In en, this message translates to:
  /// **'Snow grains'**
  String get weatherSnowGrains;

  /// No description provided for @weatherRainShowers.
  ///
  /// In en, this message translates to:
  /// **'Rain showers'**
  String get weatherRainShowers;

  /// No description provided for @weatherSnowShowers.
  ///
  /// In en, this message translates to:
  /// **'Snow showers'**
  String get weatherSnowShowers;

  /// No description provided for @weatherThunderstorm.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm'**
  String get weatherThunderstorm;

  /// No description provided for @weatherThunderstormWithHail.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm with hail'**
  String get weatherThunderstormWithHail;

  /// No description provided for @weatherUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown conditions'**
  String get weatherUnknown;

  /// No description provided for @errorNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your connection and try again.'**
  String get errorNoConnection;

  /// No description provided for @errorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many requests right now. Please wait a moment and try again.'**
  String get errorRateLimited;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our end ({statusCode}). Please try again.'**
  String errorServer(int statusCode);

  /// No description provided for @errorDecodingFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t understand the server\'s response. Please try again.'**
  String get errorDecodingFailed;

  /// No description provided for @errorWeatherUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Weather data isn\'t available right now. Please try again.'**
  String get errorWeatherUnavailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
