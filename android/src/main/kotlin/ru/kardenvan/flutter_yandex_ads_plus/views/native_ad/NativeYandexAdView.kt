package ru.kardenvan.flutter_yandex_ads_plus.views.native_ad

import android.content.Context
import android.util.Log
import android.view.View
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.*
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import io.flutter.plugin.platform.PlatformView


class NativeYandexAdView(
    context: Context?,
    private val arguments: NativeAdViewArguments
) : PlatformView {
    private var nativeBannerView: NativeBannerView

    init {
        val viewContext = context!!

        nativeBannerView = NativeBannerView(viewContext)

        setAppearance()

        loadAd(viewContext)
    }

    private fun loadAd(context: Context) {
        val loader = NativeAdLoader(context)

        val parameters: HashMap<String, String> = hashMapOf(
            "preferable-height" to "${arguments.getMinSize().height}",
            "preferable-width" to "${arguments.getMinSize().width}"
        )

        val nativeAdRequestConfiguration = NativeAdRequestConfiguration.Builder(arguments.getId())
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
            Log.d("FlutterYandexAdPlus", "Ad ${arguments.getId()} loaded")
            bindNativeAd(nativeAd)
        }

        override fun onAdFailedToLoad(requetsError: AdRequestError) {
            Log.d("FlutterYandexAdPlus", "Ad ${arguments.getId()} failed to load: ${requetsError.description}")
        }
    }

    private fun bindNativeAd(nativeAd: NativeAd) {
        nativeAd.setNativeAdEventListener(NativeAdYandexAdsEventListener())

        nativeBannerView.setAd(nativeAd)
    }

    private fun setAppearance() {
        val nativeTemplateAppearance = NativeTemplateAppearanceFactory.fromTheme(arguments.getTheme())

        nativeBannerView.applyAppearance(nativeTemplateAppearance)
    }

    override fun dispose() {
        Log.d("FlutterYandexAdPlus", "Ad ${arguments.getId()} disposed")
    }

    inner class NativeAdYandexAdsEventListener: NativeAdEventListener {
        override fun onAdClicked() {
            Log.d("FlutterYandexAdPlus", "Ad ${arguments.getId()} clicked")
        }

        override fun onLeftApplication() {
            Log.d("FlutterYandexAdPlus", "Ad ${arguments.getId()} left application")
        }

        override fun onReturnedToApplication() {
            Log.d("FlutterYandexAdPlus", "Ad ${arguments.getId()} returned to application")
        }

        override fun onImpression(impression: ImpressionData?) {
            Log.d("FlutterYandexAdPlus", "Ad ${arguments.getId()} impression: $impression")
        }
    }
}
