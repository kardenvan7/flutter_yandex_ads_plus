import 'package:flutter_yandex_ads_plus/src/core/core.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/ad_event/ad_event.dart';

abstract class AdEventEmitter {
  const AdEventEmitter();

  abstract final AdEventListener listener;

  void emitCallbackByEvent(AdEvent event);
}
