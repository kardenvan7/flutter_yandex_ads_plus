package ru.kardenvan.flutter_yandex_ads_plus.views.native_yandex_ad

import android.content.Context
import android.view.View
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.*
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import io.flutter.plugin.platform.PlatformView
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher.BasicAdEventDispatcher


class NativeYandexAdView(
    context: Context?,
    arguments: NativeYandexAdViewArguments,
    private val eventDispatcher: BasicAdEventDispatcher,
) : PlatformView {
    private val nativeBannerView: NativeBannerView = NativeBannerView(context!!)
    private var nativeAd: NativeAd? = null

    private val viewUid = arguments.viewUid

    override fun getView(): View {
        return nativeBannerView
    }

    init {
        configureAndLoadAd(context!!, arguments)
    }

    private fun configureAndLoadAd(context: Context, arguments: NativeYandexAdViewArguments) {
        val configuration = configureAd(arguments)

        loadAd(context, configuration)
    }

    private fun setAppearance(theme: NativeYandexAdViewTheme) {
        val nativeTemplateAppearance = NativeYandexAdTemplateAppearanceFactory.fromTheme(theme)

        nativeBannerView.applyAppearance(nativeTemplateAppearance)
    }

    private fun loadAd(context: Context, configuration: NativeAdRequestConfiguration) {
        val loader = NativeAdLoader(context)

        loader.setNativeAdLoadListener(NativeYandexAdEventListener())
        loader.loadAd(configuration)
    }

    private fun configureAd(
        arguments: NativeYandexAdViewArguments
    ): NativeAdRequestConfiguration {
        setAppearance(arguments.theme)

        val parameters: HashMap<String, String> = hashMapOf(
            "preferable-height" to "${arguments.minSize.height}",
            "preferable-width" to "${arguments.minSize.width}"
        )

        val additionalParams = arguments.additionalParams

        if (additionalParams != null) {
            for (arg in additionalParams.iterator()) {
                val key = arg.key
                val value = arg.value

                if (key is String && value is String) {
                    parameters[key] = value
                }
            }
        }

        return NativeAdRequestConfiguration.Builder(arguments.adId)
            .setShouldLoadImagesAutomatically(true)
            .setParameters(parameters)
            .build()
    }

    private inner class NativeYandexAdEventListener : NativeAdLoadListener {
        override fun onAdLoaded(ad: NativeAd) {
            eventDispatcher.sendAdLoadedEvent(viewUid)

            bindNativeAd(ad)
        }

        override fun onAdFailedToLoad(requetsError: AdRequestError) {
            eventDispatcher.sendAdFailedToLoadEvent(viewUid, requetsError)
        }

        private fun bindNativeAd(ad: NativeAd) {
            nativeAd = ad
            ad.setNativeAdEventListener(NativeAdYandexAdsEventListener())

            nativeBannerView.setAd(ad)
        }
    }

    private inner class NativeAdYandexAdsEventListener: NativeAdEventListener {
        override fun onAdClicked() {
            eventDispatcher.sendAdClickedEvent(viewUid)
        }

        override fun onLeftApplication() {
            eventDispatcher.sendLeftApplicationEvent(viewUid)
        }

        override fun onReturnedToApplication() {
            eventDispatcher.sendReturnedToApplicationEvent(viewUid)
        }

        override fun onImpression(impression: ImpressionData?) {
            eventDispatcher.sendImpressionEvent(viewUid, impression)
        }
    }

    override fun dispose() {
        nativeAd?.setNativeAdEventListener(null)
    }
}
