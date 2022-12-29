import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/ad_event_streams_coordinator.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/basic/basic_ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/native/native_ad_event_listener.dart';

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

  /// Instance of a streams listeners coordinator.
  ///
  late AdEventStreamsCoordinator _streamsCoordinator;

  /// Performs initialization steps
  ///
  void initialize() {
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

  /// Creates and saves in property an instance of a stream coordinator.
  ///
  /// Repeating calls do nothing.
  ///
  void _setUpStreamCoordinator() {
    _streamsCoordinator = AdEventStreamsCoordinator();
  }
}
