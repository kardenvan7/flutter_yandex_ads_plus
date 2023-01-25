import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_event_listener/ad_event_listener.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/src/utils/plugin_logger.dart';

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
  void addEventListener(String uid, AdEventListener listener) {
    _addAdEventListener(uid, listener);
  }

  /// Cancels subscription of listener with given [uid]
  ///
  void removeEventListener(String uid) {
    _removeAdEventListener(uid);
  }

  /// Adds listener to the list of active stream listeners.
  ///
  void _addAdEventListener(String uid, AdEventListener listener) {
    _listeners[uid] = listener;
  }

  /// Removes subscription from the active stream listeners.
  ///
  void _removeAdEventListener(String uid) {
    _listeners.remove(uid);
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
      final listener = _listeners[parsedEvent.uid];

      if (listener == null) return;

      listener.emitCallbackByEvent(parsedEvent);
    } catch (e, st) {
      PluginLogger.log(e);
      PluginLogger.log(st);
    }
  }

  void dispose() {
    _adEventStreamSubscription.cancel();
  }
}
