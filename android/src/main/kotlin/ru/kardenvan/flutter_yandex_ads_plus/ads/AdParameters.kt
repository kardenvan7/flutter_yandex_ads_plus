package ru.kardenvan.flutter_yandex_ads_plus.ads

import android.location.Location
import com.yandex.mobile.ads.common.AdTheme


data class AdParameters(
    val age: String?,
    val biddingData: String?,
    val contextQuery: String?,
    val contextTags: List<String>?,
    val gender: String?,
    val preferredTheme: AdTheme?,
    val location: Location?,
    val custom: Map<String, String>?,
)