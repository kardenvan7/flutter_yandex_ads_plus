/// Class containing configuration values for platform message communication.
///
class PlatformApiConfig {
  const PlatformApiConfig._();

  /// Ad view types

  static const String bannerAdViewTypeId = 'banner_yandex_ad';
  static const String nativeAdViewTypeId = 'native_yandex_ad';

  /// Method channel name
  static const String methodChannelName =
      "flutter_yandex_ads_plus_method_channel";

  /// Event channel names

  static const String bannerAdEventChannelName =
      'banner_yandex_ad_event_channel';
  static const String nativeAdEventChannelName =
      'native_yandex_ad_event_channel';
}
