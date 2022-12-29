package ru.kardenvan.flutter_yandex_ads_plus.views.banner_yandex_ad

import android.util.Size

data class BannerYandexAdViewArguments(
    val viewUid: String,
    val adUid: String,
    val size: Size,
    val additionalLoadParameters: Map<*, *>?
)