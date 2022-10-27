import Flutter

class NativeAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private var api: YandexApi

    init(api: YandexApi) {
        self.api = api
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let argsClass = NativeAdViewArgumentsFactory.fromMap(
            args: args as! [String: Any?]
        )
        
        return NativeYandexAdView(
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
