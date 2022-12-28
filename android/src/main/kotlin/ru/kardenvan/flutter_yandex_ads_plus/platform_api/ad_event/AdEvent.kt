package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event

abstract class AdEvent {
    abstract fun toMap(): Map<*, *>
}