import 'dart:ui';

import 'location.dart';

export 'location.dart';

/// Data class containing additional ad request parameters.
///
class YandexAdParameters {
  const YandexAdParameters({
    this.age,
    this.biddingData,
    this.headerBiddingData,
    this.contextQuery,
    this.contextTags,
    this.gender,
    this.custom,
    this.brightness,
    this.location,
  });

  final int? age;
  final String? biddingData;
  final String? headerBiddingData;
  final String? contextQuery;
  final List<String>? contextTags;
  final String? gender;
  final Map<String, String>? custom;
  final Brightness? brightness;
  final Location? location;
}
