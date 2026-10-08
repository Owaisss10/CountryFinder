import 'package:country_finder/models/weather.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// SF Symbol names from the iOS app, mapped to the closest built-in icon on
/// each platform.
enum AppIcon {
  globe(CupertinoIcons.globe, Icons.public),
  starFill(CupertinoIcons.star_fill, Icons.star),
  star(CupertinoIcons.star, Icons.star_border),
  starSlashFill(CupertinoIcons.star_slash_fill, Icons.star_border),
  search(CupertinoIcons.search, Icons.search),
  clear(CupertinoIcons.clear, Icons.close),
  questionmarkCircle(CupertinoIcons.question_circle, Icons.help_outline),
  exclamationTriangle(
    CupertinoIcons.exclamationmark_triangle_fill,
    Icons.warning_amber_rounded,
  ),
  wifiSlash(CupertinoIcons.wifi_slash, Icons.wifi_off),
  sort(CupertinoIcons.arrow_up_arrow_down, Icons.swap_vert),
  chevronUp(CupertinoIcons.chevron_up, Icons.keyboard_arrow_up),
  chevronDown(CupertinoIcons.chevron_down, Icons.keyboard_arrow_down),
  chevronRight(CupertinoIcons.chevron_right, Icons.chevron_right),
  photo(CupertinoIcons.photo, Icons.image_outlined),
  zoomIn(CupertinoIcons.plus, Icons.add),
  zoomOut(CupertinoIcons.minus, Icons.remove),
  map(CupertinoIcons.map, Icons.map_outlined),
  listBullet(CupertinoIcons.list_bullet, Icons.list),
  flag(CupertinoIcons.flag, Icons.flag_outlined),
  flagFill(CupertinoIcons.flag_fill, Icons.flag),
  flagSlash(CupertinoIcons.flag_slash, Icons.flag_outlined),
  waterWaves(CupertinoIcons.drop, Icons.waves),
  buildingColumns(CupertinoIcons.building_2_fill, Icons.account_balance),
  globeEuropeAfrica(CupertinoIcons.globe, Icons.public),
  person2(CupertinoIcons.person_2_fill, Icons.groups),
  ruler(CupertinoIcons.resize, Icons.straighten),
  chartBar(CupertinoIcons.chart_bar_fill, Icons.bar_chart),
  phone(CupertinoIcons.phone_fill, Icons.phone),
  banknote(CupertinoIcons.money_dollar_circle_fill, Icons.payments),
  characterBubble(CupertinoIcons.chat_bubble_text_fill, Icons.translate),
  clock(CupertinoIcons.clock_fill, Icons.schedule),
  location(CupertinoIcons.location_fill, Icons.place),
  sunMax(CupertinoIcons.sun_max_fill, Icons.wb_sunny),
  moonStars(CupertinoIcons.moon_stars_fill, Icons.nightlight_round),
  cloudSun(CupertinoIcons.cloud_sun_fill, Icons.wb_cloudy),
  cloudMoon(CupertinoIcons.cloud_moon_fill, Icons.nights_stay),
  cloud(CupertinoIcons.cloud_fill, Icons.cloud),
  cloudFog(CupertinoIcons.cloud_fog_fill, Icons.foggy),
  cloudDrizzle(CupertinoIcons.cloud_drizzle_fill, Icons.grain),
  cloudRain(CupertinoIcons.cloud_rain_fill, Icons.umbrella),
  cloudSnow(CupertinoIcons.cloud_snow_fill, Icons.ac_unit),
  cloudBoltRain(CupertinoIcons.cloud_bolt_rain_fill, Icons.thunderstorm);

  const AppIcon(this.cupertino, this.material);

  final IconData cupertino;
  final IconData material;

  IconData of(BuildContext context) =>
      context.isCupertino ? cupertino : material;

  static AppIcon forWeather(WeatherSymbol symbol) => switch (symbol) {
    WeatherSymbol.sun => sunMax,
    WeatherSymbol.moonStars => moonStars,
    WeatherSymbol.cloudSun => cloudSun,
    WeatherSymbol.cloudMoon => cloudMoon,
    WeatherSymbol.cloud => cloud,
    WeatherSymbol.fog => cloudFog,
    WeatherSymbol.drizzle => cloudDrizzle,
    WeatherSymbol.rain => cloudRain,
    WeatherSymbol.snow => cloudSnow,
    WeatherSymbol.thunderstorm => cloudBoltRain,
    WeatherSymbol.unknown => questionmarkCircle,
  };
}
