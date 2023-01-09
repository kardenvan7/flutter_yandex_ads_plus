package ru.kardenvan.flutter_yandex_ads_plus.activities.interstitial

import android.app.Activity
import android.os.Bundle
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.interstitial.InterstitialAd
import com.yandex.mobile.ads.interstitial.InterstitialAdEventListener
import ru.kardenvan.flutter_yandex_ads_plus.utils.PluginLogger

class InterstitialAdActivity: Activity() {
    private val ad = InterstitialAd(this)
    private lateinit var adUid: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val bundle = savedInstanceState!!

        val adId = bundle.getString("ad_uid")

        if (adId !is String) throw Exception("Ad id can not be null!")

        adUid = adId

        ad.setAdUnitId(adUid)

        val request = AdRequest.Builder().build()

        ad.setInterstitialAdEventListener(InterstitialAdActivityEventListener())

        ad.loadAd(request)
    }

    private inner class InterstitialAdActivityEventListener: InterstitialAdEventListener {
        override fun onAdLoaded() {
            PluginLogger.log("Interstitial ad $adUid loaded")
        }

        override fun onAdFailedToLoad(p0: AdRequestError) {
            PluginLogger.log("Interstitial ad $adUid failed to load: ${p0.description}")
        }

        override fun onAdShown() {
            PluginLogger.log("Interstitial ad $adUid shown")
        }

        override fun onAdDismissed() {
            PluginLogger.log("Interstitial ad $adUid dismissed")
        }

        override fun onAdClicked() {
            PluginLogger.log("Interstitial ad $adUid clicked")
        }

        override fun onLeftApplication() {
            PluginLogger.log("Interstitial ad $adUid left application")
        }

        override fun onReturnedToApplication() {
            PluginLogger.log("Interstitial ad $adUid returned to application")
        }

        override fun onImpression(p0: ImpressionData?) {
            PluginLogger.log("Interstitial ad $adUid impression: ${p0?.rawData}")
        }
    }
}