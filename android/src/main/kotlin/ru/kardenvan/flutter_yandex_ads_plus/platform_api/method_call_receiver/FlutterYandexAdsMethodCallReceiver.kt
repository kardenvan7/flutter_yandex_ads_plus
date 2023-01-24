package ru.kardenvan.flutter_yandex_ads_plus.platform_api.method_call_receiver

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import ru.kardenvan.flutter_yandex_ads_plus.ads.YandexAdsSdkFacade
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ads_organizer.InterstitialYandexAdsOrganizer
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ads_organizer.RewardedYandexAdsOrganizer
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories.InterstitialAdArgumentsFactory
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories.RewardedAdArgumentsFactory

class FlutterYandexAdsMethodCallReceiver(
    binaryMessenger: BinaryMessenger,
    channelName: String,
    eventDispatcher: FlutterYandexAdsEventDispatcher
): MethodCallHandler {
    private var appContext: Context? = null
    private val methodChannel: MethodChannel = MethodChannel(binaryMessenger, channelName)

    private val interstitialAdsOrchestrator = InterstitialYandexAdsOrganizer(eventDispatcher)
    private val rewardedAdsOrchestrator = RewardedYandexAdsOrganizer(eventDispatcher)

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
            "loadRewardedAd" -> loadRewardedAd(call, result)
            "showRewardedAd" -> showRewardedAd(call, result)
            "removeRewardedAd" -> removeRewardedAd(call, result)
            "setAgeRestrictedUser" -> setAgeRestrictedUser(call, result)
            "enableLogging" -> setEnableLogging(call, result)
            "enableDebugErrorIndicator" -> setEnableDebugErrorIndicator(call, result)
            "setLocationConsent" -> setLocationConsent(call, result)
            "setUserConsent" -> setUserConsent(call, result)
            "getLibraryVersion" -> getLibraryVersion(call, result)
            else -> handleUnknownMethodCall(call, result)
        }
    }

    private fun loadInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            if (appContext == null) {
                throw Exception("Context is not set for the ad")
            }

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
            handleError(e, call, result)
        }
    }

    private fun showInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            val uid = call.arguments

            if (uid !is String) throw Exception("Passed uid is invalid. Uid: $uid")

            interstitialAdsOrchestrator.showAd(uid)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun removeInterstitialAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            val uid = call.arguments

            if (uid !is String) throw Exception("Passed uid is invalid. Uid: $uid")

            interstitialAdsOrchestrator.removeAd(uid)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun loadRewardedAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            if (appContext == null) {
                throw Exception("Context is not set for the ad")
            }

            val rawArguments = call.arguments
            if (rawArguments !is Map<*, *>) {
                throw Exception(
                    "Arguments for method \"loadInterstitialAd\" are not valid.\n" +
                            "Current value: $rawArguments"
                )
            }

            val arguments = RewardedAdArgumentsFactory.fromMap(rawArguments)

            rewardedAdsOrchestrator.createAndLoadAd(appContext!!, arguments)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun showRewardedAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            val uid = call.arguments

            if (uid !is String) throw Exception("Passed uid is invalid. Uid: $uid")

            rewardedAdsOrchestrator.showAd(uid)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun removeRewardedAd(call: MethodCall, result: MethodChannel.Result) {
        try {
            val uid = call.arguments

            if (uid !is String) throw Exception("Passed uid is invalid. Uid: $uid")

            rewardedAdsOrchestrator.removeAd(uid)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun setAgeRestrictedUser(call: MethodCall, result: MethodChannel.Result) {
        try {
            val arg = call.arguments

            if (arg !is Boolean) throw Exception("Wrong argument provided for method")

            YandexAdsSdkFacade.setAgeRestrictedUser(arg)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun setEnableLogging(call: MethodCall, result: MethodChannel.Result) {
        try {
            val arg = call.arguments

            if (arg !is Boolean) throw Exception("Wrong argument provided for method")

            YandexAdsSdkFacade.setEnableLogging(arg)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun setEnableDebugErrorIndicator(call: MethodCall, result: MethodChannel.Result) {
        try {
            val arg = call.arguments

            if (arg !is Boolean) throw Exception("Wrong argument provided for method")

            YandexAdsSdkFacade.setEnableDebugErrorIndicator(arg)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun setLocationConsent(call: MethodCall, result: MethodChannel.Result) {
        try {
            val arg = call.arguments

            if (arg !is Boolean) throw Exception("Wrong argument provided for method")

            YandexAdsSdkFacade.setLocationConsent(arg)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun setUserConsent(call: MethodCall, result: MethodChannel.Result) {
        try {
            val arg = call.arguments

            if (arg !is Boolean) throw Exception("Wrong argument provided for method")

            YandexAdsSdkFacade.setUserConsent(arg)

            result.success(null)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun getLibraryVersion(call: MethodCall, result: MethodChannel.Result) {
        try {
            val version = YandexAdsSdkFacade.getLibraryVersion()

            result.success(version)
        } catch (e: Exception) {
            handleError(e, call, result)
        }
    }

    private fun handleError(e: Exception, call: MethodCall, result: MethodChannel.Result) {
        result.error(e.toString(), e.localizedMessage, "Method ${call.method}")
    }

    private fun handleUnknownMethodCall(call: MethodCall, result: MethodChannel.Result) {
        result.error(
            "-1",
            "Current platform has no implementation of method \"${call.method}\"",
            null
        )
    }
}