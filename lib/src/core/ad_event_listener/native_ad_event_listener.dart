import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/src/core/callback_definitions.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/native_ad_event_type.dart';

import 'ad_event_listener.dart';

class NativeAdEventListener extends BannerAdEventListener {
  const NativeAdEventListener({
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

  @override
  NativeAdEventListener copyWith({
    VoidCallback? onAdLoaded,
    YandexAdErrorCallback? onAdFailedToLoad,
    YandexAdImpressionCallback? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    VoidCallback? didDismissScreen,
    VoidCallback? willPresentScreen,
    VoidCallback? onClose,
  }) {
    return NativeAdEventListener(
      onAdLoaded: onAdLoaded ?? this.onAdLoaded,
      onAdFailedToLoad: onAdFailedToLoad ?? this.onAdFailedToLoad,
      onImpression: onImpression ?? this.onImpression,
      onAdClicked: onAdClicked ?? this.onAdClicked,
      onLeftApplication: onLeftApplication ?? this.onLeftApplication,
      onReturnedToApplication:
          onReturnedToApplication ?? this.onReturnedToApplication,
      didDismissScreen: didDismissScreen ?? this.didDismissScreen,
      willPresentScreen: willPresentScreen ?? this.willPresentScreen,
      onClose: onClose ?? this.onClose,
    );
  }
}
