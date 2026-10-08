import 'dart:developer' as developer;

import 'package:logging/logging.dart';

/// Sends `package:logging` records to the platform log, where they show up
/// in `flutter run` output and DevTools.
void setUpLogging({Level level = Level.INFO}) {
  Logger.root.level = level;
  Logger.root.onRecord.listen((record) {
    developer.log(
      record.message,
      name: record.loggerName,
      level: record.level.value,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}
