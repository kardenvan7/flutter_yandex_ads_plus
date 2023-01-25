//
//  InterstitialYandexAd.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation
import YandexMobileAds

class RewardedYandexAd: NSObject {
    let ad: YMARewardedAd
    let eventDispatcher: RewardedAdEventDispatcherFacade
    
    init(
        adUnitId: String,
        eventDispatcher: RewardedAdEventDispatcherFacade
    ) {
        self.ad = YMARewardedAd(adUnitID: adUnitId)
        self.eventDispatcher = eventDispatcher
    }
    
    func load(parameters: AdParameters?) {
        let request = buildRequest(parameters: parameters)
        ad.delegate = self

        ad.load(with: request)
    }
    
    func show() throws {
        if (ad.hasBeenPresented) {
            return
        }

        if (!ad.loaded) {
            throw PluginError.runtimeError(
                "Ad can not be shown. It has to be loaded first"
            )
        }

        if let vc = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
            ad.present(from: vc)
        }
    }
    
    func destroy() {
        ad.delegate = nil
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

extension RewardedYandexAd: YMARewardedAdDelegate {
    func rewardedAdDidLoad(_ rewardedAd: YMARewardedAd) {
        eventDispatcher.sendOnLoadedEvent()
    }
    
    func rewardedAdDidFail(toLoad rewardedAd: YMARewardedAd, error: Error) {
        eventDispatcher.sendOnFailedToLoadEvent(error: error)
    }
    
    func rewardedAdDidFail(toPresent rewardedAd: YMARewardedAd, error: Error) {
        eventDispatcher.sendOnFailedToAppearEvent(error: error)
    }
    
    func rewardedAdDidClick(_ rewardedAd: YMARewardedAd) {
        eventDispatcher.sendOnClickedEvent()
    }
    
    func rewardedAdWillAppear(_ rewardedAd: YMARewardedAd) {
        eventDispatcher.sendOnWillAppearEvent()
    }
    
    func rewardedAdDidAppear(_ rewardedAd: YMARewardedAd) {
        eventDispatcher.sendOnDidAppearEvent()
    }
    
    func rewardedAdWillDisappear(_ rewardedAd: YMARewardedAd) {
        eventDispatcher.sendOnWillDisappearEvent()
    }
    
    func rewardedAdDidDisappear(_ rewardedAd: YMARewardedAd) {
        eventDispatcher.sendOnDidDisappearEvent()
    }
    
    func rewardedAd(_ rewardedAd: YMARewardedAd, willPresentScreen viewController: UIViewController?) {
        eventDispatcher.sendOnWillPresentScreenEvent()
    }
    
    func rewardedAdWillLeaveApplication(_ rewardedAd: YMARewardedAd) {
        eventDispatcher.sendOnLeftApplicationEvent()
    }
    
    func rewardedAd(_ rewardedAd: YMARewardedAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        eventDispatcher.sendOnImpressionEvent(data: impressionData?.rawData)
    }
    
    func rewardedAd(_ rewardedAd: YMARewardedAd, didReward reward: YMAReward) {
        eventDispatcher.sendOnRewardedEvent(reward: reward)
    }
}
