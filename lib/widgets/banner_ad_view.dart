import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads_plus/yandex.dart';

class BannerAdView extends StatelessWidget {
  BannerAdView({
    required this.id,
    required this.ads,
    this.height,
    this.width,
    this.additionalLoadParameters,
    this.iosSettings,
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onImpression,
    Function? onAdClicked,
    Function? onLeftApplication,
    Function? onReturnedToApplication,
    Key? key,
  }) : super(key: key) {
    if (onAdLoaded != null) {
      ads.setOnAdLoaded(id, EventType.banner, onAdLoaded);
    }

    if (onAdFailedToLoad != null) {
      ads.setOnAdFailedToLoad(id, EventType.banner, onAdFailedToLoad);
    }

    if (onImpression != null) {
      ads.setOnImpression(id, EventType.banner, onImpression);
    }

    if (onAdClicked != null) {
      ads.setOnAdCLicked(id, EventType.banner, onAdClicked);
    }

    if (onLeftApplication != null) {
      ads.setOnLeftApplication(id, EventType.banner, onLeftApplication);
    }

    if (onReturnedToApplication != null) {
      ads.setOnReturnedToApplication(
          id, EventType.banner, onReturnedToApplication);
    }
  }

  final String id;
  final FlutterYandexAds ads;
  final double? height;
  final double? width;
  final Map<String, String>? additionalLoadParameters;
  final IosBannerAdViewSettings? iosSettings;

  @override
  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-banner';

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final adWidth = width ??
              (constraints.hasBoundedWidth ? constraints.maxWidth : 100);
          final adHeight = height ??
              (constraints.hasBoundedHeight ? constraints.maxHeight : 250);

          print(adWidth);

          final Map<String, dynamic> params = _BannerAdParams(
            adId: id,
            height: adHeight,
            width: adWidth,
            additionalLoadParams: additionalLoadParameters,
            iosSettings: iosSettings,
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
    required this.adId,
    required this.height,
    required this.width,
    this.additionalLoadParams,
    this.iosSettings,
  });

  final String adId;
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
      'ad_id': adId,
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
