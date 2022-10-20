package ru.kardenvan.flutter_yandex_ads_plus.platform_api

enum class EventType(val type: String) {
    BANNER("banner"),
    INTERSTITIAL("interstitial"),
    NATIVE("native"),
    REWARDED("rewarded"),
}