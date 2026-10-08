import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/shared/relative_date.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));
  final now = DateTime(2026, 10, 6, 12);
  String ago(Duration d) => relativeDate(l10n, now.subtract(d), now);

  test('uses the named iOS-style phrases', () {
    expect(ago(Duration.zero), 'now');
    expect(ago(const Duration(seconds: 30)), '30 seconds ago');
    expect(ago(const Duration(minutes: 1)), '1 minute ago');
    expect(ago(const Duration(hours: 5)), '5 hours ago');
    expect(ago(const Duration(days: 1)), 'yesterday');
    expect(ago(const Duration(days: 3)), '3 days ago');
    expect(ago(const Duration(days: 8)), 'last week');
    expect(ago(const Duration(days: 21)), '3 weeks ago');
    expect(ago(const Duration(days: 40)), 'last month');
    expect(ago(const Duration(days: 400)), 'last year');
    expect(ago(const Duration(days: 800)), '2 years ago');
  });
}
