import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/ad_event_streams_coordinator.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/interstitial/interstitial_ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_method_call_dispatcher/ad_method_call_dispatcher.dart';
import 'package:flutter_yandex_ads_plus/platform_api/config.dart';

import 'ad_event_listener/ad_event_listener.dart';

/// Class responsible for initialization of components of FlutterYandexAdsPlus
/// plugin.
///
class FlutterYandexAdsApi {
  FlutterYandexAdsApi._() {
    initialize();
  }

  factory FlutterYandexAdsApi() {
    _instance ??= FlutterYandexAdsApi._();

    return _instance!;
  }

  /// Singleton instance of this class
  ///
  static FlutterYandexAdsApi? _instance;

  /// Method call dispatcher from Flutter to platform
  ///
  late AdMethodCallDispatcher _methodCallDispatcher;

  /// Instance of a platform-to-Flutter event streams coordinator.
  ///
  late AdEventStreamsCoordinator _streamsCoordinator;

  /// Performs initialization steps
  ///
  void initialize() {
    _setUpMethodCallDispatcher();
    _setUpStreamCoordinator();
  }

  /// Cleans up memory
  ///
  void dispose() {
    _streamsCoordinator.dispose();
  }

  /// Adds event listener for banner ad view.
  ///
  /// Every next call for the same ad view overrides previous one.
  ///
  void addBannerAdEventListener(BasicAdEventListener listener) {
    _streamsCoordinator.addBannerAdEventListener(listener);
  }

  /// Removes event listener for banner ad view.
  ///
  /// Does nothing if listener was not set up for this ad view.
  ///
  void removeBannerAdEventListener(String viewUId) {
    _streamsCoordinator.removeBannerAdEventListener(viewUId);
  }

  /// Adds event listener for native ad view.
  ///
  /// Every next call for the same ad view overrides previous one.
  ///
  void addNativeAdEventListener(NativeAdEventListener listener) {
    _streamsCoordinator.addNativeAdEventListener(listener);
  }

  /// Removes event listener for native ad view.
  ///
  /// Does nothing if listener was not set up for this ad view.
  ///
  void removeNativeAdEventListener(String viewUId) {
    _streamsCoordinator.removeNativeAdEventListener(viewUId);
  }

  /// Adds event listener for native ad view.
  ///
  /// Every next call for the same ad view overrides previous one.
  ///
  void addInterstitialAdEventListener(InterstitialAdEventListener listener) {
    _streamsCoordinator.addInterstitialAdEventListener(listener);
  }

  /// Removes event listener for native ad view.
  ///
  /// Does nothing if listener was not set up for this ad view.
  ///
  void removeInterstitialAdEventListener(String viewUId) {
    _streamsCoordinator.removeInterstitialAdEventListener(viewUId);
  }

  /// Platform request to show native [InterstitialAd]
  ///
  Future<void> showInterstitialAd({
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
    await _methodCallDispatcher.showInterstitialAd(
      adId: adId,
      parameters: parameters,
    );

    final listener = InterstitialAdEventListener(
      viewUid: adId,
      onAdLoaded: onAdLoaded,
      onAdFailedToLoad: (code, desc) {
        onAdFailedToLoad?.call(code, desc);
        _streamsCoordinator.removeInterstitialAdEventListener(adId);
      },
      onImpression: onImpression,
      onAdClicked: onAdClicked,
      onLeftApplication: onLeftApplication,
      onReturnedToApplication: onReturnedToApplication,
      onAdShown: onAdShown,
      onAdDismissed: () {
        onAdDismissed?.call();
        _streamsCoordinator.removeInterstitialAdEventListener(adId);
      },
    );

    _streamsCoordinator.addInterstitialAdEventListener(listener);
  }

  void _setUpMethodCallDispatcher() {
    _methodCallDispatcher = AdMethodCallDispatcher(
      channelName: PlatformApiConfig.methodChannelName,
    );
  }

  /// Creates and saves in property an instance of a stream coordinator.
  ///
  /// Repeating calls do nothing.
  ///
  void _setUpStreamCoordinator() {
    _streamsCoordinator = AdEventStreamsCoordinator();
  }
}
