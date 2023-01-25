import 'package:flutter_yandex_ads_plus/src/src.dart';

/// Flutter implementation Androids [InterstitialAd] and [YMAInterstitialAd]
/// from iOS.
///
/// Use method [load] to preload the ad with needed [parameters]. To track ad
/// events such as [onAdLoaded], [onAdFailedToLoad], etc. use [listener]
/// property.
///
/// Use [show] method to show preloaded ad.
///
/// When current instance of the ad is no longer needed use [dispose] method
/// to clean up the memory.
///
class InterstitialYandexAd {
  InterstitialYandexAd({
    required String adId,
  }) : _adId = adId;

  final String _adId;

  final FlutterYandexAdsApi _api = FlutterYandexAdsApi();
  final String _uid = UniqueIdGenerator.generate();

  /// Creates and loads the ad with given [parameters].
  ///
  /// [Listener] is responsible for tracking ad events.
  ///
  Future<void> load({
    YandexAdParameters? parameters,
    InterstitialAdEventListener? listener,
  }) {
    return _api.loadInterstitialAd(
      uid: _uid,
      adId: _adId,
      parameters: parameters,
      listener: listener,
    );
  }

  /// Shows preloaded ad. If used before ad is loaded,
  /// throws a platform Exception. Use [onAdLoaded] and [onAdFailedToLoad]
  /// callbacks from [listener] in [load] method to track ad load status.
  ///
  Future<void> show() {
    return _api.showInterstitialAd(uid: _uid);
  }

  /// Cleans up the memory. Don't use the instance after calling this method.
  ///
  void dispose() {
    _api.removeInterstitialAd(_uid);
  }
}
