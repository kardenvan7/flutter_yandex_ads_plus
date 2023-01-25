import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/interstitial_ad_event_type.dart';

class InterstitialAdEventListener extends BannerAdEventListener {
  const InterstitialAdEventListener({
    super.onAdLoaded,
    super.onImpression,
    super.onAdClicked,
    super.onReturnedToApplication,
    super.onLeftApplication,
    super.onAdFailedToLoad,
    super.willPresentScreen,
    super.didDismissScreen,
    this.onAdFailedToAppear,
    this.onAdShown,
    this.onAdWillBeShown,
    this.onAdDismissed,
    this.onAdWillBeDismissed,
  });

  final YandexAdErrorCallback? onAdFailedToAppear;
  final VoidCallback? onAdShown;
  final VoidCallback? onAdWillBeShown;
  final VoidCallback? onAdDismissed;
  final VoidCallback? onAdWillBeDismissed;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final eventType = InterstitialAdEventType.fromString(event.type);

    switch (eventType) {
      case InterstitialAdEventType.onAdFailedToAppear:
        onAdFailedToAppear?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case InterstitialAdEventType.onAdWillBeShown:
        onAdWillBeShown?.call();
        break;

      case InterstitialAdEventType.onAdShown:
        onAdShown?.call();
        break;

      case InterstitialAdEventType.onAdWillBeDismissed:
        onAdWillBeDismissed?.call();
        break;

      case InterstitialAdEventType.onAdDismissed:
        onAdDismissed?.call();
        break;

      case InterstitialAdEventType.unknown:
        super.emitCallbackByEvent(event);
        break;
    }
  }

  @override
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
