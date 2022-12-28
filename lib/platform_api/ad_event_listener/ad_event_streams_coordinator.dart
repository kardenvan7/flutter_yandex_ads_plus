import 'package:flutter_yandex_ads_plus/platform_api/config.dart';

import 'basic/basic_ad_event_listener.dart';
import 'basic/basic_ad_event_stream_receiver.dart';

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
  final BasicAdEventStreamReceiver bannerAdEventsReceiver =
      BasicAdEventStreamReceiver(
    channelName: PlatformApiConfig.bannerAdEventChannelName,
  );

  /// Native ad events receiver
  ///
  final BasicAdEventStreamReceiver nativeAdEventsReceiver =
      BasicAdEventStreamReceiver(
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
  void addNativeAdEventListener(BasicAdEventListener listener) {
    nativeAdEventsReceiver.addEventListener(listener);
  }

  /// Removes listener with corresponding [viewUid] from the list of listeners
  /// able to receive native ad events
  ///
  void removeNativeAdEventListener(String viewUid) {
    nativeAdEventsReceiver.removeEventListener(viewUid);
  }
}
