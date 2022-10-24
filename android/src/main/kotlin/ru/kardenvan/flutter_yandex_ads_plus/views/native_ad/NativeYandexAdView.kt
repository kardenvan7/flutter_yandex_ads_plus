package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.content.Context
import android.util.Log
import android.util.Size
import android.view.View
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.NativeAd
import com.yandex.mobile.ads.nativeads.NativeAdEventListener
import com.yandex.mobile.ads.nativeads.NativeAdLoadListener
import com.yandex.mobile.ads.nativeads.NativeAdLoader
import com.yandex.mobile.ads.nativeads.NativeAdRequestConfiguration
import com.yandex.mobile.ads.nativeads.NativeAdView
import com.yandex.mobile.ads.nativeads.NativeAdViewBinder
import io.flutter.plugin.platform.PlatformView

class NativeYandexAdView(context: Context?, adId: String, minSize: Size) : PlatformView {
    private var nativeAdView: NativeAdView
    private var id: String

    init {
        val viewContext = context!!
        nativeAdView = NativeAdView(viewContext)
        id = adId

        val loader = NativeAdLoader(viewContext)

        val nativeAdRequestConfiguration = NativeAdRequestConfiguration.Builder(id)
            .setShouldLoadImagesAutomatically(true)
            .build()

        loader.setNativeAdLoadListener(NativeYandexAdEventListener())
        loader.loadAd(nativeAdRequestConfiguration)
    }

    override fun getView(): View {
        return nativeAdView;
    }

    private inner class NativeYandexAdEventListener: NativeAdLoadListener {
        override fun onAdLoaded(nativeAd: NativeAd) {
            Log.d("Flutter Yandex Ad Plus", "Ad $id loaded")
            bindNativeAd(nativeAd)
        }

        override fun onAdFailedToLoad(requetsError: AdRequestError) {
            Log.d("Flutter Yandex Ad Plus", "Ad $id failed to load: ${requetsError.description}")
        }
    }

    private fun bindNativeAd(nativeAd: NativeAd) {
        nativeAd.setNativeAdEventListener(NativeAdYandexAdsEventListener(id = id))

        val binder = NativeAdViewBinder.Builder(nativeAdView)
            .build()

        nativeAd.bindNativeAd(binder)
    }

    override fun dispose() {
        Log.d("Flutter Yandex Ad Plus", "Ad $id disposed")
    }
}

class NativeAdYandexAdsEventListener(private val id: String): NativeAdEventListener {

    override fun onAdClicked() {
       Log.d("Flutter Yandex Ad Plus", "Ad $id clicked")
    }

    override fun onLeftApplication() {
        Log.d("Flutter Yandex Ad Plus", "Ad $id left application")
    }

    override fun onReturnedToApplication() {
        Log.d("Flutter Yandex Ad Plus", "Ad $id returned to application")
    }

    override fun onImpression(impression: ImpressionData?) {
        Log.d("Flutter Yandex Ad Plus", "Ad $id impression: $impression")
    }

}