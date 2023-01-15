library flutter_yandex_ads_plus;

import 'package:flutter/foundation.dart';

import 'src/core/core.dart';
import 'src/platform_api/platform_api.dart';

export 'src/core/core.dart';
export 'src/widgets/widgets.dart';

class FlutterYandexAdsPlus {
  const FlutterYandexAdsPlus._();

  /// Request to show native interstitial (fullscreen) ad
  /// (android [InterstitialAd], iOS [YMAInterstitialAd]).
  ///
  static Future<void> showInterstitialAd({
    required String adId,
    YandexAdParameters? parameters,
    VoidCallback? onAdLoaded,
    void Function(int? code, String? description)? onAdFailedToLoad,
    void Function(String? impression)? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    void Function(int? code, String? description)? onAdFailedToAppear,
    VoidCallback? onAdWillAppear,
    VoidCallback? onAdShown,
    VoidCallback? onAdWillDisappear,
    VoidCallback? onAdDismissed,
  }) async {
    final api = FlutterYandexAdsApi();

    await api.showInterstitialAd(
      adId: adId,
      parameters: parameters,
      onAdLoaded: onAdLoaded,
      onAdFailedToLoad: onAdFailedToLoad,
      onImpression: onImpression,
      onAdClicked: onAdClicked,
      onLeftApplication: onLeftApplication,
      onReturnedToApplication: onReturnedToApplication,
      onAdFailedToAppear: onAdFailedToAppear,
      onAdWillAppear: onAdWillAppear,
      onAdShown: onAdShown,
      onAdWillDisappear: onAdWillDisappear,
      onAdDismissed: onAdDismissed,
    );
  }
}
