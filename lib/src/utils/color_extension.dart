import 'package:flutter/material.dart';

extension ColorHexFactory on Color {
  String toHexString() {
    return '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}
