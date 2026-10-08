import 'package:country_finder/l10n/gen/app_localizations.dart';

/// "5 hours ago"-style text, matching iOS's named relative date style.
String relativeDate(AppLocalizations l10n, DateTime date, DateTime now) {
  final diff = now.difference(date);
  if (diff.inSeconds < 1) return l10n.relativeNow;
  if (diff.inMinutes < 1) return l10n.relativeSecondsAgo(diff.inSeconds);
  if (diff.inHours < 1) return l10n.relativeMinutesAgo(diff.inMinutes);
  if (diff.inDays < 1) return l10n.relativeHoursAgo(diff.inHours);
  final days = diff.inDays;
  if (days == 1) return l10n.relativeYesterday;
  if (days < 7) return l10n.relativeDaysAgo(days);
  if (days < 30) {
    final weeks = days ~/ 7;
    return weeks == 1 ? l10n.relativeLastWeek : l10n.relativeWeeksAgo(weeks);
  }
  if (days < 365) {
    final months = days ~/ 30;
    return months == 1
        ? l10n.relativeLastMonth
        : l10n.relativeMonthsAgo(months);
  }
  final years = days ~/ 365;
  return years == 1 ? l10n.relativeLastYear : l10n.relativeYearsAgo(years);
}
