import UIKit
import YandexMobileAds

class NativeYandexAdView: NSObject, FlutterPlatformView {
    
    private let nativeAdView: YMANativeBannerView!
    private let loader: YMANativeAdLoader!
    private let api: YandexApi!
    private let id: String!
    private let theme: NativeAdViewTheme!
    private let height: Int
    private let width: Int
 
    init(
        frame: CGRect, viewIdentifier viewId: Int64,
        arguments args: Any?, api: YandexApi?,
        argsClass: NativeAdViewArguments
    ) {
        self.id = argsClass.id
        self.theme = argsClass.theme
        self.height = argsClass.height
        self.width = argsClass.width
        self.api = api
        self.nativeAdView = YMANativeBannerView()
        self.loader = YMANativeAdLoader()
        
        super.init()
        
        loadAd()
    }

    func loadAd() {
        loader.delegate = self

        let conf = YMAMutableNativeAdRequestConfiguration(
            adUnitID: id
        )

        conf.parameters = [
            "preferable-height": "\(height)",
            "preferable-width": "\(width)"
        ]
        
        setAppearance()
        loader.loadAd(with: conf)
    }
    
    func setAppearance() {
        let appearance = NativeAdTemplateAppearanceFactory.fromTheme(
            theme: theme
        )

        nativeAdView.apply(appearance)
    }
    
    func view() -> UIView {
        return nativeAdView
    }
}

extension NativeYandexAdView: YMANativeAdDelegate {

}

extension NativeYandexAdView: YMANativeAdLoaderDelegate {
    func nativeAdLoader(
        _ loader: YMANativeAdLoader,
        didLoad ad: YMANativeAd
    ) {
            print("Ad " + self.id + " loaded")
            ad.delegate = self
            nativeAdView.ad = ad
    }

    func nativeAdLoader(
        _ loader: YMANativeAdLoader,
        didFailLoadingWithError error: Error
    ) {
        print("Native ad loading error: \(error)")
    }
}
