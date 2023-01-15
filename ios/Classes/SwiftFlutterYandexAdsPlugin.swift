import Flutter
import UIKit

public class SwiftFlutterYandexAdsPlugin: NSObject, FlutterPlugin  {
    private static var api: FlutterYandexAdsApi? = nil

    public static func register(
        with registrar: FlutterPluginRegistrar
    ) {
        api = FlutterYandexAdsApi(messenger: registrar.messenger())

        let eventDispatcher = api!.eventDispatcher

        registrar.register(
            BannerYandexAdViewFactory(eventDispatcher: eventDispatcher),
            withId: PlatfromApiConfig.bannerAdViewTypeId
        )
          
        registrar.register(
            NativeYandexAdViewFactory(eventDispatcher: eventDispatcher),
            withId: PlatfromApiConfig.nativeAdViewTypeId
        )
    }
    
    public func detachFromEngine(
        for registrar: FlutterPluginRegistrar
    ) {
        SwiftFlutterYandexAdsPlugin.api?.dispose()
    }
}
