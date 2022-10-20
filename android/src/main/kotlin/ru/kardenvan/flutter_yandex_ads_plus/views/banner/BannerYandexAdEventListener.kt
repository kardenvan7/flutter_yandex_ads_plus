package ru.kardenvan.flutter_yandex_ads_plus.views.banner

import com.yandex.mobile.ads.banner.BannerAdEventListener
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import ru.kardenvan.flutter_yandex_ads_plus.pigeons.Yandex
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.EventKey
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.EventType
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.YandexApi

class BannerYandexAdEventListener(private val api: YandexApi, private val id: String) :
    BannerAdEventListener {

    override fun onAdLoaded() {
        val builder = Yandex.EventResponse.Builder()

        val response = builder.build()
        api.callbacks.remove(EventKey(id = id, name = "onAdLoaded", type = EventType.BANNER.type))
            ?.success(response)
    }

    override fun onAdFailedToLoad(error: AdRequestError) {
        val builder = Yandex.EventResponse.Builder()
        builder.setCode(error.code.toLong())
        builder.setDescription(error.description)

        val response = builder.build()
        api.callbacks.remove(
            EventKey(
                id = id,
                name = "onAdFailedToLoad",
                type = EventType.BANNER.type
            )
        )?.success(response)
    }

    override fun onLeftApplication() {
        val builder = Yandex.EventResponse.Builder()

        val response = builder.build()
        api.callbacks.remove(
            EventKey(
                id = id,
                name = "onLeftApplication",
                type = EventType.BANNER.type
            )
        )?.success(response)
    }

    override fun onReturnedToApplication() {
        val builder = Yandex.EventResponse.Builder()

        val response = builder.build()
        api.callbacks.remove(
            EventKey(
                id = id,
                name = "onReturnedToApplication",
                type = EventType.BANNER.type
            )
        )?.success(response)
    }

    override fun onImpression(data: ImpressionData?) {
        val builder = Yandex.EventResponse.Builder()
        builder.setData(data?.rawData ?: "")

        val response = builder.build()
        api.callbacks.remove(EventKey(id = id, name = "onImpression", type = EventType.BANNER.type))
            ?.success(response)
    }

    override fun onAdClicked() {
        val builder = Yandex.EventResponse.Builder()

        val response = builder.build()
        api.callbacks.remove(EventKey(id = id, name = "onAdClicked", type = EventType.BANNER.type))
            ?.success(response)
    }
}