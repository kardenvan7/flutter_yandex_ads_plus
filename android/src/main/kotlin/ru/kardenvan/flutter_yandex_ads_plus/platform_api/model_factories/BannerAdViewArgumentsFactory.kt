package ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories

import android.util.Size
import ru.kardenvan.flutter_yandex_ads_plus.views.banner.BannerYandexAdViewArguments

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

            val rawAdditionalParams = map["additional_load_parameters"]
            val additionalParams: Map<*,*>? =
                if (rawAdditionalParams is Map<*,*>)
                    rawAdditionalParams
                else
                    null



            return BannerYandexAdViewArguments(
                viewUid = viewUid,
                adUid = adUid,
                size = size,
                additionalLoadParameters = additionalParams,
            )
        }
    }
}