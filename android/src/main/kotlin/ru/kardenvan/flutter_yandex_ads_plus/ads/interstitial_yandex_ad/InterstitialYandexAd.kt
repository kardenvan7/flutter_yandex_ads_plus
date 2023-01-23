package ru.kardenvan.flutter_yandex_ads_plus.ads.interstitial_yandex_ad

import android.content.Context
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.interstitial.InterstitialAd
import com.yandex.mobile.ads.interstitial.InterstitialAdEventListener
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade.InterstitialAdEventDispatcherFacade
import ru.kardenvan.flutter_yandex_ads_plus.utils.AdRequestFacade

class InterstitialYandexAd(
    context: Context,
    adId: String,
) {
    private val ad: InterstitialAd = InterstitialAd(context)

    init {
        ad.setAdUnitId(adId)
    }

    fun load(parameters: AdParameters?, eventDispatcher: InterstitialAdEventDispatcherFacade) {
        setUpListener(eventDispatcher)
        buildRequestAndLoadAd(parameters)
    }

    fun show() {
        if (!ad.isLoaded) throw Exception("Ad can not be shown. It should be loaded first.")

        ad.show()
    }

    fun destroy() {
        ad.setInterstitialAdEventListener(null)
        ad.destroy()
    }

    private fun buildRequestAndLoadAd(parameters: AdParameters?) {
        val request = buildRequest(parameters)

        ad.loadAd(request)
    }

    private fun buildRequest(parameters: AdParameters?): AdRequest {
        return AdRequestFacade.buildWithParameters(parameters)
    }

    private fun setUpListener(eventDispatcher: InterstitialAdEventDispatcherFacade) {
        ad.setInterstitialAdEventListener(
            InterstitialAdActivityEventListener(eventDispatcher)
        )
    }

    private class InterstitialAdActivityEventListener(
        private val eventDispatcher: InterstitialAdEventDispatcherFacade,
    ): InterstitialAdEventListener {
        override fun onAdLoaded() {
            eventDispatcher.sendAdLoadedEvent()
        }

        override fun onAdFailedToLoad(error: AdRequestError) {
            eventDispatcher.sendAdFailedToLoadEvent(error)
        }

        override fun onAdClicked() {
            eventDispatcher.sendAdClickedEvent()
        }

        override fun onLeftApplication() {
            eventDispatcher.sendLeftApplicationEvent()
        }

        override fun onReturnedToApplication() {
            eventDispatcher.sendReturnedToApplicationEvent()
        }

        override fun onImpression(impressionData: ImpressionData?) {
            eventDispatcher.sendImpressionEvent(impressionData)
        }

        override fun onAdShown() {
            eventDispatcher.sendAdShownEvent()
        }

        override fun onAdDismissed() {
            eventDispatcher.sendAdDismissedEvent()
        }
    }
}