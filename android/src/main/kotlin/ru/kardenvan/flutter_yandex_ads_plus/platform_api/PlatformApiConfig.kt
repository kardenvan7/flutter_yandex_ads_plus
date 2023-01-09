package ru.kardenvan.flutter_yandex_ads_plus.platform_api

/**
 * Class containing configuration values for platform communication.
 */
class PlatformApiConfig {
    companion object {
        /**
         * Ad view types
         */

        const val bannerAdViewTypeId: String = "banner_yandex_ad"
        const val nativeAdViewTypeId: String = "native_yandex_ad"

        /**
         * Method channel name
         */
        const val methodChannelName: String = "flutter_yandex_ads_plus_method_channel"

        /**
         * Event channel names
         */

        const val bannerAdEventChannelName: String = "banner_yandex_ad_event_channel"
        const val nativeAdEventChannelName: String = "native_yandex_ad_event_channel"
        const val interstitialAdEventChannelName: String = "interstitial_yandex_ad_event_channel"
    }
}