import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static final CacheManager instance = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7), // Cache expiration
      maxNrOfCacheObjects: 100, // Max number of images to cache
    ),
  );
}
