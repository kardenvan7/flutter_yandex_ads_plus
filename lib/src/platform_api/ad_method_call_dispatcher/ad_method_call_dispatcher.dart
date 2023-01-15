import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/platform_parameters/interstitial_yandex_ad_platform_parameters.dart';

class AdMethodCallDispatcher {
  AdMethodCallDispatcher({
    required String channelName,
  }) {
    _setUpMethodChannel(channelName);
  }

  late MethodChannel _methodChannel;

  Future<void> showInterstitialAd({
    required String uid,
    required String adId,
    YandexAdParameters? parameters,
  }) async {
    final platformParams = InterstitialYandexAdPlatformParameters(
      adId: adId,
      uid: uid,
      parameters: parameters,
    );

    await _methodChannel.invokeMethod(
      'showInterstitialAd',
      platformParams.toJson(),
    );
  }

  void _setUpMethodChannel(String name) {
    _methodChannel = MethodChannel(name);
  }
}
