import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';

/// Listener for interstitial ad events.
///
class InterstitialAdEventListener extends AdEventListener {
  const InterstitialAdEventListener({
    this.onAdLoaded,
    this.onImpression,
    this.onAdClicked,
    this.onReturnedToApplication,
    this.onLeftApplication,
    this.onAdFailedToLoad,
    this.willPresentScreen,
    this.didDismissScreen,
    this.onAdFailedToAppear,
    this.onAdShown,
    this.onAdWillBeShown,
    this.onAdDismissed,
    this.onAdWillBeDismissed,
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

  /// Callback triggered when ad fails to appear.
  ///
  final YandexAdErrorCallback? onAdFailedToAppear;

  /// Callback triggered before ad appears on screen.
  ///
  ///  Due to YandexAds native SDK limitation this callback works only on iOS.
  ///
  final VoidCallback? onAdWillBeShown;

  /// Callback triggered when ad appears on screen.
  ///
  final VoidCallback? onAdShown;

  /// Callback triggered before ad is dismissed from screen.
  ///
  /// Due to YandexAds native SDK limitation this callback works only on iOS.
  ///
  final VoidCallback? onAdWillBeDismissed;

  /// Callback triggered after ad is dismissed from screen.
  ///
  final VoidCallback? onAdDismissed;

  InterstitialAdEventListener copyWith({
    VoidCallback? onAdLoaded,
    YandexAdErrorCallback? onAdFailedToLoad,
    YandexAdImpressionCallback? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    VoidCallback? didDismissScreen,
    VoidCallback? willPresentScreen,
    YandexAdErrorCallback? onAdFailedToAppear,
    VoidCallback? onAdShown,
    VoidCallback? onAdWillBeShown,
    VoidCallback? onAdDismissed,
    VoidCallback? onAdWillBeDismissed,
  }) {
    return InterstitialAdEventListener(
      onAdLoaded: onAdLoaded ?? this.onAdLoaded,
      onAdFailedToLoad: onAdFailedToLoad ?? this.onAdFailedToLoad,
      onImpression: onImpression ?? this.onImpression,
      onAdClicked: onAdClicked ?? this.onAdClicked,
      onLeftApplication: onLeftApplication ?? this.onLeftApplication,
      onReturnedToApplication:
          onReturnedToApplication ?? this.onReturnedToApplication,
      didDismissScreen: didDismissScreen ?? this.didDismissScreen,
      willPresentScreen: willPresentScreen ?? this.willPresentScreen,
      onAdFailedToAppear: onAdFailedToAppear ?? this.onAdFailedToAppear,
      onAdShown: onAdShown ?? this.onAdShown,
      onAdWillBeShown: onAdWillBeShown ?? this.onAdWillBeShown,
      onAdDismissed: onAdDismissed ?? this.onAdDismissed,
      onAdWillBeDismissed: onAdWillBeDismissed ?? this.onAdWillBeDismissed,
    );
  }
}
