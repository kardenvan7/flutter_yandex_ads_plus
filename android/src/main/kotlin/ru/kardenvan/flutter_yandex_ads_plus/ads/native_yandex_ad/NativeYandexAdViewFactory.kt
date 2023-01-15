package ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade.BasicAdEventDispatcherFacade
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.model_factories.NativeAdViewArgumentsFactory

class NativeYandexAdViewFactory constructor(
    private val eventDispatcher: FlutterYandexAdsEventDispatcher
): PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        if (args !is Map<*, *>) {
            throw Exception("Arguments is not map. Given arguments: $args")
        }

        val argsClass = NativeAdViewArgumentsFactory.fromMap(args)

        return NativeYandexAdView(
            context = context,
            arguments = argsClass,
            eventDispatcher = BasicAdEventDispatcherFacade(argsClass.viewUid, eventDispatcher),
        )
    }
}