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

  /// Sets user age restriction. Set a value indicating whether user is a child
  /// or undefined age. If the value is set to true personal data will not be
  /// collected.
  ///
  /// Works only on Android. On any other platform throws [NotImplemented].
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

  /// Enable or disable visibility error indicator in Debug Mode. Indicator is
  /// enabled by default.
  ///
  static Future<void> enableDebugErrorIndicator(bool value) {
    return _api.enableDebugErrorIndicator(value);
  }

  /// Enables/Disables location usage for ad loading. Disabled by default.
  /// Location permission is still required to be granted additionally to the
  /// consent.
  ///
  static Future<void> setLocationConsent(bool value) {
    return _api.setLocationConsent(value);
  }

  /// Set a value indicating whether user from GDPR region allowed to collect
  /// personal data which is used for analytics and ad targeting. If the value
  /// is set to false personal data will not be collected.
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
