import Flutter
import UIKit

public class SwiftFlutterYandexAdsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger : FlutterBinaryMessenger = registrar.messenger()

    // api setup
    let api = YandexApi()
    YandexAdsApiSetup(messenger, api)

    // widgets
    registrar.register(
        BannerYandexAdViewFactory(api: api),
        withId: "yandex-ads-banner"
    )
      
      registrar.register(
          NativeYandexAdViewFactory(api: api),
          withId: "yandex-ads-native"
      )

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
