package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.util.Size

class NativeAdViewArguments(
    private val id: String,
    private val minSize: Size,
    private val theme: NativeAdViewTheme,
    private val additionalParams: Map<*, *>?,
) {
    fun getId(): String {
        return id
    }

    fun getMinSize(): Size {
        return minSize
    }

    fun getTheme(): NativeAdViewTheme {
        return theme
    }

    fun getAdditionalParams(): Map<*, *>? {
        return additionalParams
    }
}