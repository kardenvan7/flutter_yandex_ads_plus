import 'package:flutter_yandex_ads_plus/src/core/ad_parameters/yandex_ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/json_converters/brightness_json_converter.dart';

extension YandexAdParametersToJson on YandexAdParameters {
  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'bidding_data': biddingData,
      'header_bidding_data': headerBiddingData,
      'context_query': contextQuery,
      'context_tags': contextTags,
      'gender': gender,
      'custom': custom,
      'preferred_theme': brightness?.toJson(),
      'location': location?.toJson(),
    };
  }
}

extension LocationToJson on Location {
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
