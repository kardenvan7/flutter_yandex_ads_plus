import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeAdView extends StatelessWidget {
  const NativeAdView({
    required this.id,
    this.height,
    this.width,
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

  @override
  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-native';

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final Map<String, dynamic> params = _NativeAdParams(
            adId: id,
            minHeight: height ?? constraints.maxHeight,
            minWidth: width ?? constraints.maxWidth,
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

class _NativeAdParams {
  const _NativeAdParams({
    required this.adId,
    this.minHeight = 320,
    this.minWidth = 100,
  });

  final String adId;
  final double minHeight;
  final double minWidth;

  Map<String, dynamic> toMap() {
    return {
      'ad_id': adId,
      'min_height': minHeight.toInt(),
      'min_width': minWidth.toInt(),
    };
  }
}
