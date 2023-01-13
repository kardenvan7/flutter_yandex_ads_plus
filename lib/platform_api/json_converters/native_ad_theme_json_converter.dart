import 'package:flutter_yandex_ads_plus/core/native_ad_theme/native_ad_theme.dart';
import 'package:flutter_yandex_ads_plus/utils/color_extension.dart';

extension NativeAdThemeToJson on NativeAdTheme {
  Map<String, dynamic> toJson() {
    return {
      'title_style': titleStyle?.toJson(),
      'body_style': bodyStyle?.toJson(),
      'domain_style': domainStyle?.toJson(),
      'age_style': ageStyle?.toJson(),
      'review_count_style': reviewCountStyle?.toJson(),
      'sponsored_style': sponsoredStyle?.toJson(),
      'warning_style': warningStyle?.toJson(),
      'banner_theme': bannerTheme?.toJson(),
      'button_theme': buttonTheme?.toJson(),
      'rating_theme': ratingTheme?.toJson(),
    };
  }
}

extension NativeAdTextStyleToJson on NativeAdTextStyle {
  Map<String, dynamic> toJson() {
    return {
      'color': color?.toHexString(),
      'font_size': fontSize,
      'font_weight': fontWeight,
      'font_family': fontFamily,
    };
  }
}

extension NativeAdBannerThemeToJson on NativeAdBannerTheme {
  Map<String, dynamic> toJson() {
    return {
      'border_color': borderColor?.toHexString(),
      'background_color': backgroundColor?.toHexString(),
      'border_width': borderWidth,
      'left_padding': leftPadding,
      'right_padding': rightPadding,
    };
  }
}

extension NativeAdButtonThemeToJson on NativeAdButtonTheme {
  Map<String, dynamic> toJson() {
    return {
      'border_color': borderColor?.toHexString(),
      'background_color': backgroundColor?.toHexString(),
      'border_width': borderWidth,
      'pressed_background_color': pressedBackgroundColor?.toHexString(),
      'text_style': textStyle.toJson(),
    };
  }
}

extension NativeAdRatingThemeToJson on NativeAdRatingTheme {
  Map<String, dynamic> toJson() {
    return {
      'star_color': emptyStarColor?.toHexString(),
      'progress_star_color': filledStarColor?.toHexString(),
      'star_size': starSize,
    };
  }
}
