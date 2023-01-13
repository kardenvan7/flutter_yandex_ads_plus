import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_parameters/interstitial_ad_platform_parameters.dart';

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
    AdParameters? parameters,
  }) async {
    final platformParams = InterstitialAdPlatformParameters(
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
