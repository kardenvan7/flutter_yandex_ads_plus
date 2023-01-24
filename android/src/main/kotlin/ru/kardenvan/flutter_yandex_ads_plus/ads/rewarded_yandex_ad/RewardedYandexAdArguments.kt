package ru.kardenvan.flutter_yandex_ads_plus.ads.rewarded_yandex_ad

import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters

data class RewardedYandexAdArguments(
    val uid: String,
    val adId: String,
    val parameters: AdParameters?,
)