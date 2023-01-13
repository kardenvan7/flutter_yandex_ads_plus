import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/platform_api/json_converters/ad_parameters_json_converter.dart';

class InterstitialAdPlatformParameters {
  const InterstitialAdPlatformParameters({
    required this.adId,
    required this.uid,
    this.parameters,
  });

  final String uid;
  final String adId;
  final AdParameters? parameters;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ad_id': adId,
      'parameters': parameters?.toJson(),
    };
  }
}
