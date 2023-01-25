import 'package:flutter_yandex_ads_plus/src/core/ad_event_listener/ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_event_listener/rewarded_ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';

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
  void addAdEventListener(String uid, AdEventListener listener) {
    _eventStreamReceiver.addEventListener(uid, listener);
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
    InterstitialAdEventListener? listener,
  }) async {
    final updatedListener = listener?.copyWith(
      onAdFailedToLoad: (int? code, String? description) {
        removeInterstitialAd(uid);
        listener.onAdFailedToAppear?.call(code, description);
      },
    );

    if (updatedListener != null) {
      addAdEventListener(uid, updatedListener);
    }

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

  /// Loads an rewarded ad with given parameters.
  ///
  /// If ad with given [uid] already exists, it is destroyed and a new one
  /// is created on its place.
  ///
  Future<void> loadRewardedAd({
    required String uid,
    required String adId,
    YandexAdParameters? parameters,
    RewardedAdEventListener? listener,
  }) async {
    final updatedListener = listener?.copyWith(
      onAdFailedToLoad: (int? code, String? description) {
        removeRewardedAd(uid);
        listener.onAdFailedToAppear?.call(code, description);
      },
    );

    if (updatedListener != null) {
      addAdEventListener(uid, updatedListener);
    }

    return _methodCallDispatcher.loadRewardedAd(
      uid: uid,
      adId: adId,
      parameters: parameters,
    );
  }

  /// Shows rewarded ad with given [uid], if it's already loaded.
  /// If not, throws a platform exception.
  ///
  Future<void> showRewardedAd({
    required String uid,
  }) {
    return _methodCallDispatcher.showRewardedAd(uid: uid);
  }

  /// Removes listener for rewarded ad with given [uid] and removes it on
  /// platform-side.
  ///
  Future<void> removeRewardedAd(String uid) async {
    removeAdEventListener(uid);
    _methodCallDispatcher.removeRewardedAd(uid: uid);
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
