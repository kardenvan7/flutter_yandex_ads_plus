package ru.kardenvan.flutter_yandex_ads_plus.platform_api.method_call_receiver

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.interstitial_yandex_ads_organizer.InterstitialYandexAdsOrganizer
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories.InterstitialAdArgumentsFactory

class FlutterYandexAdsMethodCallReceiver(
    binaryMessenger: BinaryMessenger,
    channelName: String,
    eventDispatcher: FlutterYandexAdsEventDispatcher
): MethodCallHandler {
    private var appContext: Context? = null
    private val methodChannel: MethodChannel = MethodChannel(binaryMessenger, channelName)
    private val interstitialAdsOrchestrator = InterstitialYandexAdsOrganizer(eventDispatcher)

    init {
        methodChannel.setMethodCallHandler(this)
    }

    fun setContext(context: Context?) {
        appContext = context
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "loadInterstitialAd" -> loadInterstitialAd(call, result)
            "showInterstitialAd" -> showInterstitialAd(call, result)
            "removeInterstitialAd" -> removeInterstitialAd(call, result)
            else -> handleUnknownMethodCall(call, result)
        }
    }

    private fun loadInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
        if (appContext == null) return

        try {
            val rawArguments = call.arguments
            if (rawArguments !is Map<*, *>) {
                throw Exception(
                    "Arguments for method \"loadInterstitialAd\" are not valid.\n" +
                    "Current value: $rawArguments"
                )
            }

            val arguments = InterstitialAdArgumentsFactory.fromMap(rawArguments)

            interstitialAdsOrchestrator.createAndLoadAd(appContext!!, arguments)

            result.success(null)
        } catch (e: Exception) {
            result.error(e.toString(), e.localizedMessage, null)
        }
    }

    private fun showInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            val uid = call.arguments

            if (uid !is String) throw Exception("Passed uid is invalid. Uid: $uid")

            interstitialAdsOrchestrator.showAd(uid)

            result.success(null)
        } catch (e: Exception) {
            result.error(e.toString(), e.localizedMessage, null)
        }
    }

    private fun removeInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            val uid = call.arguments

            if (uid !is String) throw Exception("Passed uid is invalid. Uid: $uid")

            interstitialAdsOrchestrator.removeAd(uid)

            result.success(null)
        } catch (e: Exception) {
            result.error(e.toString(), e.localizedMessage, null)
        }
    }

    private fun handleUnknownMethodCall(call: MethodCall, result: MethodChannel.Result) {
        result.error(
            "-1",
            "Current platform has no implementation of method \"${call.method}\"",
            null
        )
    }
}