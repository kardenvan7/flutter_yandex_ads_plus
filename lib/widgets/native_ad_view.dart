import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/platform_api/config.dart';
import 'package:flutter_yandex_ads_plus/platform_api/platform_api.dart';
import 'package:flutter_yandex_ads_plus/utils/color_extension.dart';

/// Flutter-implementation of native [NativeBannerView] (Kotlin, Android) and
/// [YMANativeBannerView] (Swift, iOS).
///
/// [id] - unique identifier of the ad, obtained in partner interface.
/// Example: R-M-XXXXXX-Y.
///
/// [height] - ad height. If not set, takes up all available height if height
/// constraint is bounded. If not - sets to default height of 250px.
///
/// [width] - ad width. If not set, takes up all available width if width
/// constraint is bounded. If not - sets to default width of 300px.
///
/// [parameters] - additional ad request parameters.
///
/// [onAdLoaded] - callback triggered when the ad is successfully loaded.
///
/// [onAdFailedToLoad] - callback triggered when ad is failed to load. Passes
/// error code and error description as parameter.
///
/// [onLeftApplication] - callback triggered when another app is launched
/// (browser, etc.) because of user interaction with the ad.
///
/// [onAdClicked] - callback triggered when user taps on the ad.
///
/// [onImpression] - callback triggered when impression is tracked. Passes raw
/// data (String) as parameter.
///
/// [onReturnedToApplication] - callback triggered when app is returned to
/// foreground after events that triggered [onLeftApplication]. Due to
/// YandexAds native SDK limitations this callback works only on Android.
///
/// [willPresentScreen] - callback triggered when ad will show the modal
/// in response to the user interacting with the banner. Due to
/// YandexAds native SDK limitations this callback works only on iOS.
///
/// [didDismissScreen] - callback triggered when ad finished showing the modal
/// in response to the user interacting with the banner. Due to
/// YandexAds native SDK limitations this callback works only on iOS.
///
/// [onClose] - callback triggered when the user has chosen a reason for closing
/// the ad and the ad must be hidden. Warning: advertising will not be hidden.
/// The developer must determine what to do with the ad after the reason for
/// closing it is chosen. Due to YandexAds native SDK limitations this callback
/// works only on iOS.
///
class NativeAdView extends StatefulWidget {
  const NativeAdView({
    required this.id,
    this.parameters,
    this.height,
    this.width,
    this.theme,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onImpression,
    this.onAdClicked,
    this.onLeftApplication,
    this.onReturnedToApplication,
    this.willPresentScreen,
    this.didDismissScreen,
    this.onClose,
    Key? key,
  }) : super(key: key);

  final String id;
  final AdParameters? parameters;
  final double? height;
  final double? width;
  final NativeAdTheme? theme;

  final VoidCallback? onAdLoaded;
  final void Function(int code, String description)? onAdFailedToLoad;
  final void Function(String? impression)? onImpression;
  final VoidCallback? onAdClicked;
  final VoidCallback? onLeftApplication;
  final VoidCallback? onReturnedToApplication;
  final VoidCallback? willPresentScreen;
  final VoidCallback? didDismissScreen;
  final VoidCallback? onClose;

  @override
  State<NativeAdView> createState() => _NativeAdViewState();
}

class _NativeAdViewState extends State<NativeAdView> {
  /// Ad unique id. It is needed because it is possible for user to create
  /// several instances of ads with the same [widget.id]
  ///
  late String _viewUId;

  /// Api instance
  ///
  late FlutterYandexAdsApi _api;

  @override
  void initState() {
    super.initState();

    _setApi();
    _setViewUid();
    _setUpListener();
  }

  /// Sets api instance as state property
  ///
  void _setApi() {
    _api = FlutterYandexAdsApi();
  }

  /// Sets ad unique id.
  ///
  void _setViewUid() {
    _viewUId = DateTime.now().hashCode.toString();
  }

  /// Sets up ad events listener
  ///
  void _setUpListener() {
    final listener = NativeAdEventListener(
      viewUid: _viewUId,
      onAdLoaded: widget.onAdLoaded,
      onAdFailedToLoad: widget.onAdFailedToLoad,
      onLeftApplication: widget.onLeftApplication,
      onReturnedToApplication: widget.onReturnedToApplication,
      onAdClicked: widget.onAdClicked,
      onImpression: widget.onImpression,
      didDismissScreen: widget.didDismissScreen,
      willPresentScreen: widget.willPresentScreen,
      onClose: widget.onClose,
    );

    _api.addNativeAdEventListener(listener);
  }

  @override
  void dispose() {
    _api.removeNativeAdEventListener(_viewUId);

    super.dispose();
  }

  double get _defaultHeight => 250;
  double get _defaultWidth => 300;

  double _calculateHeight(BoxConstraints constraints) {
    return widget.height ??
        (constraints.hasBoundedHeight ? constraints.maxHeight : _defaultHeight);
  }

  double _calculateWidth(BoxConstraints constraints) {
    return widget.width ??
        (constraints.hasBoundedWidth ? constraints.maxWidth : _defaultWidth);
  }

  @override
  Widget build(BuildContext context) {
    const String viewType = PlatformApiConfig.nativeAdViewTypeId;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      height: widget.height,
      width: widget.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final defaultTheme = _getDefaultNativeAdTheme(context);
          final theme = widget.theme != null
              ? defaultTheme.copyWithAnother(widget.theme!)
              : defaultTheme;

          final params = _NativeAdParams(
            viewUid: _viewUId,
            adUid: widget.id,
            height: _calculateHeight(constraints),
            width: _calculateWidth(constraints),
            theme: theme,
            parameters: widget.parameters,
          );

          switch (defaultTargetPlatform) {
            case TargetPlatform.android:
              return AndroidView(
                viewType: viewType,
                creationParams: params.toMap(),
                creationParamsCodec: const StandardMessageCodec(),
              );

            case TargetPlatform.iOS:
              return UiKitView(
                viewType: viewType,
                creationParams: params.toMap(),
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
  _NativeAdParams({
    required this.viewUid,
    required this.adUid,
    required this.height,
    required this.width,
    required this.theme,
    required this.parameters,
  });

  final String viewUid;
  final String adUid;
  final double height;
  final double width;
  NativeAdTheme theme;
  final AdParameters? parameters;

  Map<String, dynamic> toMap() {
    return {
      'view_uid': viewUid,
      'ad_uid': adUid,
      'height': height.toInt(),
      'width': width.toInt(),
      'theme': theme.toMap(),
      'parameters': parameters?.toJson(),
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
