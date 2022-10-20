import 'package:flutter_yandex_ads_plus/pigeons/interstitial.dart';
import 'package:flutter_yandex_ads_plus/yandex.dart';

class YandexAdsInterstitialComponents {
  YandexAdsInterstitialComponents({
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onImpression,
    Function? onAdClicked,
    Function? onLeftApplication,
    Function? onReturnedToApplication,
    Function? onAdShown,
    Function? onAdDismissed,
    required this.id,
    required this.ads,
  }) {
    interstitial = YandexAdsInterstitial();
    if (onAdLoaded != null) {
      ads.setOnAdLoaded(id, EventType.interstitial, onAdLoaded);
    }

    if (onAdFailedToLoad != null) {
      ads.setOnAdFailedToLoad(id, EventType.interstitial, onAdFailedToLoad);
    }

    if (onImpression != null) {
      ads.setOnImpression(id, EventType.interstitial, onImpression);
    }

    if (onAdClicked != null) {
      ads.setOnAdCLicked(id, EventType.interstitial, onAdClicked);
    }

    if (onLeftApplication != null) {
      ads.setOnLeftApplication(id, EventType.interstitial, onLeftApplication);
    }

    if (onReturnedToApplication != null) {
      ads.setOnReturnedToApplication(
          id, EventType.interstitial, onReturnedToApplication);
    }

    if (onAdShown != null) {
      ads.setOnAdShown(id, EventType.interstitial, onAdShown);
    }

    if (onAdDismissed != null) {
      ads.setOnAdDismissed(id, EventType.interstitial, onAdDismissed);
    }
  }

  final String id;
  final FlutterYandexAds ads;
  late YandexAdsInterstitial interstitial;

  void load() {
    interstitial.load(id);
  }

  void show() {
    interstitial.show();
  }
}
