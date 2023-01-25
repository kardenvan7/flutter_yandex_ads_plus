import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/rewarded_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/yandex_ad_reward_json_converter.dart';

import 'ad_event_listener.dart';

class RewardedAdEventListener extends InterstitialAdEventListener {
  const RewardedAdEventListener({
    super.onAdLoaded,
    super.onImpression,
    super.onAdClicked,
    super.onReturnedToApplication,
    super.onLeftApplication,
    super.onAdFailedToLoad,
    super.willPresentScreen,
    super.didDismissScreen,
    super.onAdFailedToAppear,
    super.onAdShown,
    super.onAdWillBeShown,
    super.onAdDismissed,
    super.onAdWillBeDismissed,
    this.onRewarded,
  });

  final RewardedYandexAdOnRewardCallback? onRewarded;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final eventType = RewardedAdEventType.fromString(event.type);

    switch (eventType) {
      case RewardedAdEventType.onRewarded:
        final reward = YandexAdRewardJsonConverter().fromJson(
          event.parameters!,
        );

        onRewarded?.call(reward);
        break;

      case RewardedAdEventType.unknown:
        super.emitCallbackByEvent(event);
        break;
    }
  }

  @override
  RewardedAdEventListener copyWith({
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
    RewardedYandexAdOnRewardCallback? onRewarded,
  }) {
    return RewardedAdEventListener(
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
      onRewarded: onRewarded ?? this.onRewarded,
    );
  }
}
