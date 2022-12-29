import Flutter
import UIKit
import YandexMobileAds

class BannerYandexAdViewFactory:
    NSObject, FlutterPlatformViewFactory {
    private let eventDispatcher: BasicAdEventDispatcher

    init(
        eventDispatcher: BasicAdEventDispatcher
    ) {
        self.eventDispatcher = eventDispatcher
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

        return BannerYandexAdView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: nil,
                argsClass: argsClass,
                eventDispatcher: eventDispatcher
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
