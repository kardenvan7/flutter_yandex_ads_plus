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
    private let eventDispatcher: BasicAdEventDispatcherFacade
 
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        argsClass: BannerYandexAdViewArguments,
        eventDispatcher: BasicAdEventDispatcherFacade
    ) {
        self.banner = YMAAdView(
            adUnitID: argsClass.adId,
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
            parameters:argsClass.parameters,
            settings: argsClass.settings
        )
    }
    
    private func configureAndLoadAd(
        parameters: AdParameters?,
        settings: BannerYandexAdViewSettings
    ) {
        banner.translatesAutoresizingMaskIntoConstraints = settings.translatesAutoresizingMaskIntoConstraints
        
        banner.delegate = self

        banner.removeFromSuperview()
        
        let request = buildRequest(params: parameters)
        
        banner.loadAd(with: request)
    }
    
    private func buildRequest(params: AdParameters?) -> YMAAdRequest {
        if (params == nil) {
            return YMAAdRequest()
        } else {
            return YMAAdRequestFactory.fromAdParameters(
                parameters: params!
            )
        }
    }

    func view() -> UIView {
        return banner
    }
}

extension BannerYandexAdView: YMAAdViewDelegate {
    func adViewDidLoad(_ adView: YMAAdView) {
        eventDispatcher.sendOnLoadedEvent()
    }

    func adViewDidFailLoading(_ adView: YMAAdView, error: Error) {
        eventDispatcher.sendOnFailedToLoadEvent(
            error: error
        )
    }

    func adViewDidClick(_ adView: YMAAdView) {
        eventDispatcher.sendOnClickedEvent()
    }

    func adView(
        _ adView: YMAAdView,
        didTrackImpressionWith impressionData: YMAImpressionData?
    ) {
        eventDispatcher.sendOnImpressionEvent(
           data: impressionData?.rawData
        )
    }

    func adViewWillLeaveApplication(_ adView: YMAAdView) {
        eventDispatcher.sendOnLeftApplicationEvent()
    }

    func adView(
        _ adView: YMAAdView,
        didDismissScreen viewController: UIViewController?
    ) {
        eventDispatcher.sendOnDidDismissScreenEvent()
    }
    
    func adView(
        _ adView: YMAAdView,
        willPresentScreen viewController: UIViewController?
    ) {
        eventDispatcher.sendOnWillPresentScreenEvent()
    }
}
