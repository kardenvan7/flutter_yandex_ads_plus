package ru.kardenvan.flutter_yandex_ads_plus.views.banner

import android.util.Size

class BannerAdViewArguments(
    private val id: String,
    private val size: Size,
) {
    fun getId(): String { return id }
    fun getSize(): Size { return size }
}