package ru.kardenvan.flutter_yandex_ads_plus.ads.banner_yandex_ad

import android.util.Size
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters

data class BannerYandexAdViewArguments(
    val viewUid: String,
    val adUid: String,
    val size: Size,
    val parameters: AdParameters?
)