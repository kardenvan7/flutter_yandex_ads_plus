package ru.kardenvan.flutter_yandex_ads_plus.ads.rewarded_yandex_ad

import android.content.Context
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.rewarded.Reward
import com.yandex.mobile.ads.rewarded.RewardedAd
import com.yandex.mobile.ads.rewarded.RewardedAdEventListener
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade.RewardedAdEventDispatcherFacade
import ru.kardenvan.flutter_yandex_ads_plus.utils.AdRequestFacade

class RewardedYandexAd(
    context: Context,
    adId: String,
) {
    private val ad: RewardedAd = RewardedAd(context)

    init {
        ad.setAdUnitId(adId)
    }

    fun load(parameters: AdParameters?, eventDispatcher: RewardedAdEventDispatcherFacade) {
        setUpListener(eventDispatcher)
        buildRequestAndLoadAd(parameters)
    }

    fun show() {
        if (!ad.isLoaded) throw Exception("Ad can not be shown. It should be loaded first.")

        ad.show()
    }

    fun destroy() {
        ad.setRewardedAdEventListener(null)
        ad.destroy()
    }

    private fun buildRequestAndLoadAd(parameters: AdParameters?) {
        val request = buildRequest(parameters)

        ad.loadAd(request)
    }

    private fun buildRequest(parameters: AdParameters?): AdRequest {
        return AdRequestFacade.buildWithParameters(parameters)
    }

    private fun setUpListener(eventDispatcher: RewardedAdEventDispatcherFacade) {
        ad.setRewardedAdEventListener(
            RewardedAdActivityEventListener(eventDispatcher)
        )
    }

    private class RewardedAdActivityEventListener(
        private val eventDispatcher: RewardedAdEventDispatcherFacade,
    ): RewardedAdEventListener {
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

        override fun onRewarded(reward: Reward) {
            eventDispatcher.sendOnRewardedEvent(reward)
        }
    }
}