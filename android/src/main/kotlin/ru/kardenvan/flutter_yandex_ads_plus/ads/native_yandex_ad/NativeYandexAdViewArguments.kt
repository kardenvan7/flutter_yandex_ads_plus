package ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad

import android.util.Size
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters

data class NativeYandexAdViewArguments(
    val viewUid: String,
    val adId: String,
    val minSize: Size,
    val theme: NativeYandexAdViewTheme,
    val parameters: AdParameters?
)