import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/platform_api/flutter_yandex_ads_api.dart';

import 'core/ad_parameters/ad_parameters.dart';

export 'core/ad_parameters/ad_parameters.dart';
export 'widgets/widgets.dart';

class FlutterYandexAdsPlus {
  const FlutterYandexAdsPlus._();

  /// Request to show native interstitial (fullscreen) ad
  /// (android [InterstitialAd], iOS [YMAInterstitialAd]).
  ///
  static Future<void> showInterstitialAd({
    required String adId,
    AdParameters? parameters,
    VoidCallback? onAdLoaded,
    void Function(int code, String description)? onAdFailedToLoad,
    void Function(String? impression)? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    VoidCallback? onAdShown,
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
      onAdShown: onAdShown,
      onAdDismissed: onAdDismissed,
    );
  }
}
