import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/src/src.dart';

class InterstitialYandexAd {
  InterstitialYandexAd({
    required String adId,
  }) : _adId = adId;

  final String _adId;

  final FlutterYandexAdsApi _api = FlutterYandexAdsApi();
  final String _uid = UniqueIdGenerator.generate();

  Future<void> load({
    YandexAdParameters? parameters,
    VoidCallback? onAdLoaded,
    YandexAdErrorCallback? onAdFailedToLoad,
    YandexAdImpressionCallback? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    YandexAdErrorCallback? onAdFailedToAppear,
    VoidCallback? onAdWillAppear,
    VoidCallback? onAdShown,
    VoidCallback? onAdWillDisappear,
    VoidCallback? onAdDismissed,
  }) {
    return _api.loadInterstitialAd(
      uid: _uid,
      adId: _adId,
      parameters: parameters,
      onAdLoaded: onAdLoaded,
      onAdFailedToLoad: onAdFailedToLoad,
      onAdDismissed: onAdDismissed,
      onAdShown: onAdShown,
      onReturnedToApplication: onReturnedToApplication,
      onLeftApplication: onLeftApplication,
      onAdClicked: onAdClicked,
      onImpression: onImpression,
      onAdFailedToAppear: onAdFailedToAppear,
      onAdWillAppear: onAdWillAppear,
      onAdWillDisappear: onAdWillDisappear,
    );
  }

  Future<void> show() {
    return _api.showInterstitialAd(uid: _uid);
  }
}
