package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.PlatformApi

class NativeYandexAdFactory: PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        if (args !is Map<*, *>) {
            throw Exception("Arguments is not map. Given arguments: $args")
        }

        val argsClass = PlatformApi.NativeAdViewArgumentsFactory.fromMap(args)

        return NativeYandexAdView(
            context = context,
            arguments = argsClass,
        )
    }
}
