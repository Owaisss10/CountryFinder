import 'dart:async';

import 'package:country_finder/core/api_client.dart';
import 'package:country_finder/core/domain_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../support/fixtures.dart';

void main() {
  final url = Uri.parse('https://example.test/data');

  /// The body on success, or the DomainError thrown.
  Future<Object> get(
    FutureOr<http.Response> Function(http.Request) respond,
  ) async {
    try {
      return await ApiClient(fakeHttp(respond)).get(url);
    } on DomainError catch (e) {
      return e;
    }
  }

  test('returns the body of a 2xx response', () async {
    expect(await get((_) => jsonResponse('[1, 2]')), '[1, 2]');
    expect(await get((_) => jsonResponse('{}', status: 204)), '{}');
  });

  test('decodes UTF-8 even when the server sends no charset', () async {
    const body = '["Côte d\'Ivoire", "Türkiye", "Åland — Islands"]';
    expect(await get((_) => jsonResponse(body)), body);
  });

  test('429 maps to rateLimited', () async {
    expect(
      await get((_) => jsonResponse('', status: 429)),
      const RateLimitedError(),
    );
  });

  test('other non-2xx statuses map to server(status)', () async {
    expect(
      await get((_) => jsonResponse('', status: 503)),
      const ServerError(503),
    );
    expect(
      await get((_) => jsonResponse('', status: 404)),
      const ServerError(404),
    );
  });

  test('a transport failure maps to noConnection', () async {
    expect(await get(offline), const NoConnectionError());
  });

  test('a timeout maps to noConnection', () {
    final client = ApiClient(
      fakeHttp((_) => Completer<http.Response>().future),
      timeout: const Duration(milliseconds: 10),
    );
    expect(client.get(url), throwsA(const NoConnectionError()));
  });

  test('a body that is not UTF-8 maps to decodingFailed', () async {
    expect(
      await get((_) => http.Response.bytes([0xff, 0xfe, 0xfd], 200)),
      const DecodingFailedError(),
    );
  });
}
