package ru.kardenvan.flutter_yandex_ads_plus.ads

import android.content.Context
import com.yandex.mobile.ads.common.MobileAds
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import ru.kardenvan.flutter_yandex_ads_plus.utils.PluginLogger

object YandexAdsSdkFacade {
    fun initialize(context: Context) {
        MobileAds.initialize(context) {
            PluginLogger.log("Initialized")
        }
    }

    fun setAgeRestrictedUser(value: Boolean) {
        MobileAds.setAgeRestrictedUser(value)

        PluginLogger.log("User age restriction ${if (value) "enabled" else "disabled"}")
    }

    fun setEnableLogging(value: Boolean) {
        MobileAds.enableLogging(value)

        PluginLogger.log("Logging ${if (value) "enabled" else "disabled"}")
    }

    fun setEnableDebugErrorIndicator(value: Boolean) {
        MobileAds.enableDebugErrorIndicator(value)

        PluginLogger.log("Debug error indicator ${if (value) "enabled" else "disabled"}")
    }

    fun setLocationConsent(value: Boolean) {
        MobileAds.setLocationConsent(value)

        PluginLogger.log("Location consent ${if (value) "enabled" else "disabled"}")
    }

    fun setUserConsent(value: Boolean) {
        MobileAds.setUserConsent(value)

        PluginLogger.log("User consent ${if (value) "enabled" else "disabled"}")
    }

    fun getLibraryVersion(): String {
        return MobileAds.getLibraryVersion()
    }
}