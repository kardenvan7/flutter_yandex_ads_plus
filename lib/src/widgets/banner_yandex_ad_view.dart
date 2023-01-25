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
/// [listener] - ad event listener.
///
class BannerYandexAdView extends StatefulWidget {
  const BannerYandexAdView({
    required this.id,
    this.height,
    this.width,
    this.parameters,
    this.iosSettings,
    this.listener,
    Key? key,
  }) : super(key: key);

  final String id;
  final double? height;
  final double? width;
  final YandexAdParameters? parameters;
  final IosBannerAdViewSettings? iosSettings;
  final BannerAdEventListener? listener;

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
        BannerAdEventEmitter(listener: widget.listener!),
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
