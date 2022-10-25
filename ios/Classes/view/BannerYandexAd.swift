import Flutter
import UIKit
import YandexMobileAds

class BannerYandexAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private var api: YandexApi

    init(api: YandexApi) {
        self.api = api
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let argsClass = BannerAdViewArguments.fromMap(
            args: args as! [String: Any?]
        )
        
        return BannerYandexAdView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: nil,
                api: api,
                height: argsClass.height,
                width: argsClass.width,
                id: argsClass.id
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class BannerYandexAdView: NSObject, FlutterPlatformView {
    private var banner: YMAAdView!
    private var api: YandexApi!
    private var id: String!
 
    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, api: YandexApi?, height: Int?, width: Int?, id: String) {
        super.init()
        
        self.api = api
        self.id = id

        banner = YMAAdView(
            adUnitID: id,
            adSize: YMAAdSize.flexibleSize(
                with: .init(width: width ?? 320, height: height ?? 100)
            )
        )
        
        banner.delegate = self

        banner.removeFromSuperview()
    
        
        let request = YMAAdRequest()
        
        banner.loadAd(with: request)
    }

    func view() -> UIView {
        return banner
    }
}

extension BannerYandexAdView: YMAAdViewDelegate {
    func adViewDidLoad(_ adView: YMAAdView) {
        let response = EventResponse()
        
        print("Ad " + id + " loaded")

        if let callback = api.callbacks[EventKey(id: id, name: "onAdLoaded", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }

    func adViewDidFailLoading(_ adView: YMAAdView, error: Error) {
        let response = EventResponse()
        
        response.code = 0
        response.desc = error.localizedDescription
        
        if let callback = api.callbacks[EventKey(id: id, name: "onAdFailedToLoad", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }

    func adViewDidClick(_ adView: YMAAdView) {
        let response = EventResponse()
        
        print("Ad " + id + " is clicked")

        if let callback = api.callbacks[EventKey(id: id, name: "onAdClicked", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }

    func adViewWillLeaveApplication(_ adView: YMAAdView) {
        let response = EventResponse()
        
        print("Ad " + id + " will leave application")

        if let callback = api.callbacks[EventKey(id: id, name: "onLeftApplication", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }

    func adView(_ adView: YMAAdView, willPresentScreen viewController: UIViewController?) {
        let response = EventResponse()
        
        print("Ad " + id + " is shown")

        if let callback = api.callbacks[EventKey(id: id, name: "onAdShown", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }

    func adView(_ adView: YMAAdView, didDismissScreen viewController: UIViewController?) {
        let response = EventResponse()
        
        print("Ad " + id + " is dissmissed")

        if let callback = api.callbacks[EventKey(id: id, name: "onAdDismissed", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }

    func adView(_ adView: YMAAdView, didTrackImpressionWith impressionData: YMAImpressionData?) {
        let response = EventResponse()
        response.data = impressionData?.rawData ?? ""
        
        print("Ad " + id + " is impressed")

        if let callback = api.callbacks[EventKey(id: id, name: "onImpression", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }
}

