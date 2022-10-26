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
                id: argsClass.id,
                width: argsClass.width,
                height: argsClass.height
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
        arguments args: Any?, api: YandexApi?, id: String,
        width: Int, height: Int
    ) {
        super.init()
        
        self.api = api
        self.id = id
        self.nativeAdView = YMANativeBannerView()
        self.loader = YMANativeAdLoader()
        
        loadAd(width: width, height: height)
    }

    func loadAd(width: Int, height: Int) {
        loader.delegate = self

        let conf = YMAMutableNativeAdRequestConfiguration(adUnitID: id)
        conf.parameters = [
            "preferable-height": "\(height)",
            "preferable-width": "\(width)"
        ]
        
        setAppearance()
        loader.loadAd(with: conf)
    }
    
    func setAppearance() {
//        do {
//            let color = try UIColor(hexString: "0xaa00aa00")
//
//            print(color.description)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        let appearance = YMAMutableNativeTemplateAppearance.default()
//
//        do {
//            appearance.backgroundColor =
//                try UIColor(hexString: "0xaa000000")
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        appearance.titleAppearance = YMALabelAppearance(
//            font: .systemFont(ofSize: 14),
//            textColor: .red
//        )
//
//        appearance.bodyAppearance = YMALabelAppearance(
//            font: .systemFont(ofSize: 14),
//            textColor: .red
//        )
//
//        nativeAdView.apply(appearance)
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

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
    
    convenience init(argb: Int) {
           self.init(
               red: (argb >> 16) & 0xFF,
               green: (argb >> 8) & 0xFF,
               blue: argb & 0xFF,
               alpha: (argb >> 24) & 0xFF
           )
       }
    
    convenience init(hexString: String) throws {
        let argb = UInt32(hexString.dropFirst(2), radix: 16)
        
        if (argb == nil) {
            throw "\(hexString) is not valid hex"
        }

        self.init(
            argb: Int(argb!)
        )
    }
}
