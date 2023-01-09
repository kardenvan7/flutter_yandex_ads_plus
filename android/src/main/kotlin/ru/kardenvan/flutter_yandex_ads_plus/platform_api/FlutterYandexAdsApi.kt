package ru.kardenvan.flutter_yandex_ads_plus.platform_api

import android.content.Context
import android.content.Intent
import android.os.Bundle
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import ru.kardenvan.flutter_yandex_ads_plus.activities.interstitial.InterstitialAdActivity
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.BasicAdEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.AdEventDispatcher

/**
 * Class responsible for the platform messaging between Kotlin and Flutter
 *
*/
class FlutterYandexAdsApi(context: Context, binaryMessenger: BinaryMessenger) {

    private val methodChannel: MethodChannel = MethodChannel(
        binaryMessenger, PlatformApiConfig.methodChannelName
    )

    /**
     * Event dispatcher for banner ads.
     */
    val bannerAdEventDispatcher: BasicAdEventDispatcher = BasicAdEventDispatcher()

    /**
     * Event dispatcher for native ads.
     */
    val nativeAdEventDispatcher: BasicAdEventDispatcher = BasicAdEventDispatcher()

    /**
     * Event channel for banner ad events.
     */
    private val bannerAdEventChannel: EventChannel =
        EventChannel(binaryMessenger, PlatformApiConfig.bannerAdEventChannelName)

    /**
     * Event channel for native ad events.
     */
    private val nativeAdEventChannel: EventChannel =
        EventChannel(binaryMessenger, PlatformApiConfig.nativeAdEventChannelName)

    init {
        setUpMethodChannel(context)
        setStreamHandlers()
    }

    /**
     * Cleans up memory.
     */
    fun dispose() {
        unsetStreamHandlers()
    }

    /**
     * Sets up method channel to receive method calls from Flutter-side
     */
    private fun setUpMethodChannel(context: Context) {
        methodChannel.setMethodCallHandler(PluginMethodCallHandler(context))
    }

    /**
     * Sets up stream handlers for event channels
     */
    private fun setStreamHandlers() {
        bannerAdEventChannel.setStreamHandler(AdEventStreamHandler(bannerAdEventDispatcher))
        nativeAdEventChannel.setStreamHandler(AdEventStreamHandler(nativeAdEventDispatcher))
    }

    /**
     * Removes stream handlers for event channels
     */
    private fun unsetStreamHandlers() {
        bannerAdEventChannel.setStreamHandler(null)
        nativeAdEventChannel.setStreamHandler(null)
    }

    private class PluginMethodCallHandler(
        private val context: Context
    ): MethodChannel.MethodCallHandler {
        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
            when (call.method) {
                "showInterstitialAd" -> showInterstitialAd(call, result)
            }
        }

        private fun showInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
            val bundle = Bundle()
            bundle.putString("ad_uid", "demo-interstitial-yandex")

            context.startActivity(
                Intent(context, InterstitialAdActivity::class.java),
                bundle
            )
        }
    }

    /**
     * Event stream handler for ad events
     */
    private class AdEventStreamHandler(
        private val dispatcher: AdEventDispatcher
    ): StreamHandler {
        /**
         * Sets event sink in the dispatcher once Flutter-side channel subscribes to the event
         * channel
         */
        override fun onListen(arguments: Any?, events: EventSink?) {
            if (events != null) dispatcher.setSink(events)
        }

        /**
         * Unsets event sink in the dispatcher once Flutter-side channel unsubscribes from the event
         * channel
         */
        override fun onCancel(arguments: Any?) {
            dispatcher.removeSink()
        }
    }
}