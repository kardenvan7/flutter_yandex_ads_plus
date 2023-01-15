part of '../native_ad_theme.dart';

class NativeAdTextStyle {
  const NativeAdTextStyle({
    required this.color,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
  });

  final Color? color;
  final double fontSize;
  final int fontWeight;
  final String? fontFamily;
}
