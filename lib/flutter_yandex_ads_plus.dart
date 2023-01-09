import 'package:flutter_yandex_ads_plus/platform_api/flutter_yandex_ads_api.dart';

export 'widgets/widgets.dart';

class FlutterYandexAdsPlus {
  const FlutterYandexAdsPlus._();

  static void showInterstitialAd() {
    final api = FlutterYandexAdsApi();

    api.showInterstitialAd();
  }
}
