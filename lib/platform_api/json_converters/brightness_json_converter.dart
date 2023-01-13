import 'package:flutter/material.dart';

extension BrightnessToJson on Brightness {
  String toJson() {
    return name;
  }
}
