package ru.kardenvan.flutter_yandex_ads_plus.ads.interstitial_yandex_ad

import android.content.Context
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.interstitial.InterstitialAd
import com.yandex.mobile.ads.interstitial.InterstitialAdEventListener
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.InterstitialAdEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.utils.AdRequestFacade

class InterstitialYandexAd(
    context: Context,
    private val adUid: String,
    private val eventDispatcher: InterstitialAdEventDispatcher,
) {
    private val ad: InterstitialAd = InterstitialAd(context)

    init {
        ad.setAdUnitId(adUid)
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
            eventDispatcher.sendAdLoadedEvent(adUid)
        }

        override fun onAdFailedToLoad(error: AdRequestError) {
            eventDispatcher.sendAdFailedToLoadEvent(adUid, error)
        }

        override fun onAdClicked() {
            eventDispatcher.sendAdClickedEvent(adUid)
        }

        override fun onLeftApplication() {
            eventDispatcher.sendLeftApplicationEvent(adUid)
        }

        override fun onReturnedToApplication() {
            eventDispatcher.sendReturnedToApplicationEvent(adUid)
        }

        override fun onImpression(impressionData: ImpressionData?) {
            eventDispatcher.sendImpressionEvent(adUid, impressionData)
        }

        override fun onAdShown() {
            eventDispatcher.sendAdShownEvent(adUid)
        }

        override fun onAdDismissed() {
            eventDispatcher.sendAdDismissedEvent(adUid)
        }
    }
}