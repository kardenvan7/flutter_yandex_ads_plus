//
//  InterstitialAdEventDispatcherFacade.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation

class InterstitialAdEventDispatcherFacade: BasicAdEventDispatcherFacade {
    func sendOnFailedToAppearEvent(error: Error) {
        sendInterstitialAdEvent(
            type: InterstitialAdEventType.onFailedToAppear,
            parameters: [
                "code": -1,
                "description": error.localizedDescription
            ]
        )
    }

    func sendOnWillAppearEvent() {
        sendInterstitialAdEvent(type: InterstitialAdEventType.onWillAppear)
    }
    
    func sendOnDidAppearEvent() {
        sendInterstitialAdEvent(type: InterstitialAdEventType.onDidAppear)
    }
    
    func sendOnWillDisappearEvent() {
        sendInterstitialAdEvent(
            type: InterstitialAdEventType.onWillDisappear
        )
    }
    
    func sendOnDidDisappearEvent() {
        sendInterstitialAdEvent(
            type: InterstitialAdEventType.onDidDisappear
        )
    }

    private func sendInterstitialAdEvent(
        type: InterstitialAdEventType,
        parameters: [String: Any?]? = nil
    ) {
        sendEvent(type: type.getValue(), parameters: parameters)
    }
    
    enum InterstitialAdEventType {
        case onWillAppear
        case onDidAppear
        case onWillDisappear
        case onDidDisappear
        case onFailedToAppear
        
        func getValue() -> String {
            switch self {
                case .onFailedToAppear:
                    return "onFailedToAppear"
                case .onWillAppear:
                    return "onWillAppear"
                case .onDidAppear:
                    return "onAdShown"
                case .onWillDisappear:
                    return "onWillDisappear"
                case .onDidDisappear:
                    return "onAdDismissed"
            }
        }
    }
}
