package ru.kardenvan.flutter_yandex_ads_plus.views.banner

import android.content.Context
import android.graphics.Color
import android.util.Size
import android.view.View
import com.yandex.mobile.ads.banner.AdSize
import com.yandex.mobile.ads.banner.BannerAdView
import com.yandex.mobile.ads.common.AdRequest
import io.flutter.plugin.platform.PlatformView
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.PlatformApi
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.YandexApi

class BannerYandexAdView(
    context: Context?,
    arguments: BannerAdViewArguments,
    api: YandexApi,
) : PlatformView {
    private val banner: BannerAdView

    init {
        banner = BannerAdView(context!!)
        banner.setAdSize(AdSize.flexibleSize(arguments.getSize().width, arguments.getSize().height))
        banner.setBackgroundColor(Color.TRANSPARENT)
        banner.setAdUnitId(arguments.getId())
        banner.setBannerAdEventListener(BannerYandexAdEventListener(api = api, id = arguments.getId()))

        val request: AdRequest = AdRequest.Builder().build()
        banner.loadAd(request)
    }

    override fun getView(): View {
        return banner
    }

    override fun dispose() {}
}