import 'package:flutter_yandex_ads_plus/src/core/core.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/type/rewarded_ad_event_type.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event_emitter/ad_event_listener_emitter.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/yandex_ad_reward_json_converter.dart';

class RewardedAdEventEmitter extends AdEventEmitter {
  const RewardedAdEventEmitter({required this.listener});

  @override
  final RewardedAdEventListener listener;

  @override
  void emitCallbackByEvent(AdEvent event) {
    final eventType = RewardedAdEventType.fromString(event.type);

    switch (eventType) {
      case RewardedAdEventType.onAdLoaded:
        listener.onAdLoaded?.call();
        break;

      case RewardedAdEventType.onAdFailedToLoad:
        listener.onAdFailedToLoad?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case RewardedAdEventType.onLeftApplication:
        listener.onLeftApplication?.call();
        break;

      case RewardedAdEventType.onReturnedToApplication:
        listener.onReturnedToApplication?.call();
        break;

      case RewardedAdEventType.onAdClicked:
        listener.onAdClicked?.call();
        break;

      case RewardedAdEventType.onImpression:
        final data = event.parameters?['data'];

        listener.onImpression?.call(data);
        break;

      case RewardedAdEventType.didDismissScreen:
        listener.didDismissScreen?.call();
        break;

      case RewardedAdEventType.willPresentScreen:
        listener.willPresentScreen?.call();
        break;

      case RewardedAdEventType.onAdFailedToAppear:
        listener.onAdFailedToAppear?.call(
          event.parameters?['code'],
          event.parameters?['description'],
        );
        break;

      case RewardedAdEventType.onAdWillBeShown:
        listener.onAdWillBeShown?.call();
        break;

      case RewardedAdEventType.onAdShown:
        listener.onAdShown?.call();
        break;

      case RewardedAdEventType.onAdWillBeDismissed:
        listener.onAdWillBeDismissed?.call();
        break;

      case RewardedAdEventType.onAdDismissed:
        listener.onAdDismissed?.call();
        break;

      case RewardedAdEventType.onRewarded:
        final reward = YandexAdRewardFactory.fromJson(
          event.parameters!,
        );

        listener.onRewarded?.call(reward);
        break;

      case RewardedAdEventType.unknown:
        break;
    }
  }
}
