import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event/type/interstitial_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/ad_event_listener.dart';

class InterstitialAdEventListener extends BasicAdEventListener {
  const InterstitialAdEventListener({
    required super.viewUid,
    super.onAdLoaded,
    super.onImpression,
    super.onAdClicked,
    super.onReturnedToApplication,
    super.onLeftApplication,
    super.onAdFailedToLoad,
    super.willPresentScreen,
    super.didDismissScreen,
    this.onAdShown,
    this.onAdDismissed,
  });

  final VoidCallback? onAdShown;
  final VoidCallback? onAdDismissed;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final eventType = InterstitialAdEventType.fromString(event.type);

    switch (eventType) {
      case InterstitialAdEventType.onAdShown:
        onAdShown?.call();
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
