part of '../native_ad_theme.dart';

class NativeAdButtonTheme {
  const NativeAdButtonTheme({
    required this.borderWidth,
    required this.borderColor,
    required this.backgroundColor,
    required this.pressedBackgroundColor,
    required this.textStyle,
  });

  final Color? backgroundColor;
  final Color? pressedBackgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final NativeAdTextStyle textStyle;
}
