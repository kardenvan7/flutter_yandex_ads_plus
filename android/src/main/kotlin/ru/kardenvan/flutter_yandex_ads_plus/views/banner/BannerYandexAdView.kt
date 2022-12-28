package ru.kardenvan.flutter_yandex_ads_plus.views.banner

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
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.BasicAdEventDispatcher

class BannerYandexAdView(
    context: Context?,
    arguments: BannerYandexAdViewArguments,
    private val eventDispatcher: BasicAdEventDispatcher,
) : PlatformView {
    private val banner: BannerAdView = BannerAdView(context!!)
    private val viewUid: String = arguments.viewUid

    init {
        setUpAd(arguments)
        loadAd(arguments.additionalLoadParameters)
    }

    override fun getView(): View {
        return banner
    }

    private fun loadAd(additionalLoadParameters: Map<*, *>? = null) {
        val request: AdRequest = buildRequest(additionalLoadParameters)

        banner.loadAd(request)
    }

    private fun setUpAd(arguments: BannerYandexAdViewArguments) {
        setBannerId(arguments.adUid)
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

    private fun buildRequest(params: Map<*,*>?): AdRequest {
        val requestBuilder = AdRequest.Builder()

        if (params != null) {
            val paramsMap: MutableMap<String, String> = mutableMapOf()

            for (entry in params) {
                val key = entry.key
                val value = entry.value

                if (key is String && value is String) {
                    paramsMap[key] = value
                }
            }

            requestBuilder.setParameters(paramsMap)
        }

        return requestBuilder.build()
    }

    override fun dispose() {
        banner.setBannerAdEventListener(null)
    }

    private inner class BannerYandexAdEventListener: BannerAdEventListener {
        override fun onAdLoaded() {
            eventDispatcher.sendAdLoadedEvent(viewUid)
        }

        override fun onAdFailedToLoad(error: AdRequestError) {
            eventDispatcher.sendAdFailedToLoadEvent(viewUid, error)
        }

        override fun onLeftApplication() {
            eventDispatcher.sendLeftApplicationEvent(viewUid)
        }

        override fun onReturnedToApplication() {
            eventDispatcher.sendReturnedToApplicationEvent(viewUid)
        }

        override fun onImpression(data: ImpressionData?) {
            eventDispatcher.sendImpressionEvent(viewUid, data)
        }

        override fun onAdClicked() {
            eventDispatcher.sendAdClickedEvent(viewUid)
        }
    }
}