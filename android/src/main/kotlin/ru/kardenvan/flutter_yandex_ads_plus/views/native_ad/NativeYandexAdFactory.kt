package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.PlatformApi

class NativeYandexAdFactory: PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val argsClassBuilder = PlatformApi.NativeAdViewArguments.Builder()
        val argsClass = argsClassBuilder.buildFromMap(args)

        return NativeYandexAdView(context, argsClass.getId()!!)
    }
}
