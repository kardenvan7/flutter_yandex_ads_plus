import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/src/core/core.dart';
import 'package:flutter_yandex_ads_plus/src/platform_api/platform_api.dart';
import 'package:flutter_yandex_ads_plus/src/utils/unique_id_generator.dart';

/// Flutter-implementation of native [BannerYandexAdView] (Kotlin, Android) and
/// [YMAAdView] (Swift, iOS).
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
/// [iosSettings] - additional presentation settings for iOS.
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
class BannerYandexAdView extends StatefulWidget {
  const BannerYandexAdView({
    required this.id,
    this.height,
    this.width,
    this.parameters,
    this.iosSettings,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onImpression,
    this.onAdClicked,
    this.onLeftApplication,
    this.onReturnedToApplication,
    this.willPresentScreen,
    this.didDismissScreen,
    Key? key,
  }) : super(key: key);

  final String id;
  final double? height;
  final double? width;
  final YandexAdParameters? parameters;
  final IosBannerAdViewSettings? iosSettings;

  final VoidCallback? onAdLoaded;
  final YandexAdErrorCallback? onAdFailedToLoad;
  final YandexAdImpressionCallback? onImpression;
  final VoidCallback? onAdClicked;
  final VoidCallback? onLeftApplication;
  final VoidCallback? onReturnedToApplication;
  final VoidCallback? willPresentScreen;
  final VoidCallback? didDismissScreen;

  @override
  State<BannerYandexAdView> createState() => _BannerYandexAdViewState();
}

class _BannerYandexAdViewState extends State<BannerYandexAdView> {
  /// Ad unique id. It is needed because it is possible for user to create
  /// several instances of ads with the same [widget.id]
  ///
  final String _viewUid = UniqueIdGenerator.generate();

  /// Api instance
  ///
  final FlutterYandexAdsApi _api = FlutterYandexAdsApi();

  @override
  void initState() {
    super.initState();

    _setUpEventListener();
  }

  /// Sets up ad events listener
  ///
  void _setUpEventListener() {
    final listener = BasicAdEventListener(
      uid: _viewUid,
      onAdLoaded: widget.onAdLoaded,
      onAdFailedToLoad: widget.onAdFailedToLoad,
      onLeftApplication: widget.onLeftApplication,
      onReturnedToApplication: widget.onReturnedToApplication,
      onAdClicked: widget.onAdClicked,
      onImpression: widget.onImpression,
      willPresentScreen: widget.willPresentScreen,
      didDismissScreen: widget.didDismissScreen,
    );

    _api.addAdEventListener(listener);
  }

  @override
  void dispose() {
    _api.removeAdEventListener(_viewUid);

    super.dispose();
  }

  double get _defaultHeight => 250;
  double get _defaultWidth => 300;

  double _calculateWidth(BoxConstraints constraints) {
    return widget.width ??
        (constraints.hasBoundedWidth ? constraints.maxWidth : _defaultWidth);
  }

  double _calculateHeight(BoxConstraints constraints) {
    return widget.height ??
        (constraints.hasBoundedHeight ? constraints.maxHeight : _defaultHeight);
  }

  @override
  Widget build(BuildContext context) {
    const String viewType = PlatformApiConfig.bannerAdViewTypeId;

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final Map<String, dynamic> params = BannerYandexAdPlatformParameters(
            uid: _viewUid,
            adId: widget.id,
            height: _calculateHeight(constraints),
            width: _calculateWidth(constraints),
            parameters: widget.parameters,
            iosSettings: widget.iosSettings,
          ).toJson();

          switch (defaultTargetPlatform) {
            case TargetPlatform.android:
              return AndroidView(
                viewType: viewType,
                creationParams: params,
                creationParamsCodec: const StandardMessageCodec(),
              );

            case TargetPlatform.iOS:
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
