import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event/type/native_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/ad_event_listener.dart';

class NativeAdEventListener extends BasicAdEventListener {
  const NativeAdEventListener({
    required super.viewUid,
    super.onAdLoaded,
    super.onImpression,
    super.onAdClicked,
    super.onReturnedToApplication,
    super.onLeftApplication,
    super.onAdFailedToLoad,
    super.willPresentScreen,
    super.didDismissScreen,
    this.onClose,
  });

  final VoidCallback? onClose;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final eventType = NativeAdEventType.fromString(event.type);

    switch (eventType) {
      case NativeAdEventType.onClose:
        onClose?.call();
        break;

      case NativeAdEventType.unknown:
        super.emitCallbackByEvent(event);
        break;
    }
  }
}
