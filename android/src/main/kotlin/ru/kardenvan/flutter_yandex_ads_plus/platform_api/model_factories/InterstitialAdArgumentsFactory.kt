package ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories

import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.ads.interstitial_yandex_ad.InterstitialYandexAdArguments

class InterstitialAdArgumentsFactory {
    companion object Factory {
        fun fromMap(map: Map<*, *>): InterstitialYandexAdArguments {
            val uid = map["uid"]

            if (uid !is String) throw Exception("Ad uid is not valid. Current value: $uid")

            val adId = map["ad_id"]

            if (adId !is String) throw Exception("Ad id is not valid. Current value: $adId")

            val params = map["parameters"]

            if (params !is Map<*, *>?) throw Exception("Additional params are not valid. Current value: $params")

            var parameters: AdParameters? = null

            if (params != null) {
                parameters = AdParametersFactory.fromMap(params)
            }

            return InterstitialYandexAdArguments(
                uid = uid,
                adId = adId,
                parameters = parameters,
            )
        }
    }
}