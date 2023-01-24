library flutter_yandex_ads_plus;

import 'package:flutter_yandex_ads_plus/src/src.dart';

export 'src/components/components.dart';
export 'src/core/core.dart';
export 'src/widgets/widgets.dart';

class FlutterYandexAdsPlus {
  static FlutterYandexAdsApi? _apiInstance;

  static FlutterYandexAdsApi get _api {
    return _apiInstance ??= FlutterYandexAdsApi();
  }

  /// Sets user age restriction.
  ///
  /// Works only on Android. On any other platform throws [NotImplemented]
  ///
  static Future<void> setAgeRestrictedUser(bool value) {
    return _api.setAgeRestrictedUser(value);
  }

  /// Enables/disables console logging.
  ///
  /// By default, logging is disabled.
  /// On iOS, once enabled, logging can be disabled only by restarting the app.
  ///
  static Future<void> enableLogging(bool value) {
    return _api.enableLogging(value);
  }

  /// Enabled/disabled debug error indicator for ads.
  ///
  static Future<void> enableDebugErrorIndicator(bool value) {
    return _api.enableDebugErrorIndicator(value);
  }

  /// Sets location consent given by the user.
  ///
  static Future<void> setLocationConsent(bool value) {
    return _api.setLocationConsent(value);
  }

  /// Sets consent given by user.
  ///
  static Future<void> setUserConsent(bool value) {
    return _api.setUserConsent(value);
  }

  /// Returns version of a native library.
  ///
  static Future<String?> getNativeLibraryVersion() {
    return _api.getNativeLibraryVersion();
  }
}
