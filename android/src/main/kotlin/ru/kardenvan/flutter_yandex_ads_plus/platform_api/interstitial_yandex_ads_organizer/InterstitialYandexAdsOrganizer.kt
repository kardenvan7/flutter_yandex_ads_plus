package ru.kardenvan.flutter_yandex_ads_plus.platform_api.interstitial_yandex_ads_organizer

import android.content.Context
import ru.kardenvan.flutter_yandex_ads_plus.ads.interstitial_yandex_ad.InterstitialYandexAd
import ru.kardenvan.flutter_yandex_ads_plus.ads.interstitial_yandex_ad.InterstitialYandexAdArguments
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade.InterstitialAdEventDispatcherFacade

class InterstitialYandexAdsOrganizer(
    private val eventDispatcher: FlutterYandexAdsEventDispatcher,
) {
    private val ads: MutableMap<String, InterstitialYandexAd> = mutableMapOf()

    fun createAndLoadAd(
        context: Context,
        arguments: InterstitialYandexAdArguments,
    ) {
        val key = arguments.uid

        removeAdIfExists(key)

        val ad = createAd(context, arguments)

        ads[key] = ad

        ad.load(
            arguments.parameters,
            eventDispatcher = InterstitialAdEventDispatcherFacade(
                arguments.uid,
                eventDispatcher
            )
        )
    }

    fun showAd(uid: String) {
        val ad = ads[uid] ?: throw Exception("Can not show ad. It has to be loaded first")

        ad.show()
    }

    fun removeAd(uid: String) {
        removeAdIfExists(uid)
    }

    private fun createAd(
        context: Context,
        arguments: InterstitialYandexAdArguments,
    ): InterstitialYandexAd {
        return InterstitialYandexAd(
            context = context,
            adId = arguments.adId,
        )
    }

    private fun removeAdIfExists(key: String) {
        val existingAd = ads[key] ?: return

        existingAd.destroy()
        ads.remove(key)
    }
}