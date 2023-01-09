import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/core/ad_parameters/ad_parameters.dart';
import 'package:flutter_yandex_ads_plus/platform_api/config.dart';

import '../platform_api/platform_api.dart';

/// Flutter-implementation of native [BannerAdView] (Kotlin, Android) and
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
class BannerAdView extends StatefulWidget {
  const BannerAdView({
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
  final AdParameters? parameters;
  final IosBannerAdViewSettings? iosSettings;

  final VoidCallback? onAdLoaded;
  final void Function(int code, String description)? onAdFailedToLoad;
  final void Function(String? impression)? onImpression;
  final VoidCallback? onAdClicked;
  final VoidCallback? onLeftApplication;
  final VoidCallback? onReturnedToApplication;
  final VoidCallback? willPresentScreen;
  final VoidCallback? didDismissScreen;

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
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
    final listener = BasicAdEventListener(
      viewUid: _viewUId,
      onAdLoaded: widget.onAdLoaded,
      onAdFailedToLoad: widget.onAdFailedToLoad,
      onLeftApplication: widget.onLeftApplication,
      onReturnedToApplication: widget.onReturnedToApplication,
      onAdClicked: widget.onAdClicked,
      onImpression: widget.onImpression,
      willPresentScreen: widget.willPresentScreen,
      didDismissScreen: widget.didDismissScreen,
    );

    _api.addBannerAdEventListener(listener);
  }

  @override
  void dispose() {
    _api.removeBannerAdEventListener(_viewUId);

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
          final Map<String, dynamic> params = _BannerAdParams(
            viewUid: _viewUId,
            adUId: widget.id,
            height: _calculateHeight(constraints),
            width: _calculateWidth(constraints),
            parameters: widget.parameters,
            iosSettings: widget.iosSettings,
          ).toMap();

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

class _BannerAdParams {
  const _BannerAdParams({
    required this.viewUid,
    required this.adUId,
    required this.height,
    required this.width,
    this.parameters,
    this.iosSettings,
  });

  final String viewUid;
  final String adUId;
  final double height;
  final double width;
  final AdParameters? parameters;
  final IosBannerAdViewSettings? iosSettings;

  IosBannerAdViewSettings get defaultIosSettings {
    return const IosBannerAdViewSettings(
      translatesAutoResizingMaskIntoConstraints: true,
    );
  }

  Map<String, dynamic> toMap() {
    final params = {
      'view_uid': viewUid,
      'ad_uid': adUId,
      'height': height.toInt(),
      'width': width.toInt(),
      'parameters': parameters?.toJson(),
    };

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      params['settings'] = iosSettings?.toMap() ?? defaultIosSettings.toMap();
    }

    return params;
  }
}

class IosBannerAdViewSettings {
  const IosBannerAdViewSettings({
    this.translatesAutoResizingMaskIntoConstraints = true,
  });

  final bool translatesAutoResizingMaskIntoConstraints;

  Map<String, dynamic> toMap() {
    return {
      'translates_auto_resizing_mask_into_constraints':
          translatesAutoResizingMaskIntoConstraints,
    };
  }
}
