import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event/ad_event.dart';
import 'package:flutter_yandex_ads_plus/platform_api/ad_event/basic/basic_ad_event.dart';
import 'package:flutter_yandex_ads_plus/utils/logger.dart';

import 'basic_ad_event_listener.dart';

/// Class responsible for creating platform ad event stream as well as adding
/// and removing subscriptions to it.
///
class BasicAdEventStreamReceiver {
  BasicAdEventStreamReceiver({
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
  final Map<String, BasicAdEventListener> _listeners = {};

  /// Subscribes [listener] to the banner ad event stream.
  ///
  void addEventListener(BasicAdEventListener listener) {
    _addAdEventListener(listener);
  }

  /// Cancels subscription of listener with given [viewUid]
  ///
  void removeEventListener(String viewUid) {
    _removeAdEventListener(viewUid);
  }

  /// Subscribes [listener] to the banner ad event stream. Adds subscription
  /// to [_adEventStreamSubscription].
  ///
  void _addAdEventListener(BasicAdEventListener listener) {
    _listeners[listener.viewUid] = listener;
  }

  /// Removes subscription from the [_adEventStreamSubscription] and cancels it.
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
      final parsedEvent = BasicAdEvent.fromJson(eventMap);
      final listener = _listeners[parsedEvent.viewUid];

      if (listener == null) return;

      BasicAdEventToListenerCallbackMapper.callListenerEventByAdEvent(
        parsedEvent,
        listener,
      );
    } catch (e, st) {
      Logger.log(e);
      Logger.log(st);
    }
  }
}

/// Class responsible for mapping basic ad event to basic ad event listener
/// callback.
///
class BasicAdEventToListenerCallbackMapper {
  const BasicAdEventToListenerCallbackMapper._();

  /// Calls listener callback that corresponds to event
  ///
  static void callListenerEventByAdEvent(
    BasicAdEvent event,
    BasicAdEventListener listener,
  ) {
    switch (event.type) {
      case BasicAdEventType.onAdLoaded:
        listener.onAdLoaded?.call();
        break;

      case BasicAdEventType.onAdFailedToLoad:
        final code = event.parameters?['code'];
        final desc = event.parameters?['description'];

        listener.onAdFailedToLoad?.call(code ?? 0, desc ?? 'Unknown');
        break;

      case BasicAdEventType.onLeftApplication:
        listener.onLeftApplication?.call();
        break;

      case BasicAdEventType.onReturnedToApplication:
        listener.onReturnedToApplication?.call();
        break;

      case BasicAdEventType.onAdClicked:
        listener.onAdClicked?.call();
        break;

      case BasicAdEventType.onImpression:
        final data = event.parameters?['data'];

        listener.onImpression?.call(data);
        break;
    }
  }
}
