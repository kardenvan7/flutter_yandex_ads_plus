import Flutter
import UIKit
import YandexMobileAds

class BannerAdViewFactory:
    NSObject, FlutterPlatformViewFactory {
    private var api: YandexApi

    init(api: YandexApi) {
        self.api = api
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        let argsClass = BannerAdViewArgumentsFactory.fromMap(
            args: args as! [String: Any?]
        )
        
        return BannerAdView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: nil,
                api: api,
                argsClass: argsClass
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
