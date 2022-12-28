package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher

import io.flutter.plugin.common.EventChannel
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event.AdEvent

/**
 * Class responsible for dispatching ad events to Flutter-side.
 *
 * Use [sendEvent] method in child classes to send events.
 */
abstract class AdEventDispatcher {
    private var eventSink: EventChannel.EventSink? = null

    /**
     * Sets eventSink property value to [sink].
     */
    fun setSink(sink: EventChannel.EventSink) {
        eventSink = sink
    }

    /**
     * Sets [eventSink] property to null.
     */
    fun removeSink() {
        eventSink = null
    }

    /**
     * Encodes event and sends it to Flutter-side if [eventSink] is set.
     */
    protected fun sendEvent(event: AdEvent) {
        eventSink?.success(event.toMap())
    }
}