import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/src/core/core.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/platform_api.dart';
import 'package:flutter_yandex_ads_plus/src/utils/unique_id_generator.dart';

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
class NativeYandexAdView extends StatefulWidget {
  const NativeYandexAdView({
    required this.id,
    this.parameters,
    this.height,
    this.width,
    this.theme,
    this.listener,
    Key? key,
  }) : super(key: key);

  final String id;
  final YandexAdParameters? parameters;
  final double? height;
  final double? width;
  final NativeAdTheme? theme;
  final NativeAdEventListener? listener;

  @override
  State<NativeYandexAdView> createState() => _NativeYandexAdViewState();
}

class _NativeYandexAdViewState extends State<NativeYandexAdView> {
  /// Ad unique id. It is needed because it is possible for user to create
  /// several instances of ads with the same [widget.id]
  ///
  final String _viewUid = UniqueIdGenerator.generate();

  /// Api instance
  ///
  final FlutterYandexAdsApi _api = FlutterYandexAdsApi();

  bool get hasListener => widget.listener != null;

  @override
  void initState() {
    super.initState();

    _setUpEventListener();
  }

  /// Sets up ad events listener
  ///
  void _setUpEventListener() {
    if (hasListener) {
      _api.listenToAdEvents(
        _viewUid,
        NativeAdEventEmitter(listener: widget.listener!),
      );
    }
  }

  @override
  void dispose() {
    if (hasListener) _api.removeAdEventListener(_viewUid);

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

          final paramsJson = NativeYandexAdPlatformParameters(
            uid: _viewUid,
            adId: widget.id,
            height: _calculateHeight(constraints),
            width: _calculateWidth(constraints),
            theme: theme,
            parameters: widget.parameters,
          ).toJson();

          switch (defaultTargetPlatform) {
            case TargetPlatform.android:
              return AndroidView(
                viewType: viewType,
                creationParams: paramsJson,
                creationParamsCodec: const StandardMessageCodec(),
              );

            case TargetPlatform.iOS:
              return UiKitView(
                viewType: viewType,
                creationParams: paramsJson,
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

  NativeAdTheme _getDefaultNativeAdTheme(context) {
    final brightness = Theme.of(context).brightness;

    switch (brightness) {
      case Brightness.light:
        return _DefaultNativeAdThemes.light;

      case Brightness.dark:
        return _DefaultNativeAdThemes.dark;
    }
  }
}

class _DefaultNativeAdThemes {
  static const NativeAdTheme light = NativeAdTheme(
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

  static const NativeAdTheme dark = NativeAdTheme(
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
