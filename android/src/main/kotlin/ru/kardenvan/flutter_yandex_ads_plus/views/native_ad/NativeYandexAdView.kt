package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.content.Context
import android.graphics.Color
import android.util.Log
import android.view.View
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.*
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import com.yandex.mobile.ads.nativeads.template.appearance.NativeTemplateAppearance
import com.yandex.mobile.ads.nativeads.template.appearance.TextAppearance
import io.flutter.plugin.platform.PlatformView


class NativeYandexAdView(
    context: Context?,
    private val id: String,
    width: Int,
    height: Int
) : PlatformView {
    private var nativeBannerView: NativeBannerView

    init {
        val viewContext = context!!

        nativeBannerView = NativeBannerView(viewContext)

        setAppearance()
        loadAd(viewContext, width, height)
    }

    private fun setAppearance() {
        val nativeTemplateAppearance = NativeTemplateAppearance.Builder()
            .withTitleAppearance(TextAppearance.Builder().setTextColor(Color.BLACK).build())
            .withBodyAppearance(TextAppearance.Builder().setTextColor(Color.BLACK).build())
            .build()

        nativeBannerView.applyAppearance(nativeTemplateAppearance)
    }

    private fun loadAd(context: Context, width: Int, height: Int) {
        val loader = NativeAdLoader(context)

        val parameters: HashMap<String, String> = hashMapOf(
            "preferable-height" to "$height",
            "preferable-width" to "$width"
        )

        val nativeAdRequestConfiguration = NativeAdRequestConfiguration.Builder(id)
            .setShouldLoadImagesAutomatically(true)
            .setParameters(parameters)
            .build()

        loader.setNativeAdLoadListener(NativeYandexAdEventListener())
        loader.loadAd(nativeAdRequestConfiguration)
    }

    override fun getView(): View {
        return nativeBannerView
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

        nativeBannerView.setAd(nativeAd)
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