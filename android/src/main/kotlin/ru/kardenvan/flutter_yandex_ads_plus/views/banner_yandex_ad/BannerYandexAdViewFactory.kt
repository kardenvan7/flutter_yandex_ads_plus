package ru.kardenvan.flutter_yandex_ads_plus.views.banner_yandex_ad

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.BasicAdEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories.BannerAdViewArgumentsFactory

class BannerYandexAdViewFactory(private val eventDispatcher: BasicAdEventDispatcher) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        if (args !is Map<*, *>) {
            throw Exception("Arguments parameter is not a Map. Args: $args")
        }

        val arguments = BannerAdViewArgumentsFactory.fromMap(args)

        return BannerYandexAdView(context, arguments, eventDispatcher)
    }
}