part of '../native_ad_theme.dart';

class NativeAdBannerTheme {
  const NativeAdBannerTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.leftPadding,
    required this.rightPadding,
  });

  final Color? borderColor;
  final Color? backgroundColor;
  final double borderWidth;
  final double leftPadding;
  final double rightPadding;
}
