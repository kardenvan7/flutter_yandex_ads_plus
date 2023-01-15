import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/interstitial_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event_stream_receiver/ad_event_listener/ad_event_listener.dart';

class InterstitialAdEventListener extends BasicAdEventListener {
  const InterstitialAdEventListener({
    required super.uid,
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

  final void Function(int? code, String? description)? onAdFailedToAppear;
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
}
