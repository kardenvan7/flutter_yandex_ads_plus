import 'package:flutter_yandex_ads_plus/platform_api/config.dart';

import 'ad_event_stream_receiver.dart';
import 'basic/basic_ad_event_listener.dart';
import 'native/native_ad_event_listener.dart';

/// Class-singleton responsible for adding and removing subscriptions to
/// different ad event streams.
///
class AdEventStreamsCoordinator {
  AdEventStreamsCoordinator._();

  static AdEventStreamsCoordinator? _instance;

  factory AdEventStreamsCoordinator() {
    _instance ??= AdEventStreamsCoordinator._();

    return _instance!;
  }

  /// Banner ad events receiver
  ///
  final AdEventStreamReceiver bannerAdEventsReceiver = AdEventStreamReceiver(
    channelName: PlatformApiConfig.bannerAdEventChannelName,
  );

  /// Native ad events receiver
  ///
  final AdEventStreamReceiver nativeAdEventsReceiver = AdEventStreamReceiver(
    channelName: PlatformApiConfig.nativeAdEventChannelName,
  );

  /// Adds listener to the list of listeners able to receive banner ad events
  ///
  void addBannerAdEventListener(BasicAdEventListener listener) {
    bannerAdEventsReceiver.addEventListener(listener);
  }

  /// Removes listener with corresponding [viewUid] from the list of listeners
  /// able to receive banner ad events
  ///
  void removeBannerAdEventListener(String viewUid) {
    bannerAdEventsReceiver.removeEventListener(viewUid);
  }

  /// Adds listener to the list of listeners able to receive native ad events
  ///
  void addNativeAdEventListener(NativeAdEventListener listener) {
    nativeAdEventsReceiver.addEventListener(listener);
  }

  /// Removes listener with corresponding [viewUid] from the list of listeners
  /// able to receive native ad events
  ///
  void removeNativeAdEventListener(String viewUid) {
    nativeAdEventsReceiver.removeEventListener(viewUid);
  }

  void dispose() {
    bannerAdEventsReceiver.dispose();
    nativeAdEventsReceiver.dispose();
  }
}
