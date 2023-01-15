import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/core/ios_banner_ad_view_settings.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/ios_banner_ad_view_settings_json_converter.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/yandex_ad_parameters_json_converter.dart';

class BannerYandexAdPlatformParameters {
  const BannerYandexAdPlatformParameters({
    required this.uid,
    required this.adId,
    required this.height,
    required this.width,
    this.parameters,
    this.iosSettings,
  });

  final String uid;
  final String adId;
  final double height;
  final double width;
  final YandexAdParameters? parameters;
  final IosBannerAdViewSettings? iosSettings;

  IosBannerAdViewSettings get defaultIosSettings {
    return const IosBannerAdViewSettings(
      translatesAutoResizingMaskIntoConstraints: true,
    );
  }

  Map<String, dynamic> toJson() {
    final params = {
      'uid': uid,
      'ad_id': adId,
      'height': height.toInt(),
      'width': width.toInt(),
      'parameters': parameters?.toJson(),
    };

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      params['settings'] = iosSettings?.toJson() ?? defaultIosSettings.toJson();
    }

    return params;
  }
}
