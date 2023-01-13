import Flutter
import UIKit

public class SwiftFlutterYandexAdsPlugin: NSObject, FlutterPlugin {
    private static var api: FlutterYandexAdsApi!

    public static func register(
        with registrar: FlutterPluginRegistrar
    ) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
          
        api = FlutterYandexAdsApi(messenger: messenger)

        // widgets
        registrar.register(
            BannerYandexAdViewFactory(
                eventDispatcher: api.eventDispatcher
            ),
            withId: PlatfromApiConfig.bannerAdViewTypeId
        )
          
        registrar.register(
            NativeYandexAdViewFactory(
                eventDispatcher: api.eventDispatcher
            ),
            withId: PlatfromApiConfig.nativeAdViewTypeId
        )
    }
    
    public func detachFromEngine(
        for registrar: FlutterPluginRegistrar
    ) {
        SwiftFlutterYandexAdsPlugin.api.dispose()
    }
}
