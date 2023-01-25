import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';

export 'banner_ad_event_listener.dart';
export 'interstitial_ad_event_listener.dart';
export 'native_ad_event_listener.dart';
export 'rewarded_ad_event_listener.dart';

abstract class AdEventListener {
  const AdEventListener();

  void emitCallbackByEvent(AdEvent event);
}
