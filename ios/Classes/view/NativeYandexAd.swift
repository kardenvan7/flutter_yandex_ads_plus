import Flutter
import UIKit
import YandexMobileAds

class NativeYandexAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private var api: YandexApi

    init(api: YandexApi) {
        self.api = api
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let argsClass = NativeAdViewArguments.fromMap(
            args: args as! [String: Any?]
        )
        
        return NativeYandexAdView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: nil,
                api: api,
                id: argsClass.id
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class NativeYandexAdView: NSObject, FlutterPlatformView {
    
    private var nativeAdView: YMANativeBannerView!
    private var api: YandexApi!
    private var id: String!
    private var loader: YMANativeAdLoader!
 
    init(
        frame: CGRect, viewIdentifier viewId: Int64,
        arguments args: Any?, api: YandexApi?, id: String
    ) {
        super.init()
        
        self.api = api
        self.id = id
        self.nativeAdView = YMANativeBannerView()
        self.loader = YMANativeAdLoader()
        
        loadAd()
    }

    func loadAd() {
        loader.delegate = self

        let conf = YMAMutableNativeAdRequestConfiguration(adUnitID: id)

        conf.shouldLoadImagesAutomatically = true
        
        print("before ad " + id + " load")
        loader.loadAd(with: conf)
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

