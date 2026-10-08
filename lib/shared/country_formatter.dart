import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/models/weather.dart';
import 'package:intl/intl.dart';

/// Universal placeholder for a missing value; deliberately not localized.
const String missingValue = '-';

/// Pure display formatting for a country. Country data itself (names,
/// capitals, currency codes) is never localized, only the chrome around it.
class CountryFormatter {
  CountryFormatter(this.l10n)
    : _grouped = NumberFormat.decimalPattern(l10n.localeName),
      _zeroDecimals = NumberFormat.decimalPatternDigits(
        locale: l10n.localeName,
        decimalDigits: 0,
      ),
      _oneDecimal = NumberFormat.decimalPatternDigits(
        locale: l10n.localeName,
        decimalDigits: 1,
      );

  final AppLocalizations l10n;
  final NumberFormat _grouped;
  final NumberFormat _zeroDecimals;
  final NumberFormat _oneDecimal;

  String capital(Country c) => c.capital ?? l10n.noCapital;

  String population(Country c) {
    final population = c.population;
    return population == null ? missingValue : _grouped.format(population);
  }

  String area(Country c) {
    final area = c.area;
    return area == null
        ? missingValue
        : l10n.areaValue(_zeroDecimals.format(area));
  }

  String density(Country c) {
    final density = c.populationDensity;
    return density == null
        ? missingValue
        : l10n.densityValue(_oneDecimal.format(density));
  }

  String callingCodes(Country c) =>
      _joinedOrMissing(c.callingCodes?.map((code) => '+$code'));

  String currencies(Country c) => _joinedOrMissing(
    c.currencies?.map((currency) {
      final code = currency.code;
      final name = currency.name;
      if (code != null && name != null) return '$code — $name';
      return code ?? name ?? missingValue;
    }),
  );

  String languages(Country c) =>
      _joinedOrMissing(c.languages?.map((language) => language.name));

  String timezones(Country c) => _joinedOrMissing(c.timezones);

  String coordinates(Country c) {
    final coordinates = c.coordinates;
    if (coordinates == null) return missingValue;
    return '${_grouped.format(coordinates.latitude)}, '
        '${_grouped.format(coordinates.longitude)}';
  }

  String temperature(Weather w) =>
      l10n.temperatureCelsius(_zeroDecimals.format(w.temperature));

  String weatherDescription(WeatherCondition condition) => switch (condition) {
    WeatherCondition.clearSky => l10n.weatherClearSky,
    WeatherCondition.mainlyClear => l10n.weatherMainlyClear,
    WeatherCondition.partlyCloudy => l10n.weatherPartlyCloudy,
    WeatherCondition.overcast => l10n.weatherOvercast,
    WeatherCondition.foggy => l10n.weatherFoggy,
    WeatherCondition.drizzle => l10n.weatherDrizzle,
    WeatherCondition.freezingDrizzle => l10n.weatherFreezingDrizzle,
    WeatherCondition.rain => l10n.weatherRain,
    WeatherCondition.freezingRain => l10n.weatherFreezingRain,
    WeatherCondition.snowfall => l10n.weatherSnowfall,
    WeatherCondition.snowGrains => l10n.weatherSnowGrains,
    WeatherCondition.rainShowers => l10n.weatherRainShowers,
    WeatherCondition.snowShowers => l10n.weatherSnowShowers,
    WeatherCondition.thunderstorm => l10n.weatherThunderstorm,
    WeatherCondition.thunderstormWithHail => l10n.weatherThunderstormWithHail,
    WeatherCondition.unknown => l10n.weatherUnknown,
  };

  String sortFieldTitle(SortField field) => switch (field) {
    SortField.name => l10n.sortFieldName,
    SortField.population => l10n.sortFieldPopulation,
    SortField.area => l10n.sortFieldArea,
  };

  String _joinedOrMissing(Iterable<String>? values) {
    final list = values?.toList() ?? const <String>[];
    return list.isEmpty ? missingValue : list.join(', ');
  }
}
