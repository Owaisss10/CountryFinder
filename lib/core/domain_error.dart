import 'package:country_finder/l10n/gen/app_localizations.dart';

/// Every failure the data layer surfaces to the UI.
sealed class DomainError implements Exception {
  const DomainError();

  String message(AppLocalizations l10n);
}

final class NoConnectionError extends DomainError {
  const NoConnectionError();

  @override
  String message(AppLocalizations l10n) => l10n.errorNoConnection;

  @override
  bool operator ==(Object other) => other is NoConnectionError;

  @override
  int get hashCode => (NoConnectionError).hashCode;

  @override
  String toString() => 'DomainError.noConnection';
}

final class RateLimitedError extends DomainError {
  const RateLimitedError();

  @override
  String message(AppLocalizations l10n) => l10n.errorRateLimited;

  @override
  bool operator ==(Object other) => other is RateLimitedError;

  @override
  int get hashCode => (RateLimitedError).hashCode;

  @override
  String toString() => 'DomainError.rateLimited';
}

final class ServerError extends DomainError {
  const ServerError(this.statusCode);

  final int statusCode;

  @override
  String message(AppLocalizations l10n) => l10n.errorServer(statusCode);

  @override
  bool operator ==(Object other) =>
      other is ServerError && other.statusCode == statusCode;

  @override
  int get hashCode => Object.hash(ServerError, statusCode);

  @override
  String toString() => 'DomainError.server($statusCode)';
}

final class DecodingFailedError extends DomainError {
  const DecodingFailedError();

  @override
  String message(AppLocalizations l10n) => l10n.errorDecodingFailed;

  @override
  bool operator ==(Object other) => other is DecodingFailedError;

  @override
  int get hashCode => (DecodingFailedError).hashCode;

  @override
  String toString() => 'DomainError.decodingFailed';
}

final class WeatherUnavailableError extends DomainError {
  const WeatherUnavailableError();

  @override
  String message(AppLocalizations l10n) => l10n.errorWeatherUnavailable;

  @override
  bool operator ==(Object other) => other is WeatherUnavailableError;

  @override
  int get hashCode => (WeatherUnavailableError).hashCode;

  @override
  String toString() => 'DomainError.weatherUnavailable';
}
