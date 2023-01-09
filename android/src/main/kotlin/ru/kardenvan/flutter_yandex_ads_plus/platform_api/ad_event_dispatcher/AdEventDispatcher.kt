package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event.AdEvent

/**
 * Class responsible for dispatching ad events to Flutter-side.
 *
 * Use [sendEvent] method in child classes to send events.
 */
abstract class AdEventDispatcher(
    binaryMessenger: BinaryMessenger,
    channelName: String,
) {
    private val eventChannel: EventChannel = EventChannel(binaryMessenger, channelName)

    init {
        eventChannel.setStreamHandler(Handler)
    }

    private object Handler: EventChannel.StreamHandler {
        private var eventSink: EventChannel.EventSink? = null

        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            eventSink = events
        }

        override fun onCancel(arguments: Any?) {
            eventSink = null
        }

        fun sendEvent(data: Map<*, *>) {
            eventSink?.success(data)
        }
    }

    /**
     * Encodes event and sends it to Flutter-side.
     */
    protected fun sendEvent(event: AdEvent) {
        Handler.sendEvent(event.toMap())
    }
}