package ru.kardenvan.flutter_yandex_ads_plus.platform_api

import android.util.Size

class PlatformApi {
    class BannerViewArguments(args: Any?) {
        private val defaultHeight = 320
        private val defaultWidth = 100

        private var bannerId: String
        fun getBannerId(): String { return bannerId }

        private var size: Size
        fun getBannerSize(): Size { return size }

        init {
            if (args !is Map<*, *>) {
                throw Exception("Arguments is not map. Given arguments: $args")
            }

            val params: Map<*, *> = args

            if (args["ad_id"] == null) {
                throw Exception(
                    "Arguments map doesn't contain required parameter \"ad_id\"." +
                    "Given arguments: $args"
                )
            }

            bannerId = args["ad_id"] as String

            val height: Int = params["height"] as Int? ?: defaultHeight
            val width: Int = params["width"] as Int? ?: defaultWidth

            size = Size(width, height)
        }
    }
}