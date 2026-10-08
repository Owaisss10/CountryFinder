import 'dart:convert';

import 'package:country_finder/core/domain_error.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

final _log = Logger('ApiClient');

/// The one place the app makes HTTP requests. It keeps no HTTP cache, so
/// the Drift cache stays the only offline source of truth.
class ApiClient {
  ApiClient(this._client, {this.timeout = const Duration(seconds: 30)});

  final http.Client _client;
  final Duration timeout;

  /// Returns the response body, decoded as UTF-8.
  ///
  /// Throws [NoConnectionError] for transport failures and timeouts,
  /// [RateLimitedError] for 429, [ServerError] for any other non-2xx status
  /// and [DecodingFailedError] if the body isn't valid UTF-8.
  Future<String> get(Uri url) async {
    final http.Response response;
    try {
      response = await _client.get(url).timeout(timeout);
    } on Exception catch (e) {
      // ClientException, SocketException, TimeoutException and TLS failures.
      _log.warning('GET $url failed', e);
      throw const NoConnectionError();
    }
    final status = response.statusCode;
    if (status == 429) throw const RateLimitedError();
    if (status < 200 || status > 299) throw ServerError(status);
    try {
      // Decoded explicitly: `response.body` falls back to Latin-1 when the
      // server sends no charset, which would garble names like "Côte".
      return utf8.decode(response.bodyBytes);
    } on FormatException catch (e) {
      _log.warning('GET $url returned invalid UTF-8', e);
      throw const DecodingFailedError();
    }
  }
}
