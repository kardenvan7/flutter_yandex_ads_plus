//
//  BannerAdView.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 27.10.2022.
//

import Foundation
import YandexMobileAds
import Flutter

class BannerAdView: NSObject, FlutterPlatformView {
    private var banner: YMAAdView!
    private var api: YandexApi!
    private var id: String!
 
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        api: YandexApi?,
        argsClass: BannerAdViewArguments
    ) {
        super.init()
        
        self.api = api
        self.id = argsClass.id

        banner = YMAAdView(
            adUnitID: id,
            adSize: YMAAdSize.flexibleSize(
                with: .init(
                    width: argsClass.width ?? 320,
                    height: argsClass.height ?? 100
                )
            )
        )
        
        banner.delegate = self

        banner.removeFromSuperview()
        
        let request = getRequest(
            params: argsClass.additionalLoadParams
        )
        
        banner.loadAd(with: request)
    }
    
    func getRequest(params: [String: Any?]?) -> YMAAdRequest {
        let request = YMAMutableAdRequest()
        
        if (params != nil) {
            var parameters = Dictionary<String, String>()

            for (key, value) in params! {
                if let stringValue = value as? String {
                    parameters[key] = stringValue
                }
            }

            request.parameters = parameters
        }

        return request
    }

    func view() -> UIView {
        return banner
    }
}

extension BannerAdView: YMAAdViewDelegate {
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


