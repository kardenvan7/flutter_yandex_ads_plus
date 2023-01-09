import 'dart:ui';

import 'package:flutter_yandex_ads_plus/utils/brightness_json_converter.dart';
import 'package:flutter_yandex_ads_plus/utils/location/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_parameters.freezed.dart';
part 'ad_parameters.g.dart';

/// Data class containing additional ad request parameters.
///
@freezed
class AdParameters with _$AdParameters {
  const AdParameters._();

  const factory AdParameters({
    String? age,
    String? biddingData,
    String? contextQuery,
    List<String>? contextTags,
    String? gender,
    Map<String, String>? custom,
    @JsonKey(name: "preferred_theme")
    @BrightnessJsonConverter()
        Brightness? brightness,
    Location? location,
  }) = _AdParameters;

  factory AdParameters.fromJson(Map<String, dynamic> json) =>
      _$AdParametersFromJson(json);
}
