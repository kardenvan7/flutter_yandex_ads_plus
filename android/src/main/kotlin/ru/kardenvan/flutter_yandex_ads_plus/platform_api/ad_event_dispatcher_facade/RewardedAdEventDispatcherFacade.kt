package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade

import com.yandex.mobile.ads.rewarded.Reward
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher

class RewardedAdEventDispatcherFacade(
    uid: String,
    dispatcher: FlutterYandexAdsEventDispatcher,
): InterstitialAdEventDispatcherFacade(uid, dispatcher) {
    fun sendOnRewardedEvent(reward: Reward) {
        val map = mapOf(
            "amount" to reward.amount,
            "type" to reward.type
        )

        sendRewardedAdEvent(Type.ON_REWARDED, parameters = map)
    }

    private fun sendRewardedAdEvent(
        type: Type,
        parameters: Map<String, Any?>? = null,
    ) {
        super.sendEvent(type = type.value, parameters = parameters)
    }

    private enum class Type constructor(
        val value: String
    ) {
        ON_REWARDED("onRewarded");
    }
}