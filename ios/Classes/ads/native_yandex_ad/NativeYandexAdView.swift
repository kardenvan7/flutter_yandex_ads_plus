import UIKit
import YandexMobileAds

class NativeYandexAdView: NSObject, FlutterPlatformView {
    
    private let nativeAdView: YMANativeBannerView
    private let loader: YMANativeAdLoader
    private let arguments: NativeYandexAdViewArguments
    private let eventDispatcher: NativeAdEventDispatcherFacade
 
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        argsClass: NativeYandexAdViewArguments,
        eventDispatcher: NativeAdEventDispatcherFacade
    ) {
        self.nativeAdView = YMANativeBannerView()
        self.loader = YMANativeAdLoader()
        self.arguments = argsClass
        self.eventDispatcher = eventDispatcher
        
        super.init()
        
        loadAd()
    }

    private func loadAd() {
        loader.delegate = self

        let conf = configureAd()

        loader.loadAd(with: conf)
    }
    
    private func configureAd() -> YMAMutableNativeAdRequestConfiguration {
        let conf = YMAMutableNativeAdRequestConfiguration(
            adUnitID: arguments.adUid
        )

        if let params = arguments.parameters {
            conf.parameters = params.custom
            conf.gender = params.gender
            conf.biddingData = params.biddingData
            conf.contextQuery = params.contextQuery
            conf.contextTags = params.contextTags
            conf.location = params.location
            conf.age = params.age
        }
        
        setAppearance()
        
        return conf
    }
    
    private func setAppearance() {
        let appearance = NativeYandexAdTemplateAppearanceFactory.fromTheme(
            theme: arguments.theme
        )

        nativeAdView.apply(appearance)
    }
    
    func view() -> UIView {
        return nativeAdView
    }
}

extension NativeYandexAdView: YMANativeAdLoaderDelegate {
    func nativeAdLoader(
        _ loader: YMANativeAdLoader,
        didLoad ad: YMANativeAd
    ) {
        eventDispatcher.sendOnLoadedEvent()
        ad.delegate = self
        nativeAdView.ad = ad
    }

    func nativeAdLoader(
        _ loader: YMANativeAdLoader,
        didFailLoadingWithError error: Error
    ) {
        eventDispatcher.sendOnFailedToLoadEvent(error: error)
    }
}

extension NativeYandexAdView: YMANativeAdDelegate {
    func nativeAdDidClick(_ ad: YMANativeAd) {
        eventDispatcher.sendOnClickedEvent()
    }
    
    func nativeAdWillLeaveApplication(_ ad: YMANativeAd) {
        eventDispatcher.sendOnLeftApplicationEvent()
    }
    
    func nativeAd(
        _ ad: YMANativeAd,
        didTrackImpressionWith impressionData: YMAImpressionData?
    ) {
        eventDispatcher.sendOnImpressionEvent(
            data: impressionData?.rawData
        )
    }
    
    func nativeAd(
        _ ad: YMANativeAd,
        didDismissScreen viewController: UIViewController?
    ) {
        eventDispatcher.sendOnDidDismissScreenEvent()
    }
    
    func nativeAd(
        _ ad: YMANativeAd,
        willPresentScreen viewController: UIViewController?
    ) {
        eventDispatcher.sendOnWillPresentScreenEvent()
    }
    
    func close(_ ad: YMANativeAd) {
        eventDispatcher.sendOnCloseEvent()
    }
}
