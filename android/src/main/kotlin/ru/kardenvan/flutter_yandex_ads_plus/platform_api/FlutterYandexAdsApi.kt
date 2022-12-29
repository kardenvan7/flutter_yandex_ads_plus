package ru.kardenvan.flutter_yandex_ads_plus.platform_api

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.BasicAdEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.AdEventDispatcher

/**
 * Class responsible for the platform messaging between Kotlin and Flutter
 *
*/
class FlutterYandexAdsApi constructor(binaryMessenger: BinaryMessenger) {

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
        setStreamHandlers()
    }

    /**
     * Cleans up memory.
     */
    fun dispose() {
        unsetStreamHandlers()
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