package ru.kardenvan.flutter_yandex_ads_plus.platform_api.method_call_receiver

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import ru.kardenvan.flutter_yandex_ads_plus.ads.interstitial_yandex_ad.InterstitialYandexAd
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.InterstitialAdEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories.InterstitialAdArgumentsFactory

class FlutterYandexAdsMethodCallReceiver(
    binaryMessenger: BinaryMessenger,
    channelName: String,
    private val interstitialAdEventDispatcher: InterstitialAdEventDispatcher
): MethodCallHandler {
    private var appContext: Context? = null
    private val methodChannel: MethodChannel = MethodChannel(binaryMessenger, channelName)

    init {
        methodChannel.setMethodCallHandler(this)
    }

    fun setContext(context: Context?) {
        appContext = context
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "showInterstitialAd" -> showInterstitialAd(call, result)
        }
    }

    private fun showInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
        if (appContext == null) return

        try {
            val rawArguments = call.arguments
            if (rawArguments !is Map<*, *>) {
                throw Exception(
                    "Arguments for method \"showInterstitialAd\" are not valid. Current value: $rawArguments"
                )
            }

            val arguments = InterstitialAdArgumentsFactory.fromMap(rawArguments)
            val ad = InterstitialYandexAd(
                appContext!!,
                arguments.adUid,
                interstitialAdEventDispatcher
            )

            ad.loadAndShowAd(arguments.parameters)

            result.success(null)
        } catch (e: Exception) {
            result.error(e.toString(), e.localizedMessage, null)
        }
    }
}