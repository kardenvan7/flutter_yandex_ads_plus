package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade

import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event.AdEvent
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher

open class BasicAdEventDispatcherFacade(
    uid: String,
    dispatcher: FlutterYandexAdsEventDispatcher,
): AdEventDispatcherFacade(uid, dispatcher) {
    /**
     * Dispatches event notifying that ad was successfully loaded.
     */
    fun sendAdLoadedEvent() {
        sendBasicAdEvent(type = Type.ON_AD_LOADED)
    }

    /**
     * Dispatches event notifying that ad failed to load because of [error].
     */
    fun sendAdFailedToLoadEvent(error: AdRequestError) {
        sendBasicAdEvent(
            type = Type.ON_AD_FAILED_TO_LOAD,
            parameters = mapOf(
                "code" to error.code,
                "description" to error.description,
            )
        )
    }

    /**
     * Dispatches event notifying that ad called an impression that contains
     * provided [data].
     */
    fun sendImpressionEvent(data: ImpressionData?) {
        sendBasicAdEvent(
            type = Type.ON_IMPRESSION,
            parameters = mapOf(
                "data" to data?.rawData
            )
        )
    }

    /**
     * Dispatches event notifying that ad sent user to another application.
     */
    fun sendLeftApplicationEvent() {
        sendBasicAdEvent(type = Type.ON_LEFT_APPLICATION)
    }


    /**
     * Dispatches event notifying that user returned to current application after ad
     * sent him to another app.
     */
    fun sendReturnedToApplicationEvent() {
        sendBasicAdEvent(type = Type.ON_RETURNED_TO_APPLICATION)
    }

    /**
     * Dispatches event notifying that ad was clicked.
     */
    fun sendAdClickedEvent() {
        sendBasicAdEvent(type = Type.ON_AD_CLICKED)
    }

    /**
     * Dispatches event with given [uid], [type] and [parameters] to the platform.
     */
    private fun sendBasicAdEvent(
        type: Type,
        parameters: Map<String, Any?>? = null,
    ) {
        super.sendEvent(type.value, parameters)
    }

    private enum class Type constructor(
        val value: String
    ) {
        ON_AD_LOADED("onAdLoaded"),
        ON_AD_FAILED_TO_LOAD("onAdFailedToLoad"),
        ON_IMPRESSION("onImpression"),
        ON_LEFT_APPLICATION("onLeftApplication"),
        ON_RETURNED_TO_APPLICATION("onReturnedToApplication"),
        ON_AD_CLICKED("onAdClicked");
    }
}