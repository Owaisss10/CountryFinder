import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Keeps flag images on disk for a year so they still show offline.
class FlagCacheManager extends CacheManager with ImageCacheManager {
  factory FlagCacheManager() => _instance;

  FlagCacheManager._()
    : super(
        Config(
          key,
          stalePeriod: const Duration(days: 365),
          maxNrOfCacheObjects: 1000,
        ),
      );

  static const key = 'flagImages';
  static final FlagCacheManager _instance = FlagCacheManager._();
}
