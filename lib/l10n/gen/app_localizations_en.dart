// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tabCountries => 'Countries';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get showMap => 'Map';

  @override
  String get showList => 'List';

  @override
  String get mapZoomIn => 'Zoom in';

  @override
  String get mapZoomOut => 'Zoom out';

  @override
  String mapFavoritePin(String name) {
    return '$name, favorite';
  }

  @override
  String mapClusterWithFavorites(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString countries, including favorites';
  }

  @override
  String get searchPlaceholder => 'Search countries';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get loadingCountries => 'Loading countries…';

  @override
  String get loading => 'Loading…';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get noCapital => 'No capital';

  @override
  String get favoriteAction => 'Favorite';

  @override
  String get unfavoriteAction => 'Unfavorite';

  @override
  String sortLabel(String field) {
    return 'Sort: $field';
  }

  @override
  String get sortFieldName => 'Name';

  @override
  String get sortFieldPopulation => 'Population';

  @override
  String get sortFieldArea => 'Area';

  @override
  String get factCapital => 'Capital';

  @override
  String get factRegion => 'Region';

  @override
  String get factPopulation => 'Population';

  @override
  String get factArea => 'Area';

  @override
  String get factDensity => 'Density';

  @override
  String get factCallingCode => 'Calling code';

  @override
  String get factCurrencies => 'Currencies';

  @override
  String get factLanguages => 'Languages';

  @override
  String get factTimezones => 'Timezones';

  @override
  String get factCoordinates => 'Coordinates';

  @override
  String areaValue(String area) {
    return '$area km²';
  }

  @override
  String densityValue(String density) {
    return '$density / km²';
  }

  @override
  String get neighbours => 'Neighbours';

  @override
  String keyFactsAbout(String name) {
    return 'Key facts about $name';
  }

  @override
  String weatherIn(String capital) {
    return 'Weather in $capital';
  }

  @override
  String temperatureCelsius(String temperature) {
    return '$temperature°C';
  }

  @override
  String get countryNotFound => 'Country not found';

  @override
  String get emptyCountriesTitle => 'No countries';

  @override
  String get emptyCountriesMessage => 'Nothing to show right now.';

  @override
  String get emptySearchTitle => 'No countries found';

  @override
  String get emptySearchMessage => 'Try a different search term.';

  @override
  String get emptyFavoritesTitle => 'No favorites yet';

  @override
  String get emptyFavoritesMessage =>
      'Countries you favorite will show up here.';

  @override
  String get noLandBordersTitle => 'No land borders';

  @override
  String get noLandBordersMessage =>
      'This country doesn\'t share a land border with any other country.';

  @override
  String offlineSavedAt(String relativeDate) {
    return 'Offline — showing data saved $relativeDate';
  }

  @override
  String get offlineSaved => 'Offline — showing saved data';

  @override
  String countriesCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString countries',
      one: '1 country',
    );
    return '$_temp0';
  }

  @override
  String favoritesCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString favorites',
      one: '1 favorite',
    );
    return '$_temp0';
  }

  @override
  String filteredOfTotalCountries(int filtered, int total) {
    final intl.NumberFormat filteredNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String filteredString = filteredNumberFormat.format(filtered);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$totalString countries',
      one: '1 country',
    );
    return '$filteredString of $_temp0';
  }

  @override
  String get relativeNow => 'now';

  @override
  String relativeSecondsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seconds ago',
      one: '1 second ago',
    );
    return '$_temp0';
  }

  @override
  String relativeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String relativeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String get relativeYesterday => 'yesterday';

  @override
  String relativeDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get relativeLastWeek => 'last week';

  @override
  String relativeWeeksAgo(int count) {
    return '$count weeks ago';
  }

  @override
  String get relativeLastMonth => 'last month';

  @override
  String relativeMonthsAgo(int count) {
    return '$count months ago';
  }

  @override
  String get relativeLastYear => 'last year';

  @override
  String relativeYearsAgo(int count) {
    return '$count years ago';
  }

  @override
  String get noLocationForWeather => 'No location data available for weather.';

  @override
  String get weatherClearSky => 'Clear sky';

  @override
  String get weatherMainlyClear => 'Mainly clear';

  @override
  String get weatherPartlyCloudy => 'Partly cloudy';

  @override
  String get weatherOvercast => 'Overcast';

  @override
  String get weatherFoggy => 'Foggy';

  @override
  String get weatherDrizzle => 'Drizzle';

  @override
  String get weatherFreezingDrizzle => 'Freezing drizzle';

  @override
  String get weatherRain => 'Rain';

  @override
  String get weatherFreezingRain => 'Freezing rain';

  @override
  String get weatherSnowfall => 'Snowfall';

  @override
  String get weatherSnowGrains => 'Snow grains';

  @override
  String get weatherRainShowers => 'Rain showers';

  @override
  String get weatherSnowShowers => 'Snow showers';

  @override
  String get weatherThunderstorm => 'Thunderstorm';

  @override
  String get weatherThunderstormWithHail => 'Thunderstorm with hail';

  @override
  String get weatherUnknown => 'Unknown conditions';

  @override
  String get errorNoConnection =>
      'No internet connection. Check your connection and try again.';

  @override
  String get errorRateLimited =>
      'Too many requests right now. Please wait a moment and try again.';

  @override
  String errorServer(int statusCode) {
    return 'Something went wrong on our end ($statusCode). Please try again.';
  }

  @override
  String get errorDecodingFailed =>
      'We couldn\'t understand the server\'s response. Please try again.';

  @override
  String get errorWeatherUnavailable =>
      'Weather data isn\'t available right now. Please try again.';
}
