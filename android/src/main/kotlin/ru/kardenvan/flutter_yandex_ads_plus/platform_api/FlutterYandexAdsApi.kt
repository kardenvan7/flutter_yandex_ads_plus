package ru.kardenvan.flutter_yandex_ads_plus.platform_api

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import ru.kardenvan.flutter_yandex_ads_plus.ads.YandexAdsSdkFacade
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.method_call_receiver.FlutterYandexAdsMethodCallReceiver

/**
 * Class responsible for the platform messaging between Kotlin and Flutter
 *
*/
class FlutterYandexAdsApi(context: Context, binaryMessenger: BinaryMessenger) {

    init {
        YandexAdsSdkFacade.initialize(context)
    }

    /**
     * Event dispatcher for ads.
     */
    val adEventDispatcher: FlutterYandexAdsEventDispatcher =
        FlutterYandexAdsEventDispatcher(binaryMessenger, PlatformApiConfig.eventChannelName)

    /**
     * Class responsible for receiving platform message calls from Flutter
     */
    private val methodCallReceiver: FlutterYandexAdsMethodCallReceiver =
        FlutterYandexAdsMethodCallReceiver(
            binaryMessenger,
            PlatformApiConfig.methodChannelName,
            adEventDispatcher
        )

    /**
     * Sets app context for further usage
     */
    fun setAppContext(appContext: Context?) {
        methodCallReceiver.setContext(appContext)
    }

    /**
     * Cleans up memory.
     */
    fun dispose() {
        setAppContext(null)
    }
}