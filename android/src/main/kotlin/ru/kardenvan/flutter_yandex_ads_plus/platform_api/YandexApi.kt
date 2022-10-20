package ru.kardenvan.flutter_yandex_ads_plus.platform_api

import android.content.Context
import android.util.Log
import com.yandex.mobile.ads.common.InitializationListener
import com.yandex.mobile.ads.common.MobileAds
import ru.kardenvan.flutter_yandex_ads_plus.pigeons.Yandex

class YandexApi(private val context: Context) : Yandex.YandexAdsApi {

    var callbacks = mutableMapOf<EventKey, Yandex.Result<Yandex.EventResponse>>()

    override fun initialize() {
        MobileAds.enableDebugErrorIndicator(true)
        MobileAds.enableLogging(true)
        MobileAds.initialize(context, InitializationListener {
            Log.d("FlutterYandexAdsPlus", "initialize")
        })
    }

    // dispatchers

    override fun onAdLoaded(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }

    override fun onAdFailedToLoad(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }

    override fun onImpression(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }

    override fun onAdClicked(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }

    override fun onLeftApplication(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }

    override fun onReturnedToApplication(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }

    override fun onAdShown(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }

    override fun onAdDismissed(
        request: Yandex.EventRequest?,
        result: Yandex.Result<Yandex.EventResponse>?
    ) {
        callbacks[EventKey(
            id = request?.id ?: "",
            name = request?.name ?: "",
            type = request?.type ?: ""
        )] = result!!
    }
}
