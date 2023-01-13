package ru.kardenvan.flutter_yandex_ads_plus.ads.native_yandex_ad

import android.content.Context
import android.util.Size
import android.view.View
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.*
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import io.flutter.plugin.platform.PlatformView
import ru.kardenvan.flutter_yandex_ads_plus.ads.AdParameters
import ru.kardenvan.flutter_yandex_ads_plus.platform_api.ad_event_dispatcher_facade.BasicAdEventDispatcherFacade


class NativeYandexAdView(
    context: Context?,
    arguments: NativeYandexAdViewArguments,
    private val eventDispatcher: BasicAdEventDispatcherFacade,
) : PlatformView {
    private val nativeBannerView: NativeBannerView = NativeBannerView(context!!)
    private var nativeAd: NativeAd? = null

    init {
        configureAndLoadAd(context!!, arguments)
    }

    override fun getView(): View {
        return nativeBannerView
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

        return buildRequest(arguments.adId, arguments.minSize, arguments.parameters)
    }

    private fun buildRequest(adId: String, size: Size, parameters: AdParameters?): NativeAdRequestConfiguration {
        val confBuilder = NativeAdRequestConfiguration.Builder(adId)
        val sizeParams: Map<String, String> = mapOf(
            "preferable-height" to "${size.height}",
            "preferable-width" to "${size.width}"
        )
        var finalParameters = sizeParams

        if (parameters != null) {
            confBuilder.apply {
                setShouldLoadImagesAutomatically(true)

                if (parameters.custom != null) {
                    finalParameters = sizeParams + parameters.custom
                }

                if (parameters.age != null) {
                    setAge(parameters.age)
                }

                if (parameters.biddingData != null) {
                    setBiddingData(parameters.biddingData)
                }

                if (parameters.contextQuery != null) {
                    setContextQuery(parameters.contextQuery)
                }

                if (parameters.contextTags != null) {
                    setContextTags(parameters.contextTags)
                }

                if (parameters.gender != null) {
                    setGender(parameters.gender)
                }

                if (parameters.location != null) {
                    setLocation(parameters.location)
                }

                if (parameters.preferredTheme != null) {
                    setPreferredTheme(parameters.preferredTheme)
                }
            }
        }

        return confBuilder
            .setParameters(finalParameters)
            .build()
    }

    private inner class NativeYandexAdEventListener : NativeAdLoadListener {
        override fun onAdLoaded(ad: NativeAd) {
            eventDispatcher.sendAdLoadedEvent()

            bindNativeAd(ad)
        }

        override fun onAdFailedToLoad(requetsError: AdRequestError) {
            eventDispatcher.sendAdFailedToLoadEvent(requetsError)
        }

        private fun bindNativeAd(ad: NativeAd) {
            nativeAd = ad
            ad.setNativeAdEventListener(NativeAdYandexAdsEventListener())

            nativeBannerView.setAd(ad)
        }
    }

    private inner class NativeAdYandexAdsEventListener: NativeAdEventListener {
        override fun onAdClicked() {
            eventDispatcher.sendAdClickedEvent()
        }

        override fun onLeftApplication() {
            eventDispatcher.sendLeftApplicationEvent()
        }

        override fun onReturnedToApplication() {
            eventDispatcher.sendReturnedToApplicationEvent()
        }

        override fun onImpression(impression: ImpressionData?) {
            eventDispatcher.sendImpressionEvent(impression)
        }
    }

    override fun dispose() {
        nativeAd?.setNativeAdEventListener(null)
    }
}
