import 'dart:ui';

import 'location.dart';

export 'location.dart';

/// Data class containing additional ad request parameters.
///
class AdParameters {
  const AdParameters({
    this.age,
    this.biddingData,
    this.contextQuery,
    this.contextTags,
    this.gender,
    this.custom,
    this.brightness,
    this.location,
  });

  final String? age;
  final String? biddingData;
  final String? contextQuery;
  final List<String>? contextTags;
  final String? gender;
  final Map<String, String>? custom;
  final Brightness? brightness;
  final Location? location;
}
