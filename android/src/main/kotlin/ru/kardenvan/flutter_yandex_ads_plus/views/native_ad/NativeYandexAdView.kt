package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.content.Context
import android.util.Log
import android.view.View
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.*
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import io.flutter.plugin.platform.PlatformView
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.NativeAdViewTheme


class NativeYandexAdView(
    context: Context?,
    width: Int,
    height: Int,
    private val id: String,
    private val theme: NativeAdViewTheme
) : PlatformView {
    private var nativeBannerView: NativeBannerView

    init {
        val viewContext = context!!

        nativeBannerView = NativeBannerView(viewContext)

        setAppearance()

        loadAd(viewContext, width, height)
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
            Log.d("FlutterYandexAdPlus", "Ad $id loaded")
            bindNativeAd(nativeAd)
        }

        override fun onAdFailedToLoad(requetsError: AdRequestError) {
            Log.d("FlutterYandexAdPlus", "Ad $id failed to load: ${requetsError.description}")
        }
    }

    private fun bindNativeAd(nativeAd: NativeAd) {
        nativeAd.setNativeAdEventListener(NativeAdYandexAdsEventListener(id = id))

        nativeBannerView.setAd(nativeAd)
    }

    private fun setAppearance() {
        val nativeTemplateAppearance = NativeTemplateAppearanceFactory.fromTheme(theme)

        nativeBannerView.applyAppearance(nativeTemplateAppearance)
    }

    override fun dispose() {
        Log.d("FlutterYandexAdPlus", "Ad $id disposed")
    }
}

class NativeAdYandexAdsEventListener(private val id: String): NativeAdEventListener {

    override fun onAdClicked() {
       Log.d("FlutterYandexAdPlus", "Ad $id clicked")
    }

    override fun onLeftApplication() {
        Log.d("FlutterYandexAdPlus", "Ad $id left application")
    }

    override fun onReturnedToApplication() {
        Log.d("FlutterYandexAdPlus", "Ad $id returned to application")
    }

    override fun onImpression(impression: ImpressionData?) {
        Log.d("FlutterYandexAdPlus", "Ad $id impression: $impression")
    }

}
