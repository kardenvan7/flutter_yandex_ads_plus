import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';

export 'basic_ad_event_listener.dart';
export 'interstitial_ad_event_listener.dart';
export 'native_ad_event_listener.dart';

abstract class AdEventListener {
  const AdEventListener({
    required this.uid,
  });

  final String uid;

  void emitCallbackByEvent(AdEvent event);
}
