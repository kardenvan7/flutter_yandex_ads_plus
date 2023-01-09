package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher

import io.flutter.plugin.common.BinaryMessenger
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event.InterstitialAdEvent

class InterstitialAdEventDispatcher(
    binaryMessenger: BinaryMessenger,
    channelName: String,
): BasicAdEventDispatcher(binaryMessenger, channelName) {
    fun sendAdShownEvent(adUid: String) {
        sendInterstitialAdEvent(adUid, InterstitialAdEvent.Type.ON_AD_SHOWN)
    }

    fun sendAdDismissedEvent(adUid: String) {
        sendInterstitialAdEvent(adUid, InterstitialAdEvent.Type.ON_AD_DISMISSED)
    }

    private fun sendInterstitialAdEvent(
        adUid: String,
        type: InterstitialAdEvent.Type,
        parameters: Map<String, Any?>? = null,
    ) {
        super.sendEvent(
            InterstitialAdEvent(viewUid = adUid, type = type, parameters = parameters)
        )
    }
}