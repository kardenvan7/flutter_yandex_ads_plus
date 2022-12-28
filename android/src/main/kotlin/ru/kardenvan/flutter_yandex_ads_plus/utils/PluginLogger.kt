package ru.kardenvan.flutter_yandex_ads_plus.utils

import android.util.Log

class PluginLogger {
    companion object {
        private const val tag: String = "FlutterYandexAdsPlus"

        fun log(message: String) {
            Log.d(tag, message)
        }
    }
}