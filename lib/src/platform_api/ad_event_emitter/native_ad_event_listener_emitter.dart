import 'package:flutter_yandex_ads_plus/src/core/core.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/native_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event_emitter/ad_event_listener_emitter.dart';

class NativeAdEventEmitter extends AdEventEmitter {
  const NativeAdEventEmitter({
    required this.listener,
  });

  @override
  final NativeAdEventListener listener;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final type = NativeAdEventType.fromString(event.type);

    switch (type) {
      case NativeAdEventType.onAdLoaded:
        listener.onAdLoaded?.call();
        break;

      case NativeAdEventType.onAdFailedToLoad:
        listener.onAdFailedToLoad?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case NativeAdEventType.onLeftApplication:
        listener.onLeftApplication?.call();
        break;

      case NativeAdEventType.onReturnedToApplication:
        listener.onReturnedToApplication?.call();
        break;

      case NativeAdEventType.onAdClicked:
        listener.onAdClicked?.call();
        break;

      case NativeAdEventType.onImpression:
        final data = event.parameters?['data'];

        listener.onImpression?.call(data);
        break;

      case NativeAdEventType.didDismissScreen:
        listener.didDismissScreen?.call();
        break;

      case NativeAdEventType.willPresentScreen:
        listener.willPresentScreen?.call();
        break;

      case NativeAdEventType.onClose:
        listener.onClose?.call();
        break;

      case NativeAdEventType.unknown:
        return;
    }
  }
}
