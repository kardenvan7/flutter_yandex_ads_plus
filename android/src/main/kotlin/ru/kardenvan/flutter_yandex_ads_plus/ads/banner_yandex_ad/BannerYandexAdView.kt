package ru.kardenvan.flutter_yandex_ads_plus.ads.banner_yandex_ad

import android.content.Context
import android.graphics.Color
import android.util.Size
import android.view.View
import com.yandex.mobile.ads.banner.AdSize
import com.yandex.mobile.ads.banner.BannerAdEventListener
import com.yandex.mobile.ads.banner.BannerAdView
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import io.flutter.plugin.platform.PlatformView
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade.BasicAdEventDispatcherFacade
import ru.kardenvan.flutter_yandex_ads_plus.utils.AdRequestFacade

class BannerYandexAdView(
    context: Context?,
    arguments: BannerYandexAdViewArguments,
    private val eventDispatcher: BasicAdEventDispatcherFacade,
) : PlatformView {
    private val banner: BannerAdView = BannerAdView(context!!)

    init {
        setUpAd(arguments)
        loadAd(arguments.parameters)
    }

    override fun getView(): View {
        return banner
    }

    private fun loadAd(parameters: AdParameters?) {
        val request: AdRequest = buildRequest(parameters)

        banner.loadAd(request)
    }

    private fun setUpAd(arguments: BannerYandexAdViewArguments) {
        setBannerId(arguments.adId)
        setBannerSize(arguments.size)
        setBannerAppearance()
        setBannerEventListener()
    }

    private fun setBannerEventListener() {
        banner.setBannerAdEventListener(BannerYandexAdEventListener())
    }

    private fun setBannerId(id: String) {
        banner.setAdUnitId(id)
    }

    private fun setBannerSize(size: Size) {
        banner.setAdSize(AdSize.flexibleSize(size.width, size.height))
    }

    private fun setBannerAppearance() {
        banner.setBackgroundColor(Color.TRANSPARENT)
    }

    private fun buildRequest(parameters: AdParameters?): AdRequest {
        return AdRequestFacade.buildWithParameters(parameters)
    }

    override fun dispose() {
        banner.setBannerAdEventListener(null)
    }

    private inner class BannerYandexAdEventListener: BannerAdEventListener {
        override fun onAdLoaded() {
            eventDispatcher.sendAdLoadedEvent()
        }

        override fun onAdFailedToLoad(error: AdRequestError) {
            eventDispatcher.sendAdFailedToLoadEvent(error)
        }

        override fun onLeftApplication() {
            eventDispatcher.sendLeftApplicationEvent()
        }

        override fun onReturnedToApplication() {
            eventDispatcher.sendReturnedToApplicationEvent()
        }

        override fun onImpression(data: ImpressionData?) {
            eventDispatcher.sendImpressionEvent(data)
        }

        override fun onAdClicked() {
            eventDispatcher.sendAdClickedEvent()
        }
    }
}