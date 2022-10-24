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

class BannerYandexAdView(
    context: Context?,
    id: String,
    size: Size,
    listener: BannerYandexAdEventListener
) :
    PlatformView {
    private val banner: BannerAdView

    init {
        banner = BannerAdView(context!!)
        banner.setAdSize(AdSize.flexibleSize(size.width, size.height))
        banner.setBackgroundColor(Color.TRANSPARENT)
        banner.setAdUnitId(id)
        banner.setBannerAdEventListener(listener)

        val request: AdRequest = AdRequest.Builder().build()
        banner.loadAd(request)
    }

    override fun getView(): View {
        return banner
    }

    override fun dispose() {}
}