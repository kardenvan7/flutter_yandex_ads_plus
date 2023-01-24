import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';

abstract class FlutterYandexAdsPlusMethodCallDispatcher {
  Future<void> loadInterstitialAd({
    required String uid,
    required String adId,
    YandexAdParameters? parameters,
  });

  Future<void> showInterstitialAd({
    required String uid,
  });

  Future<void> removeInterstitialAd({
    required String uid,
  });

  Future<void> setAgeRestrictedUser(bool value);

  Future<void> enableLogging(bool value);

  Future<void> enableDebugErrorIndicator(bool value);

  Future<void> setLocationConsent(bool value);

  Future<void> setUserConsent(bool value);

  Future<String?> getNativeLibraryVersion();
}
