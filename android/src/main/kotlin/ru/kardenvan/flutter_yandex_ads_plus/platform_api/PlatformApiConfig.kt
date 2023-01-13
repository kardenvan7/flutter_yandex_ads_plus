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
         * Event channel name
         */
        const val eventChannelName: String = "flutter_yandex_ads_plus_event_channel"
    }
}