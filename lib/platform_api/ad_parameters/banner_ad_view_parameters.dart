import 'package:flutter/foundation.dart';
import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/core/ios_banner_ad_view_settings.dart';
import 'package:flutter_yandex_ads_plus/platform_api/json_converters/ad_parameters_json_converter.dart';
import 'package:flutter_yandex_ads_plus/platform_api/json_converters/ios_banner_ad_view_settings_json_converter.dart';

export 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
export 'package:flutter_yandex_ads_plus/core/ios_banner_ad_view_settings.dart';

class BannerAdParameters {
  const BannerAdParameters({
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
  final AdParameters? parameters;
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
