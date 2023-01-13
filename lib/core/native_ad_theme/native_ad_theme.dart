import 'package:flutter/material.dart';

part 'components/banner_theme.dart';
part 'components/button_theme.dart';
part 'components/rating_theme.dart';
part 'components/text_style.dart';

class NativeAdTheme {
  const NativeAdTheme({
    this.titleStyle,
    this.bodyStyle,
    this.domainStyle,
    this.ageStyle,
    this.reviewCountStyle,
    this.sponsoredStyle,
    this.warningStyle,
    this.bannerTheme,
    this.buttonTheme,
    this.ratingTheme,
  });

  final NativeAdTextStyle? titleStyle;
  final NativeAdTextStyle? bodyStyle;
  final NativeAdTextStyle? domainStyle;
  final NativeAdTextStyle? ageStyle;
  final NativeAdTextStyle? reviewCountStyle;
  final NativeAdTextStyle? sponsoredStyle;
  final NativeAdTextStyle? warningStyle;
  final NativeAdBannerTheme? bannerTheme;
  final NativeAdButtonTheme? buttonTheme;
  final NativeAdRatingTheme? ratingTheme;

  NativeAdTheme copyWithAnother(NativeAdTheme theme) {
    return copyWith(
      titleStyle: theme.titleStyle,
      bodyStyle: theme.bodyStyle,
      domainStyle: theme.domainStyle,
      ageStyle: theme.ageStyle,
      reviewCountStyle: theme.reviewCountStyle,
      sponsoredStyle: theme.sponsoredStyle,
      warningStyle: theme.warningStyle,
      bannerTheme: theme.bannerTheme,
      buttonTheme: theme.buttonTheme,
      ratingTheme: theme.ratingTheme,
    );
  }

  NativeAdTheme copyWith({
    NativeAdTextStyle? titleStyle,
    NativeAdTextStyle? bodyStyle,
    NativeAdTextStyle? domainStyle,
    NativeAdTextStyle? ageStyle,
    NativeAdTextStyle? reviewCountStyle,
    NativeAdTextStyle? sponsoredStyle,
    NativeAdTextStyle? warningStyle,
    NativeAdBannerTheme? bannerTheme,
    NativeAdButtonTheme? buttonTheme,
    NativeAdRatingTheme? ratingTheme,
  }) {
    return NativeAdTheme(
      titleStyle: titleStyle ?? this.titleStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      domainStyle: domainStyle ?? this.domainStyle,
      ageStyle: ageStyle ?? this.ageStyle,
      reviewCountStyle: reviewCountStyle ?? this.reviewCountStyle,
      sponsoredStyle: sponsoredStyle ?? this.sponsoredStyle,
      bannerTheme: bannerTheme ?? this.bannerTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      warningStyle: warningStyle ?? this.warningStyle,
      ratingTheme: ratingTheme ?? this.ratingTheme,
    );
  }
}
