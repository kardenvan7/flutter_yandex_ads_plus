//
//  RewardedAdEventDispatcherFacade.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 25.01.2023.
//

import Foundation
import YandexMobileAds

class RewardedAdEventDispatcherFacade: InterstitialAdEventDispatcherFacade {
    
    func sendOnRewardedEvent(reward: YMAReward) {
        sendRewardedAdEvent(
            type: RewardedAdEventType.onRewarded,
            parameters: [
                "amount": reward.amount,
                "type": reward.type,
            ]
        )
    }

    private func sendRewardedAdEvent(
        type: RewardedAdEventType,
        parameters: [String: Any?]? = nil
    ) {
        sendEvent(type: type.getValue(), parameters: parameters)
    }
    
    enum RewardedAdEventType {
        case onRewarded
        
        func getValue() -> String {
            switch self {
            case .onRewarded:
                return "onRewarded"
            }
        }
    }
}
