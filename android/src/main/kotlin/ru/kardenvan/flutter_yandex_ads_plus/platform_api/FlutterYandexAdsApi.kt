package ru.kardenvan.flutter_yandex_ads_plus.platform_api

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.BasicAdEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.InterstitialAdEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.method_call_receiver.FlutterYandexAdsMethodCallReceiver

/**
 * Class responsible for the platform messaging between Kotlin and Flutter
 *
*/
class FlutterYandexAdsApi(binaryMessenger: BinaryMessenger) {

    /**
     * Event dispatcher for banner ads.
     */
    val bannerAdEventDispatcher: BasicAdEventDispatcher = BasicAdEventDispatcher(
        binaryMessenger, PlatformApiConfig.bannerAdEventChannelName
    )

    /**
     * Event dispatcher for native ads.
     */
    val nativeAdEventDispatcher: BasicAdEventDispatcher = BasicAdEventDispatcher(
        binaryMessenger, PlatformApiConfig.nativeAdEventChannelName
    )

    private val interstitialAdEventDispatcher: InterstitialAdEventDispatcher =
        InterstitialAdEventDispatcher(
            binaryMessenger, PlatformApiConfig.interstitialAdEventChannelName,
        )

    /**
     * Class responsible for receiving platform message calls from Flutter
     */
    private val methodCallReceiver: FlutterYandexAdsMethodCallReceiver =
        FlutterYandexAdsMethodCallReceiver(
            binaryMessenger,
            PlatformApiConfig.methodChannelName,
            interstitialAdEventDispatcher
        )

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