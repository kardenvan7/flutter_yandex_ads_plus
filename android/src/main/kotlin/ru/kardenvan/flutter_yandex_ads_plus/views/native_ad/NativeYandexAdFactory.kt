package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.content.Context
import com.yandex.mobile.ads.nativeads.template.appearance.BannerAppearance
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.NativeAdViewTheme
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.PlatformApi

class NativeYandexAdFactory: PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val argsClass = PlatformApi.NativeAdViewArguments.fromMap(args)

        return NativeYandexAdView(
            context = context,
            id = argsClass.getId(),
            width = argsClass.getMinSize().width,
            height = argsClass.getMinSize().height,
            theme = argsClass.getTheme()
        )
    }
}
