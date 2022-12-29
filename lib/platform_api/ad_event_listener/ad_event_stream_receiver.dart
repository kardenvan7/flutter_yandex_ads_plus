import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event_listener/ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/utils/logger.dart';

/// Class responsible for creating platform ad event stream as well as adding
/// and removing subscriptions to it.
///
class AdEventStreamReceiver {
  AdEventStreamReceiver({
    required String channelName,
  }) {
    _setUpEventStream(channelName);
  }

  /// Ads event stream.
  ///
  late Stream _adEventStream;

  /// Ads event subscription.
  ///
  late final StreamSubscription _adEventStreamSubscription;

  /// Ad event listeners by viewUid
  ///
  final Map<String, AdEventListener> _listeners = {};

  /// Subscribes [listener] to the ad event stream.
  ///
  void addEventListener(AdEventListener listener) {
    _addAdEventListener(listener);
  }

  /// Cancels subscription of listener with given [viewUid]
  ///
  void removeEventListener(String viewUid) {
    _removeAdEventListener(viewUid);
  }

  /// Adds listener to the list of active stream listeners.
  ///
  void _addAdEventListener(AdEventListener listener) {
    _listeners[listener.viewUid] = listener;
  }

  /// Removes subscription from the active stream listeners.
  ///
  void _removeAdEventListener(String viewUid) {
    _listeners.remove(viewUid);
  }

  /// Creates an event stream, subscribes to it and sets it as object property.
  /// Sets subscription as object property as well.
  ///
  void _setUpEventStream(String channelName) {
    _adEventStream = EventChannel(channelName).receiveBroadcastStream();
    _adEventStreamSubscription = _adEventStream.listen(_adEventStreamListener);
  }

  /// Ad event stream listener.
  ///
  /// Parses event, finds listener to which this event is directed and calls
  /// corresponding listener's callback.
  ///
  void _adEventStreamListener(dynamic event) {
    if (event is! Map) return;

    try {
      final eventMap = Map<String, dynamic>.from(event);
      final parsedEvent = AdEvent.fromJson(eventMap);
      final listener = _listeners[parsedEvent.viewUid];

      if (listener == null) return;

      listener.emitCallbackByEvent(parsedEvent);
    } catch (e, st) {
      Logger.log(e);
      Logger.log(st);
    }
  }

  void dispose() {
    _adEventStreamSubscription.cancel();
  }
}
