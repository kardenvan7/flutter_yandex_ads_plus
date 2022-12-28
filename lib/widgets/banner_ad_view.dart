import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/platform_api/config.dart';

import '../platform_api/platform_api.dart';

/// Flutter-implementation of native [BannerAdView] (Kotlin, Android) and
/// [YMAAdView] (Swift, iOS).
///
/// [id] - unique identifier of the ad, obtained in partner interface.
/// Example: R-M-XXXXXX-Y.
///
/// [height] - ad height. The height must match height in partner interface
/// otherwise, the ad will not load.
///
/// [width] - ad width. If not set, takes up all available width.
///
/// [additionalLoadParameters] - parameters given by the ad provider
/// (like AdFox or others).
///
/// [iosSettings] - additional presentation settings for iOS.
///
/// [onAdLoaded] - callback triggered when the ad is successfully loaded.
///
///
class BannerAdView extends StatefulWidget {
  const BannerAdView({
    required this.id,
    this.height,
    this.width,
    this.additionalLoadParameters,
    this.iosSettings,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onImpression,
    this.onAdClicked,
    this.onLeftApplication,
    this.onReturnedToApplication,
    Key? key,
  }) : super(key: key);

  final String id;
  final double? height;
  final double? width;
  final Map<String, String>? additionalLoadParameters;
  final IosBannerAdViewSettings? iosSettings;

  final VoidCallback? onAdLoaded;
  final void Function(int code, String description)? onAdFailedToLoad;
  final void Function(String? impression)? onImpression;
  final VoidCallback? onAdClicked;
  final VoidCallback? onLeftApplication;
  final VoidCallback? onReturnedToApplication;

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
    );

    _api.addBannerAdEventListener(listener);
  }

  @override
  void dispose() {
    _api.removeBannerAdEventListener(_viewUId);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String viewType = PlatformApiConfig.bannerAdViewTypeId;

    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final adWidth = widget.width ??
              (constraints.hasBoundedWidth ? constraints.maxWidth : 300);
          final adHeight = widget.height ??
              (constraints.hasBoundedHeight ? constraints.maxHeight : 250);

          final Map<String, dynamic> params = _BannerAdParams(
            viewUid: _viewUId,
            adUId: widget.id,
            height: adHeight,
            width: adWidth,
            additionalLoadParams: widget.additionalLoadParameters,
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
    this.additionalLoadParams,
    this.iosSettings,
  });

  final String viewUid;
  final String adUId;
  final double height;
  final double width;
  final Map<String, String>? additionalLoadParams;
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
      'additional_load_parameters': additionalLoadParams,
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
