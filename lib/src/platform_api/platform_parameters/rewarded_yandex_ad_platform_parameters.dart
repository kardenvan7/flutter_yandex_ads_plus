import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/yandex_ad_parameters_json_converter.dart';

class RewardedYandexAdPlatformParameters {
  const RewardedYandexAdPlatformParameters({
    required this.adId,
    required this.uid,
    this.parameters,
  });

  final String uid;
  final String adId;
  final YandexAdParameters? parameters;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ad_id': adId,
      'parameters': parameters?.toJson(),
    };
  }
}
