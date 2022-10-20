package ru.kardenvan.flutter_yandex_ads_plus.components

import android.util.Log
import ru.kardenvan.flutter_yandex_ads_plus.pigeons.Rewarded

class YandexAdsRewarded: Rewarded.YandexAdsRewarded {
    override fun load() {
        Log.d("rewarded", "load")
    }
}