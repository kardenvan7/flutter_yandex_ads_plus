import 'package:flutter_yandex_ads_plus/src/core/ad_event_listener/interstitial_ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/interstitial_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event_emitter/ad_event_listener_emitter.dart';

class InterstitialAdEventEmitter extends AdEventEmitter {
  const InterstitialAdEventEmitter({
    required this.listener,
  });

  @override
  final InterstitialAdEventListener listener;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final type = InterstitialAdEventType.fromString(event.type);

    switch (type) {
      case InterstitialAdEventType.onAdLoaded:
        listener.onAdLoaded?.call();
        break;

      case InterstitialAdEventType.onAdFailedToLoad:
        listener.onAdFailedToLoad?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case InterstitialAdEventType.onLeftApplication:
        listener.onLeftApplication?.call();
        break;

      case InterstitialAdEventType.onReturnedToApplication:
        listener.onReturnedToApplication?.call();
        break;

      case InterstitialAdEventType.onAdClicked:
        listener.onAdClicked?.call();
        break;

      case InterstitialAdEventType.onImpression:
        final data = event.parameters?['data'];

        listener.onImpression?.call(data);
        break;

      case InterstitialAdEventType.didDismissScreen:
        listener.didDismissScreen?.call();
        break;

      case InterstitialAdEventType.willPresentScreen:
        listener.willPresentScreen?.call();
        break;

      case InterstitialAdEventType.onAdFailedToAppear:
        listener.onAdFailedToAppear?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case InterstitialAdEventType.onAdWillBeShown:
        listener.onAdWillBeShown?.call();
        break;

      case InterstitialAdEventType.onAdShown:
        listener.onAdShown?.call();
        break;

      case InterstitialAdEventType.onAdWillBeDismissed:
        listener.onAdWillBeDismissed?.call();
        break;

      case InterstitialAdEventType.onAdDismissed:
        listener.onAdDismissed?.call();
        break;

      case InterstitialAdEventType.unknown:
        return;
    }
  }
}
