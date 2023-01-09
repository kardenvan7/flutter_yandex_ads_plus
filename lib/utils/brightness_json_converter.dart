import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

class BrightnessJsonConverter extends JsonConverter<Brightness, String> {
  const BrightnessJsonConverter();

  @override
  Brightness fromJson(String json) {
    return Brightness.values.firstWhere((element) => element.name == json);
  }

  @override
  String toJson(Brightness object) {
    return object.name;
  }
}
