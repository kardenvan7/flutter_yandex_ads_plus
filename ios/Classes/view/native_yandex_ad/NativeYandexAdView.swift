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
        
        conf.parameters = buildAdditionalParameters()
        
        setAppearance()
        
        return conf
    }
    
    private func buildAdditionalParameters() -> [String: String] {
        var parameters = [
            "preferable-height": "\(arguments.height)",
            "preferable-width": "\(arguments.width)"
        ]
        
        if (arguments.additionalParameters != nil) {
            for (key, value) in arguments.additionalParameters! {
                parameters[key] = value
            }
        }
        
        return parameters
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
        eventDispatcher.sendOnAdLoadedEvent()
        ad.delegate = self
        nativeAdView.ad = ad
    }

    func nativeAdLoader(
        _ loader: YMANativeAdLoader,
        didFailLoadingWithError error: Error
    ) {
        eventDispatcher.sendOnAdFailedToLoadEvent(
            error: error
        )
    }
}

extension NativeYandexAdView: YMANativeAdDelegate {
    func nativeAdDidClick(_ ad: YMANativeAd) {
        eventDispatcher.sendOnAdClickedEvent()
    }
    
    func nativeAdWillLeaveApplication(_ ad: YMANativeAd) {
        eventDispatcher.sendLeftApplicationEvent()
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
        eventDispatcher.sendDidDismissScreenEvent()
    }
    
    func nativeAd(
        _ ad: YMANativeAd,
        willPresentScreen viewController: UIViewController?
    ) {
        eventDispatcher.sendWillPresentScreenEvent()
    }
    
    func close(_ ad: YMANativeAd) {
        eventDispatcher.sendOnAdCloseEvent()
    }
}
