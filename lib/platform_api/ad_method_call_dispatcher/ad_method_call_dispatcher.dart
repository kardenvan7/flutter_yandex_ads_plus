import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';

class AdMethodCallDispatcher {
  AdMethodCallDispatcher({
    required String channelName,
  }) {
    _setUpMethodChannel(channelName);
  }

  late MethodChannel _methodChannel;

  Future<void> showInterstitialAd({
    required String adId,
    AdParameters? parameters,
  }) async {
    await _methodChannel.invokeMethod('showInterstitialAd', {
      'ad_uid': adId,
      'parameters': parameters?.toJson(),
    });
  }

  void _setUpMethodChannel(String name) {
    _methodChannel = MethodChannel(name);
  }
}
