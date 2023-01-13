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
    private val eventDispatcher: InterstitialAdEventDispatcherFacade,
) {
    private val ad: InterstitialAd = InterstitialAd(context)

    init {
        ad.setAdUnitId(adId)
    }

    fun loadAndShowAd(parameters: AdParameters?) {
        setUpListener()
        loadAd(parameters)
    }

    private fun loadAd(parameters: AdParameters?) {
        val request = buildRequest(parameters)

        ad.loadAd(request)
    }

    private fun buildRequest(parameters: AdParameters?): AdRequest {
        return AdRequestFacade.buildWithParameters(parameters)
    }

    private fun setUpListener() {
        ad.setInterstitialAdEventListener(InterstitialAdActivityEventListener())
    }

    private inner class InterstitialAdActivityEventListener: InterstitialAdEventListener {
        override fun onAdLoaded() {
            ad.show()
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