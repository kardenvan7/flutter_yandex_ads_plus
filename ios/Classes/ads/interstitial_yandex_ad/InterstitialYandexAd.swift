//
//  InterstitialYandexAd.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation
import YandexMobileAds

class InterstitialYandexAd: NSObject {
    let ad: YMAInterstitialAd
    let eventDispatcher: InterstitialAdEventDispatcherFacade
    
    init(
        adUnitId: String,
        eventDispatcher: InterstitialAdEventDispatcherFacade
    ) {
        self.ad = YMAInterstitialAd(adUnitID: adUnitId)
        self.eventDispatcher = eventDispatcher
    }
    
    func loadAndShow(parameters: AdParameters?) {
        let request = buildRequest(parameters: parameters)
        ad.delegate = self

        ad.load(with: request)
    }

    private func buildRequest(parameters: AdParameters?) -> YMAAdRequest? {
        if (parameters == nil) {
            return YMAAdRequest()
        }

        return YMAAdRequestFactory.fromAdParameters(
            parameters: parameters!
        )
    }
}

extension InterstitialYandexAd: YMAInterstitialAdDelegate {
    func interstitialAdDidLoad(_ interstitialAd: YMAInterstitialAd) {
        PluginLogger.log(message: "ad loaded")
        if let vc = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
            interstitialAd.present(from: vc)
        }
        eventDispatcher.sendOnLoadedEvent()
    }
    
    func interstitialAdDidFail(toLoad interstitialAd: YMAInterstitialAd, error: Error
    ) {
        PluginLogger.log(message: "ad failed to load")
        eventDispatcher.sendOnFailedToLoadEvent(error: error)
    }
    
    func interstitialAdDidClick(_ interstitialAd: YMAInterstitialAd) {
        eventDispatcher.sendOnClickedEvent()
    }
    
    func interstitialAd(_ interstitialAd: YMAInterstitialAd, willPresentScreen webBrowser: UIViewController?) {
        eventDispatcher.sendOnWillPresentScreenEvent()
    }
    
    func interstitialAdWillLeaveApplication(
        _ interstitialAd: YMAInterstitialAd
    ) {
        eventDispatcher.sendOnLeftApplicationEvent()
    }
    
    func interstitialAd(
        _ interstitialAd: YMAInterstitialAd,
        didTrackImpressionWith impressionData: YMAImpressionData?
    ) {
        eventDispatcher.sendOnImpressionEvent(data: impressionData?.rawData)
    }
    
    func interstitialAdDidFail(toPresent interstitialAd: YMAInterstitialAd, error: Error
    ) {
        PluginLogger.log(message: "ad failed to appear")
        eventDispatcher.sendOnFailedToAppearEvent(error: error)
    }
    
    func interstitialAdWillAppear(_ interstitialAd: YMAInterstitialAd) {
        eventDispatcher.sendOnWillAppearEvent()
    }
    
    func interstitialAdDidAppear(_ interstitialAd: YMAInterstitialAd) {
        eventDispatcher.sendOnDidAppearEvent()
    }
    
    func interstitialAdWillDisappear(_ interstitialAd: YMAInterstitialAd) {
        eventDispatcher.sendOnWillDisappearEvent()
    }
    
    func interstitialAdDidDisappear(_ interstitialAd: YMAInterstitialAd) {
        eventDispatcher.sendOnDidDisappearEvent()
    }
}
