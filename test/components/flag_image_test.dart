import 'dart:io' show HttpException;

import 'package:country_finder/components/flag_image.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCacheManager extends Mock implements BaseCacheManager {}

void main() {
  final svg = Uri.parse('https://example.test/flag.svg');
  late _MockCacheManager cache;

  setUp(() => cache = _MockCacheManager());

  Future<void> pump(WidgetTester tester, {Uri? png, Uri? svgUrl}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [flagCacheManagerProvider.overrideWithValue(cache)],
        child: MaterialApp(
          home: FlagImage(url: png, svgUrl: svgUrl),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('without a PNG, the SVG is shown', (tester) async {
    final file = await tester.runAsync(() async {
      final dir = await const LocalFileSystem().systemTempDirectory
          .createTemp();
      return dir.childFile('flag.svg')..writeAsStringSync(
        '<svg xmlns="http://www.w3.org/2000/svg" width="3" height="2">'
        '<rect width="3" height="2" fill="red"/></svg>',
      );
    });
    when(
      () => cache.getSingleFile(svg.toString()),
    ).thenAnswer((_) async => file!);
    await pump(tester, svgUrl: svg);
    // Let the SVG load from disk.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byIcon(Icons.flag_outlined), findsNothing);
  });

  testWidgets('if the SVG fails too, the placeholder shows', (tester) async {
    when(
      () => cache.getSingleFile(svg.toString()),
    ).thenAnswer((_) async => throw const HttpException('404'));
    await pump(tester, svgUrl: svg);
    expect(find.byType(SvgPicture), findsNothing);
    expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
  });

  testWidgets('with neither, the placeholder shows', (tester) async {
    await pump(tester);
    expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
  });
}
