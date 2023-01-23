import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/platform_parameters/interstitial_yandex_ad_platform_parameters.dart';

import 'flutter_yandex_ads_plus_method_call_dispatcher.dart';

class AdMethodCallDispatcher extends FlutterYandexAdsPlusMethodCallDispatcher {
  AdMethodCallDispatcher({
    required String channelName,
  }) {
    _setUpMethodChannel(channelName);
  }

  late final MethodChannel _methodChannel;

  @override
  Future<void> loadInterstitialAd({
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
      'loadInterstitialAd',
      platformParams.toJson(),
    );
  }

  @override
  Future<void> showInterstitialAd({
    required String uid,
  }) async {
    await _methodChannel.invokeMethod(
      'showInterstitialAd',
      uid,
    );
  }

  @override
  Future<void> removeInterstitialAd({
    required String uid,
  }) async {
    await _methodChannel.invokeMethod(
      'removeInterstitialAd',
      uid,
    );
  }

  void _setUpMethodChannel(String name) {
    _methodChannel = MethodChannel(name);
  }
}
