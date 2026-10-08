import 'package:flutter/material.dart';

extension PlatformContext on BuildContext {
  /// Uses the theme's platform so it follows debug platform overrides.
  bool get isCupertino {
    final platform = Theme.of(this).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }
}
