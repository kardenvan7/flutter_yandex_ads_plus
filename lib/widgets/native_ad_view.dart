import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/utils/color_extension.dart';

class NativeAdView extends StatelessWidget {
  const NativeAdView({
    required this.id,
    this.height,
    this.width,
    this.theme,
    this.iosTheme,
    this.androidTheme,
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onImpression,
    Function? onAdClicked,
    Function? onLeftApplication,
    Function? onReturnedToApplication,
    Key? key,
  }) : super(key: key);

  final String id;
  final double? height;
  final double? width;
  final NativeAdTheme? theme;
  final NativeAdTheme? androidTheme;
  final NativeAdTheme? iosTheme;

  double get _defaultHeight => 250;
  double get _defaultWidth => 100;

  double _calcHeight(BoxConstraints constraints) {
    return height ??
        (constraints.hasBoundedHeight ? constraints.maxHeight : _defaultHeight);
  }

  double _calcWidth(BoxConstraints constraints) {
    return width ??
        (constraints.hasBoundedWidth ? constraints.maxWidth : _defaultWidth);
  }

  @override
  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-native';

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      height: height,
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final defaultTheme = _getDefaultNativeAdTheme(context);
          final commonTheme = theme != null
              ? defaultTheme.copyWithAnother(theme!)
              : defaultTheme;

          switch (defaultTargetPlatform) {
            case TargetPlatform.android:
              final Map<String, dynamic> params = _NativeAdParams(
                adId: id,
                height: _calcHeight(constraints),
                width: _calcWidth(constraints),
                theme: androidTheme != null
                    ? commonTheme.copyWithAnother(androidTheme!)
                    : commonTheme,
              ).toMap();

              return AndroidView(
                viewType: viewType,
                creationParams: params,
                creationParamsCodec: const StandardMessageCodec(),
              );

            case TargetPlatform.iOS:
              final Map<String, dynamic> params = _NativeAdParams(
                adId: id,
                height: _calcHeight(constraints),
                width: _calcWidth(constraints),
                theme: iosTheme != null
                    ? commonTheme.copyWithAnother(iosTheme!)
                    : commonTheme,
              ).toMap();

              return UiKitView(
                viewType: viewType,
                creationParams: params,
                creationParamsCodec: const StandardMessageCodec(),
              );

            default:
              return Text(
                '$defaultTargetPlatform is not yet supported by the web_view plugin',
              );
          }
        },
      ),
    );
  }
}

NativeAdTheme _getDefaultNativeAdTheme(context) {
  final brightness = Theme.of(context).brightness;

  switch (brightness) {
    case Brightness.light:
      return const NativeAdTheme(
        titleStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        bodyStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        domainStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        ageStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        sponsoredStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        warningStyle: NativeAdTextStyle(
          color: Colors.orangeAccent,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        reviewCountStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        bannerTheme: NativeAdBannerTheme(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 1,
          leftPadding: 8,
          rightPadding: 8,
        ),
        buttonTheme: NativeAdButtonTheme(
          borderWidth: 1,
          borderColor: Colors.black,
          backgroundColor: Colors.white,
          pressedBackgroundColor: Colors.grey,
          textStyle: NativeAdTextStyle(
            color: Colors.grey,
            fontFamily: null,
            fontSize: 14,
            fontWeight: 400,
          ),
        ),
        ratingTheme: NativeAdRatingTheme(
          emptyStarColor: Colors.grey,
          filledStarColor: Colors.yellow,
          starSize: 12,
        ),
      );

    case Brightness.dark:
      return const NativeAdTheme(
        titleStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        bodyStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        domainStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        ageStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        sponsoredStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        reviewCountStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        warningStyle: NativeAdTextStyle(
          color: Colors.grey,
          fontFamily: null,
          fontSize: 12,
          fontWeight: 400,
        ),
        bannerTheme: NativeAdBannerTheme(
          backgroundColor: Colors.black26,
          borderColor: Colors.transparent,
          borderWidth: 1,
          leftPadding: 8,
          rightPadding: 8,
        ),
        buttonTheme: NativeAdButtonTheme(
          borderWidth: 1,
          borderColor: Colors.black38,
          backgroundColor: Colors.black38,
          pressedBackgroundColor: Colors.black45,
          textStyle: NativeAdTextStyle(
            color: Colors.grey,
            fontFamily: null,
            fontSize: 14,
            fontWeight: 400,
          ),
        ),
        ratingTheme: NativeAdRatingTheme(
          emptyStarColor: Colors.grey,
          filledStarColor: Colors.yellow,
          starSize: 12,
        ),
      );
  }
}

class _NativeAdParams {
  const _NativeAdParams({
    required this.adId,
    required this.height,
    required this.width,
    required this.theme,
  });

  final String adId;
  final double height;
  final double width;
  final NativeAdTheme theme;

  Map<String, dynamic> toMap() {
    return {
      'ad_id': adId,
      'height': height.toInt(),
      'width': width.toInt(),
      'theme': theme.toMap(),
    };
  }
}

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

  Map<String, dynamic> toMap() {
    return {
      'title_style': titleStyle?.toMap(),
      'body_style': bodyStyle?.toMap(),
      'domain_style': domainStyle?.toMap(),
      'age_style': ageStyle?.toMap(),
      'review_count_style': reviewCountStyle?.toMap(),
      'sponsored_style': sponsoredStyle?.toMap(),
      'warning_style': warningStyle?.toMap(),
      'banner_theme': bannerTheme?.toMap(),
      'button_theme': buttonTheme?.toMap(),
      'rating_theme': ratingTheme?.toMap(),
    };
  }
}

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

  Map<String, dynamic> toMap() {
    return {
      'border_color': borderColor?.toHexString(),
      'background_color': backgroundColor?.toHexString(),
      'border_width': borderWidth,
      'left_padding': leftPadding,
      'right_padding': rightPadding,
    };
  }
}

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

  Map<String, dynamic> toMap() {
    return {
      'border_color': borderColor?.toHexString(),
      'background_color': backgroundColor?.toHexString(),
      'border_width': borderWidth,
      'pressed_background_color': pressedBackgroundColor?.toHexString(),
      'text_style': textStyle.toMap(),
    };
  }
}

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

  Map<String, dynamic> toMap() {
    return {
      'color': color?.toHexString(),
      'font_size': fontSize,
      'font_weight': fontWeight,
      'font_family': fontFamily,
    };
  }
}

class NativeAdRatingTheme {
  const NativeAdRatingTheme({
    required this.emptyStarColor,
    required this.filledStarColor,
    required this.starSize,
  });

  final Color? emptyStarColor;
  final Color? filledStarColor;
  final double starSize;

  Map<String, dynamic> toMap() {
    return {
      'star_color': emptyStarColor?.toHexString(),
      'progress_star_color': filledStarColor?.toHexString(),
      'star_size': starSize,
    };
  }
}
