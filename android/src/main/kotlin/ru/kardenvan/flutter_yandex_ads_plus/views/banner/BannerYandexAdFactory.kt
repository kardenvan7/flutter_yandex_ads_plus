package ru.kardenvan.flutter_yandex_ads_plus.views.banner

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.PlatformApi
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.YandexApi

class BannerYandexAdFactory(private val api: YandexApi) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val arguments = PlatformApi.BannerAdViewArguments(args)
        val id = arguments.getBannerId()

        return BannerYandexAdView(
            context,
            id,
            arguments.getBannerSize(),
            BannerYandexAdEventListener(api = api, id = id)
        )
    }
}
