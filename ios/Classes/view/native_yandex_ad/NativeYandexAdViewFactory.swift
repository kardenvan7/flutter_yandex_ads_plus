import Flutter

class NativeYandexAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private let eventDispatcher: NativeAdEventDispatcher
    
    init(
        eventDispatcher: NativeAdEventDispatcher
    ) {
        self.eventDispatcher = eventDispatcher
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        let argsClass = NativeAdViewArgumentsFactory.fromMap(
            args: args as! [String: Any?]
        )
    
        return NativeYandexAdView(
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
