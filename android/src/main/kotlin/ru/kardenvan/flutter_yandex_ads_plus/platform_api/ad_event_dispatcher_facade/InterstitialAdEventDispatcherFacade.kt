package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade

import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher

class InterstitialAdEventDispatcherFacade(
    uid: String,
    dispatcher: FlutterYandexAdsEventDispatcher,
): BasicAdEventDispatcherFacade(uid, dispatcher) {
    fun sendAdShownEvent() {
        sendInterstitialAdEvent(Type.ON_AD_SHOWN)
    }

    fun sendAdDismissedEvent() {
        sendInterstitialAdEvent(Type.ON_AD_DISMISSED)
    }

    private fun sendInterstitialAdEvent(
        type: Type,
        parameters: Map<String, Any?>? = null,
    ) {
        super.sendEvent(type = type.value, parameters = parameters)
    }

    private enum class Type constructor(
        val value: String
    ) {
        ON_AD_SHOWN("onAdShown"),
        ON_AD_DISMISSED("onAdDismissed");
    }
}