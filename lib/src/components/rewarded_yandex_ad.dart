import 'package:flutter_yandex_ads_plus/src/src.dart';

/// Flutter implementation Androids [RewardedAd] and [YMARewardedAd]
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
class RewardedYandexAd {
  RewardedYandexAd({
    required String adId,
  }) : _adId = adId;

  final String _adId;

  final FlutterYandexAdsApi _api = FlutterYandexAdsApi();
  final String _uid = UniqueIdGenerator.generate();

  Future<void> load({
    YandexAdParameters? parameters,
    RewardedAdEventListener? listener,
  }) {
    return _api.loadRewardedAd(
      uid: _uid,
      adId: _adId,
      parameters: parameters,
      listener: listener,
    );
  }

  /// Shows preloaded ad. If used before ad is loaded,
  /// throws a platform Exception. Use [onAdLoaded] and [onAdFailedToLoad]
  /// callbacks from [load] method to track ad load status.
  ///
  Future<void> show() {
    return _api.showRewardedAd(uid: _uid);
  }

  /// Cleans up the memory. Don't use the instance after calling this method.
  ///
  void dispose() {
    _api.removeRewardedAd(_uid);
  }
}
