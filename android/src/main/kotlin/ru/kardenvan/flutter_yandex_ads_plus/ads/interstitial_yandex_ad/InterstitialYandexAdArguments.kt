package ru.kardenvan.flutter_yandex_ads_plus.ads.interstitial_yandex_ad

import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters

data class InterstitialYandexAdArguments(
    val uid: String,
    val adId: String,
    val parameters: AdParameters?,
)