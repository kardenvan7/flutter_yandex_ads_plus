package ru.kardenvan.flutter_yandex_ads_plus

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import ru.kardenvan.flutter_yandex_ads_plus.components.YandexAdsInterstitial
import ru.kardenvan.flutter_yandex_ads_plus.components.YandexAdsRewarded
import ru.kardenvan.flutter_yandex_ads_plus.pigeons.Interstitial
import ru.kardenvan.flutter_yandex_ads_plus.pigeons.Rewarded
import ru.kardenvan.flutter_yandex_ads_plus.pigeons.Yandex
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.YandexApi
import ru.kardenvan.flutter_yandex_ads_plus.views.YandexAdsNative
import ru.kardenvan.flutter_yandex_ads_plus.views.banner.BannerYandexAdFactory

/** FlutterYandexAdsPlugin */
class FlutterYandexAdsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context
    private lateinit var activity: Activity

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        // api set
        val api = YandexApi(context)
        Yandex.YandexAdsApi.setup(binding.binaryMessenger, api)

        // components
        Interstitial.YandexAdsInterstitial.setup(
            binding.binaryMessenger,
            YandexAdsInterstitial(api, context)
        )
        Rewarded.YandexAdsRewarded.setup(binding.binaryMessenger, YandexAdsRewarded())

        // widgets
        binding.platformViewRegistry.registerViewFactory(
            "yandex-ads-banner",
            BannerYandexAdFactory(api)
        )
        binding.platformViewRegistry.registerViewFactory("yandex-ads-native", YandexAdsNative())
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}


