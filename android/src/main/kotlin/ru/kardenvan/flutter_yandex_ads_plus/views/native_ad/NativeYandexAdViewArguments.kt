package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.util.Size

data class NativeYandexAdViewArguments(
    val viewUid: String,
    val adId: String,
    val minSize: Size,
    val theme: NativeYandexAdViewTheme,
    val additionalParams: Map<*, *>?,
)