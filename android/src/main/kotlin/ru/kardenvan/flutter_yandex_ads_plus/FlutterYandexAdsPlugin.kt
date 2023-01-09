package ru.kardenvan.flutter_yandex_ads_plus

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.FlutterYandexAdsApi
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.PlatformApiConfig
import ru.kardenvan.flutter_yandex_ads_plus.ads.banner_yandex_ad.BannerYandexAdViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad.NativeYandexAdViewFactory

/** FlutterYandexAdsPlugin */
class FlutterYandexAdsPlugin : FlutterPlugin, ActivityAware {
    private lateinit var api: FlutterYandexAdsApi

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        api = FlutterYandexAdsApi(binding.binaryMessenger)

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

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        api.setAppContext(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        api.setAppContext(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        api.setAppContext(binding.activity)
    }

    override fun onDetachedFromActivity() {
        api.setAppContext(null)
    }
}


