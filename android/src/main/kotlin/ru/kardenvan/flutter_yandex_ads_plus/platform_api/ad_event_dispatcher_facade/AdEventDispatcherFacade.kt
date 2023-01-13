package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade

import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event.AdEvent
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher

abstract class AdEventDispatcherFacade(
    /**
     * Unique identifier of the ad
     */
    private val uid: String,

    /**
     * Platform-to-Flutter event dispatcher
     */
    private val dispatcher: FlutterYandexAdsEventDispatcher,
) {
    fun sendEvent(type: String, parameters: Map<String, Any?>? = null) {
        dispatcher.sendEvent(AdEvent(uid, type, parameters))
    }
}