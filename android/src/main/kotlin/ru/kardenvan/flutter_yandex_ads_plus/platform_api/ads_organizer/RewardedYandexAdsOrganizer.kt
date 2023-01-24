package ru.kardenvan.flutter_yandex_ads_plus.platform_api.ads_organizer

import android.content.Context
import ru.kardenvan.flutter_yandex_ads_plus.ads.rewarded_yandex_ad.RewardedYandexAd
import ru.kardenvan.flutter_yandex_ads_plus.ads.rewarded_yandex_ad.RewardedYandexAdArguments
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.FlutterYandexAdsEventDispatcher
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade.RewardedAdEventDispatcherFacade

class RewardedYandexAdsOrganizer(
    private val eventDispatcher: FlutterYandexAdsEventDispatcher,
) {
    private val ads: MutableMap<String, RewardedYandexAd> = mutableMapOf()

    fun createAndLoadAd(
        context: Context,
        arguments: RewardedYandexAdArguments,
    ) {
        val key = arguments.uid

        removeAdIfExists(key)

        val ad = createAd(context, arguments)

        ads[key] = ad

        ad.load(
            arguments.parameters,
            eventDispatcher = RewardedAdEventDispatcherFacade(
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
        arguments: RewardedYandexAdArguments,
    ): RewardedYandexAd {
        return RewardedYandexAd(
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