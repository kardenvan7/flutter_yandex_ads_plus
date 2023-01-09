package ru.kardenvan.flutter_yandex_ads_plus

import io.flutter.embedding.engine.plugins.FlutterPlugin
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.FlutterYandexAdsApi
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.PlatformApiConfig
import ru.kardenvan.flutter_yandex_ads_plus.views.banner_yandex_ad.BannerYandexAdViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.views.native_yandex_ad.NativeYandexAdViewFactory

/** FlutterYandexAdsPlugin */
class FlutterYandexAdsPlugin : FlutterPlugin {
    private lateinit var api: FlutterYandexAdsApi

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        api = FlutterYandexAdsApi(binding.applicationContext, binding.binaryMessenger)

        binding.platformViewRegistry.registerViewFactory(
            PlatformApiConfig.bannerAdViewTypeId,
            BannerYandexAdViewFactory(api.bannerAdEventDispatcher)
        )

        binding.platformViewRegistry.registerViewFactory(
            PlatformApiConfig.nativeAdViewTypeId,
            NativeYandexAdViewFactory(api.nativeAdEventDispatcher)
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        api.dispose()
    }
}


