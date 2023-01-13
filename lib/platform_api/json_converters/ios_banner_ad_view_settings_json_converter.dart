import 'package:flutter_yandex_ads_plus/core/ios_banner_ad_view_settings.dart';

extension IosBannerAdViewSettingsToJson on IosBannerAdViewSettings {
  Map<String, dynamic> toJson() {
    return {
      'translates_auto_resizing_mask_into_constraints':
          translatesAutoResizingMaskIntoConstraints,
    };
  }
}
