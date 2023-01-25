import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';

import 'ad_event_listener.dart';

/// Listener for banner ad events.
///
class BannerAdEventListener extends AdEventListener {
  const BannerAdEventListener({
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onImpression,
    this.onAdClicked,
    this.onLeftApplication,
    this.onReturnedToApplication,
    this.willPresentScreen,
    this.didDismissScreen,
  });

  /// Callback triggered when the ad is successfully loaded.
  ///
  final VoidCallback? onAdLoaded;

  /// Callback triggered when ad is failed to load. Passes
  /// error code and error description as parameter.
  ///
  final YandexAdErrorCallback? onAdFailedToLoad;

  /// Callback triggered when [impression] is tracked.
  ///
  final YandexAdImpressionCallback? onImpression;

  /// Callback triggered when user taps on the ad.
  ///
  final VoidCallback? onAdClicked;

  /// Callback triggered when app is moved to background due to interacting
  /// with the ad (primarily, on ad tap).
  ///
  final VoidCallback? onLeftApplication;

  /// Callback triggered when app is returned to foreground after events that
  /// triggered [onLeftApplication].
  ///
  /// Due to YandexAds native SDK limitations this callback works only on
  /// Android.
  ///
  final VoidCallback? onReturnedToApplication;

  /// Callback triggered when ad will show the modal in response to the user
  /// interacting with the banner.
  ///
  /// Due to YandexAds native SDK limitations this callback works only on iOS.
  ///
  final VoidCallback? willPresentScreen;

  /// Callback triggered when ad finished showing the modal in response to the
  /// user interacting with the banner.
  ///
  /// Due to YandexAds native SDK limitations this callback works only on iOS.
  ///
  final VoidCallback? didDismissScreen;

  BannerAdEventListener copyWith({
    VoidCallback? onAdLoaded,
    YandexAdErrorCallback? onAdFailedToLoad,
    YandexAdImpressionCallback? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    VoidCallback? willPresentScreen,
    VoidCallback? didDismissScreen,
  }) {
    return BannerAdEventListener(
      onAdLoaded: onAdLoaded ?? this.onAdLoaded,
      onAdFailedToLoad: onAdFailedToLoad ?? this.onAdFailedToLoad,
      onImpression: onImpression ?? this.onImpression,
      onAdClicked: onAdClicked ?? this.onAdClicked,
      onLeftApplication: onLeftApplication ?? this.onLeftApplication,
      onReturnedToApplication:
          onReturnedToApplication ?? this.onReturnedToApplication,
      willPresentScreen: willPresentScreen ?? this.willPresentScreen,
      didDismissScreen: didDismissScreen ?? this.didDismissScreen,
    );
  }
}
