import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/basic_ad_event_type.dart';

import 'ad_event_listener.dart';

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

  final VoidCallback? onAdLoaded;
  final YandexAdErrorCallback? onAdFailedToLoad;
  final YandexAdImpressionCallback? onImpression;
  final VoidCallback? onAdClicked;
  final VoidCallback? onLeftApplication;
  final VoidCallback? onReturnedToApplication;
  final VoidCallback? didDismissScreen;
  final VoidCallback? willPresentScreen;

  @override
  void emitCallbackByEvent(
    AdEvent event,
  ) {
    final type = BasicAdEventType.fromString(event.type);

    switch (type) {
      case BasicAdEventType.onAdLoaded:
        onAdLoaded?.call();
        break;

      case BasicAdEventType.onAdFailedToLoad:
        onAdFailedToLoad?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case BasicAdEventType.onLeftApplication:
        onLeftApplication?.call();
        break;

      case BasicAdEventType.onReturnedToApplication:
        onReturnedToApplication?.call();
        break;

      case BasicAdEventType.onAdClicked:
        onAdClicked?.call();
        break;

      case BasicAdEventType.onImpression:
        final data = event.parameters?['data'];

        onImpression?.call(data);
        break;

      case BasicAdEventType.didDismissScreen:
        didDismissScreen?.call();
        break;

      case BasicAdEventType.willPresentScreen:
        willPresentScreen?.call();
        break;

      case BasicAdEventType.unknown:
        return;
    }
  }

  BannerAdEventListener copyWith({
    VoidCallback? onAdLoaded,
    YandexAdErrorCallback? onAdFailedToLoad,
    YandexAdImpressionCallback? onImpression,
    VoidCallback? onAdClicked,
    VoidCallback? onLeftApplication,
    VoidCallback? onReturnedToApplication,
    VoidCallback? didDismissScreen,
    VoidCallback? willPresentScreen,
  }) {
    return BannerAdEventListener(
      onAdLoaded: onAdLoaded ?? this.onAdLoaded,
      onAdFailedToLoad: onAdFailedToLoad ?? this.onAdFailedToLoad,
      onImpression: onImpression ?? this.onImpression,
      onAdClicked: onAdClicked ?? this.onAdClicked,
      onLeftApplication: onLeftApplication ?? this.onLeftApplication,
      onReturnedToApplication:
          onReturnedToApplication ?? this.onReturnedToApplication,
      didDismissScreen: didDismissScreen ?? this.didDismissScreen,
      willPresentScreen: willPresentScreen ?? this.willPresentScreen,
    );
  }
}