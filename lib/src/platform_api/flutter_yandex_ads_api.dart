import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/utils/unique_id_generator.dart';

import 'ad_event_stream_receiver/ad_event_stream_receiver.dart';
import 'ad_method_call_dispatcher/ad_method_call_dispatcher.dart';
import 'platform_api_config.dart';

/// Class responsible for initialization of components of FlutterYandexAdsPlus
/// plugin.
///
class FlutterYandexAdsApi {
  FlutterYandexAdsApi._();

  factory FlutterYandexAdsApi() {
    _instance ??= FlutterYandexAdsApi._();

    return _instance!;
  }

  /// Singleton instance of this class
  ///
  static FlutterYandexAdsApi? _instance;

  /// Instance of method call dispatcher from Flutter to platform
  ///
  final AdMethodCallDispatcher _methodCallDispatcher = AdMethodCallDispatcher(
    channelName: PlatformApiConfig.methodChannelName,
  );

  /// Instance of a platform-to-Flutter event stream receiver.
  ///
  final AdEventStreamReceiver _eventStreamReceiver = AdEventStreamReceiver(
    channelName: PlatformApiConfig.eventChannelName,
  );

  /// Adds event listener for ad view.
  ///
  /// Every next call for the same ad view overrides previous one.
  ///
  void addAdEventListener(AdEventListener listener) {
    _eventStreamReceiver.addEventListener(listener);
  }

  /// Removes event listener for banner ad view.
  ///
  /// Does nothing if listener was not set up for this ad view.
  ///
  void removeAdEventListener(String viewUId) {
    _eventStreamReceiver.removeEventListener(viewUId);
  }

  /// Platform request to show native [InterstitialAd]
  ///
  Future<void> showInterstitialAd({
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
    final uid = UniqueIdGenerator.generate();

    final listener = InterstitialAdEventListener(
      uid: uid,
      onAdLoaded: onAdLoaded,
      onAdFailedToLoad: (code, desc) {
        onAdFailedToLoad?.call(code, desc);
        _eventStreamReceiver.removeEventListener(adId);
      },
      onAdFailedToAppear: onAdFailedToAppear,
      onImpression: onImpression,
      onAdClicked: onAdClicked,
      onLeftApplication: onLeftApplication,
      onReturnedToApplication: onReturnedToApplication,
      onAdWillBeShown: onAdWillAppear,
      onAdShown: onAdShown,
      onAdWillBeDismissed: onAdWillDisappear,
      onAdDismissed: () {
        onAdDismissed?.call();
        _eventStreamReceiver.removeEventListener(adId);
      },
    );

    _eventStreamReceiver.addEventListener(listener);

    return _methodCallDispatcher.showInterstitialAd(
      uid: uid,
      adId: adId,
      parameters: parameters,
    );
  }

  /// Cleans up memory
  ///
  void dispose() {
    _eventStreamReceiver.dispose();
  }
}
