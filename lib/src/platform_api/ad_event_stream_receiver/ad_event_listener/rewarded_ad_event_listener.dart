import 'package:flutter_yandex_ads_plus/flutter_yandex_ads_plus.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/rewarded_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event_stream_receiver/ad_event_listener/ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/yandex_ad_reward_json_converter.dart';

class RewardedAdEventListener extends InterstitialAdEventListener {
  const RewardedAdEventListener({
    required super.uid,
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
}
