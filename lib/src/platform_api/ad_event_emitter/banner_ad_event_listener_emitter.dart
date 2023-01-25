import 'package:flutter_yandex_ads_plus/src/core/ad_event_listener/banner_ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/banner_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event_emitter/ad_event_listener_emitter.dart';

class BannerAdEventEmitter extends AdEventEmitter {
  const BannerAdEventEmitter({
    required this.listener,
  });

  @override
  final BannerAdEventListener listener;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final type = BannerAdEventType.fromString(event.type);

    switch (type) {
      case BannerAdEventType.onAdLoaded:
        listener.onAdLoaded?.call();
        break;

      case BannerAdEventType.onAdFailedToLoad:
        listener.onAdFailedToLoad?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case BannerAdEventType.onLeftApplication:
        listener.onLeftApplication?.call();
        break;

      case BannerAdEventType.onReturnedToApplication:
        listener.onReturnedToApplication?.call();
        break;

      case BannerAdEventType.onAdClicked:
        listener.onAdClicked?.call();
        break;

      case BannerAdEventType.onImpression:
        final data = event.parameters?['data'];

        listener.onImpression?.call(data);
        break;

      case BannerAdEventType.didDismissScreen:
        listener.didDismissScreen?.call();
        break;

      case BannerAdEventType.willPresentScreen:
        listener.willPresentScreen?.call();
        break;

      case BannerAdEventType.unknown:
        return;
    }
  }
}
