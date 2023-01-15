import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/core/native_ad_theme/native_ad_theme.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/native_ad_theme_json_converter.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/yandex_ad_parameters_json_converter.dart';

class NativeYandexAdPlatformParameters {
  const NativeYandexAdPlatformParameters({
    required this.uid,
    required this.adId,
    required this.height,
    required this.width,
    required this.theme,
    required this.parameters,
  });

  final String uid;
  final String adId;
  final double height;
  final double width;
  final NativeAdTheme theme;
  final YandexAdParameters? parameters;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ad_id': adId,
      'height': height.toInt(),
      'width': width.toInt(),
      'theme': theme.toJson(),
      'parameters': parameters?.toJson(),
    };
  }
}
