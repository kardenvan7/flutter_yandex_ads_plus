library flutter_yandex_ads_plus;

import 'package:flutter_yandex_ads_plus/src/src.dart';

export 'src/components/components.dart';
export 'src/core/core.dart';
export 'src/widgets/widgets.dart';

class FlutterYandexAdsPlus {
  static FlutterYandexAdsApi? _apiInstance;

  static FlutterYandexAdsApi get api {
    return _apiInstance ??= FlutterYandexAdsApi();
  }

  static Future<void> setAgeRestrictedUser(bool value) {
    return api.setAgeRestrictedUser(value);
  }

  static Future<void> enableLogging(bool value) {
    return api.enableLogging(value);
  }

  static Future<void> enableDebugErrorIndicator(bool value) {
    return api.enableDebugErrorIndicator(value);
  }

  static Future<void> setLocationConsent(bool value) {
    return api.setLocationConsent(value);
  }

  static Future<void> setUserConsent(bool value) {
    return api.setUserConsent(value);
  }

  static Future<String?> getNativeLibraryVersion() {
    return api.getNativeLibraryVersion();
  }
}
