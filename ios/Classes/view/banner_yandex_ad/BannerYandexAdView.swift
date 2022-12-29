//
//  BannerAdView.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 27.10.2022.
//

import Foundation
import YandexMobileAds
import Flutter

class BannerYandexAdView: NSObject, FlutterPlatformView {
    private let banner: YMAAdView
    private let viewUid: String
    private let adUid: String
    private let eventDispatcher: BasicAdEventDispatcher
 
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        argsClass: BannerYandexAdViewArguments,
        eventDispatcher: BasicAdEventDispatcher
     
    ) {
        self.adUid = argsClass.adUid
        self.viewUid = argsClass.viewUid

        self.banner = YMAAdView(
            adUnitID: adUid,
            adSize: YMAAdSize.flexibleSize(
                with: .init(
                    width: argsClass.width,
                    height: argsClass.height
                )
            )
        )
        
        self.eventDispatcher = eventDispatcher

        super.init()
        
        configureAndLoadAd(
            additionalLoadParameters: argsClass.additionalLoadParams,
            settings: argsClass.settings
        )
    }
    
    private func configureAndLoadAd(
        additionalLoadParameters: [String: String]?,
        settings: BannerYandexAdViewSettings
    ) {
        banner.translatesAutoresizingMaskIntoConstraints = settings.translatesAutoresizingMaskIntoConstraints
        
        banner.delegate = self

        banner.removeFromSuperview()
        
        let request = buildRequest(
            params: additionalLoadParameters
        )
        
        banner.loadAd(with: request)
    }
    
    private func buildRequest(params: [String: Any?]?) -> YMAAdRequest {
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

extension BannerYandexAdView: YMAAdViewDelegate {
    func adViewDidLoad(_ adView: YMAAdView) {
        eventDispatcher.sendOnAdLoadedEvent(viewUid: viewUid)
    }

    func adViewDidFailLoading(_ adView: YMAAdView, error: Error) {
        eventDispatcher.sendOnAdFailedToLoadEvent(
            viewUid: viewUid,
            error: error
        )
    }

    func adViewDidClick(_ adView: YMAAdView) {
        eventDispatcher.sendOnAdClickedEvent(viewUid: viewUid)
    }

    func adView(
        _ adView: YMAAdView,
        didTrackImpressionWith impressionData: YMAImpressionData?
    ) {
        eventDispatcher.sendOnImpressionEvent(
            viewUid: viewUid, data: impressionData?.rawData
        )
    }

    func adViewWillLeaveApplication(_ adView: YMAAdView) {
        eventDispatcher.sendLeftApplicationEvent(viewUid: viewUid)
    }

    func adView(
        _ adView: YMAAdView,
        didDismissScreen viewController: UIViewController?
    ) {
        eventDispatcher.sendDidDismissScreenEvent(viewUid: viewUid)
    }
    
    func adView(
        _ adView: YMAAdView,
        willPresentScreen viewController: UIViewController?
    ) {
        eventDispatcher.sendWillPresentScreenEvent(viewUid: viewUid)
    }
}
