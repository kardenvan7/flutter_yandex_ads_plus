import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/core/callback_definitions.dart';

import 'ad_event_stream_receiver/ad_event_stream_receiver.dart';
import 'ad_method_call_dispatcher/ad_method_call_dispatcher.dart';
import 'ad_method_call_dispatcher/flutter_yandex_ads_plus_method_call_dispatcher.dart';
import 'platform_api_config.dart';

/// Class responsible for initialization of components of FlutterYandexAdsPlus
/// plugin.
///
class FlutterYandexAdsApi {
  FlutterYandexAdsApi._();

  factory FlutterYandexAdsApi() {
    return _instance ??= FlutterYandexAdsApi._();
  }

  /// Singleton instance of this class
  ///
  static FlutterYandexAdsApi? _instance;

  /// Instance of method call dispatcher from Flutter to platform
  ///
  final FlutterYandexAdsPlusMethodCallDispatcher _methodCallDispatcher =
      AdMethodCallDispatcher(channelName: PlatformApiConfig.methodChannelName);

  /// Instance of a platform-to-Flutter event stream receiver.
  ///
  final AdEventStreamReceiver _eventStreamReceiver =
      AdEventStreamReceiver(channelName: PlatformApiConfig.eventChannelName);

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
  void removeAdEventListener(String uid) {
    _eventStreamReceiver.removeEventListener(uid);
  }

  /// Loads an interstitial ad with given parameters.
  ///
  /// If ad with given [uid] already exists, it is destroyed and a new one
  /// is created on its place.
  ///
  Future<void> loadInterstitialAd({
    required String uid,
    required String adId,
    YandexAdParameters? parameters,
    VoidCallback? onAdLoaded,
    YandexAdErrorCallback? onAdFailedToLoad,
    YandexAdImpressionCallback? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    YandexAdErrorCallback? onAdFailedToAppear,
    VoidCallback? onAdWillAppear,
    VoidCallback? onAdShown,
    VoidCallback? onAdWillDisappear,
    VoidCallback? onAdDismissed,
  }) async {
    final listener = InterstitialAdEventListener(
      uid: uid,
      onAdLoaded: onAdLoaded,
      onAdFailedToLoad: (code, desc) {
        onAdFailedToLoad?.call(code, desc);
        removeInterstitialAd(uid);
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
      },
    );

    addAdEventListener(listener);

    return _methodCallDispatcher.loadInterstitialAd(
      uid: uid,
      adId: adId,
      parameters: parameters,
    );
  }

  /// Shows interstitial ad with given [uid], if it's already loaded.
  /// If not, throws a platform exception.
  ///
  Future<void> showInterstitialAd({
    required String uid,
  }) {
    return _methodCallDispatcher.showInterstitialAd(uid: uid);
  }

  Future<void> removeInterstitialAd(String uid) async {
    removeAdEventListener(uid);
    _methodCallDispatcher.removeInterstitialAd(uid: uid);
  }

  Future<void> setAgeRestrictedUser(bool value) {
    return _methodCallDispatcher.setAgeRestrictedUser(value);
  }

  Future<void> enableLogging(bool value) {
    return _methodCallDispatcher.enableLogging(value);
  }

  Future<void> enableDebugErrorIndicator(bool value) {
    return _methodCallDispatcher.enableDebugErrorIndicator(value);
  }

  Future<void> setLocationConsent(bool value) async {
    return _methodCallDispatcher.setLocationConsent(value);
  }

  Future<void> setUserConsent(bool value) async {
    return _methodCallDispatcher.setUserConsent(value);
  }

  Future<String?> getNativeLibraryVersion() {
    return _methodCallDispatcher.getNativeLibraryVersion();
  }

  /// Cleans up memory
  ///
  void dispose() {
    _eventStreamReceiver.dispose();
  }
}
