import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/platform_api/json_converters/brightness_json_converter.dart';

extension AdParametersToJson on AdParameters {
  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'bidding_data': biddingData,
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
