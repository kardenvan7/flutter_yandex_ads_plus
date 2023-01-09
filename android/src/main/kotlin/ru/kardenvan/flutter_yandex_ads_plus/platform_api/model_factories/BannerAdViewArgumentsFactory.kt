package ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories

import android.util.Size
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.ads.banner_yandex_ad.BannerYandexAdViewArguments

class BannerAdViewArgumentsFactory {
    companion object Factory {
        fun fromMap(map: Map<*, *>): BannerYandexAdViewArguments {
            val viewUid = map["view_uid"]

            if (viewUid !is String) {
                throw Exception(
                    "Arguments map doesn't contain required parameter \"ad_id\".\n" +
                            "Given arguments: $map"
                )
            }

            val adUid = map["ad_uid"]

            if (adUid !is String) {
                throw Exception(
                    "Arguments map doesn't contain required parameter \"ad_id\".\n" +
                            "Given arguments: $map"
                )
            }

            val height: Int = map["height"] as Int? ?: 250
            val width: Int = map["width"] as Int? ?: 300
            val size = Size(width, height)

            val rawParams = map["parameters"]
            var parameters: AdParameters? = null

            if (rawParams is Map<*, *>) {
                parameters = AdParametersFactory.fromMap(rawParams)
            }


            return BannerYandexAdViewArguments(
                viewUid = viewUid,
                adUid = adUid,
                size = size,
                parameters = parameters,
            )
        }
    }
}