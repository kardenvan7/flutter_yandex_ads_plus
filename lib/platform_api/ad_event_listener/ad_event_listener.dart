import 'package:flutter_yandex_ads_plus/platform_api/ad_event/ad_event.dart';

export 'basic/basic_ad_event_listener.dart';
export 'native/native_ad_event_listener.dart';

abstract class AdEventListener {
  const AdEventListener({
    required this.viewUid,
  });

  final String viewUid;

  void emitCallbackByEvent(AdEvent event);
}
