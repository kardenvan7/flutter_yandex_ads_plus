package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher

import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event.BasicAdEvent

/**
 * Class responsible for dispatching basic ad events to the Flutter side.
 */
class BasicAdEventDispatcher: AdEventDispatcher() {

    /**
     * Dispatches event notifying that ad with given [viewUid] was successfully loaded.
     */
    fun sendAdLoadedEvent(viewUid: String) {
        sendBasicAdEvent(viewUid = viewUid, type = BasicAdEvent.Type.ON_AD_LOADED)
    }

    /**
     * Dispatches event notifying that ad with given [viewUid] failed to load because of [error].
     */
    fun sendAdFailedToLoadEvent(viewUid: String, error: AdRequestError) {
        sendBasicAdEvent(
            viewUid = viewUid,
            type = BasicAdEvent.Type.ON_AD_FAILED_TO_LOAD,
            parameters = mapOf(
                "code" to error.code,
                "description" to error.description,
            )
        )
    }


    /**
     * Dispatches event notifying that ad with given [viewUid] called an impression that contains
     * provided [data].
     */
    fun sendImpressionEvent(viewUid: String, data: ImpressionData?) {
        sendBasicAdEvent(
            viewUid = viewUid,
            type = BasicAdEvent.Type.ON_IMPRESSION,
            parameters = mapOf(
                "data" to data?.rawData
            )
        )
    }

    /**
     * Dispatches event notifying that ad with given [viewUid] sent user to another application.
     */
    fun sendLeftApplicationEvent(viewUid: String) {
        sendBasicAdEvent(viewUid = viewUid, type = BasicAdEvent.Type.ON_LEFT_APPLICATION)
    }


    /**
     * Dispatches event notifying that user returned to current application after ad with [viewUid]
     * sent him to another app.
     */
    fun sendReturnedToApplicationEvent(viewUid: String) {
        sendBasicAdEvent(viewUid = viewUid, type = BasicAdEvent.Type.ON_RETURNED_TO_APPLICATION)
    }

    /**
     * Dispatches event notifying that ad with given [viewUid] was clicked.
     */
    fun sendAdClickedEvent(viewUid: String) {
        sendBasicAdEvent(viewUid = viewUid, type = BasicAdEvent.Type.ON_AD_CLICKED)
    }

    /**
     * Dispatches event with given [viewUid], [type] and [parameters] to the platform.
     */
    private fun sendBasicAdEvent(
        viewUid: String,
        type: BasicAdEvent.Type,
        parameters: Map<String, Any?>? = null,
    ) {
        super.sendEvent(BasicAdEvent(viewUid, type, parameters))
    }
}