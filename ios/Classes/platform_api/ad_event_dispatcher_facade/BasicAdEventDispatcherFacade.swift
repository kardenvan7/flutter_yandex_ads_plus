//
//  BasicAdEventDispatcher.swift
//  device_info_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class BasicAdEventDispatcherFacade: AdEventDispatcherFacade {
    func sendOnLoadedEvent() {
        sendBasicAdEvent(
            type: BasicAdEventType.onAdLoaded
        )
    }

    func sendOnFailedToLoadEvent(error: Error) {
        sendBasicAdEvent(
            type: BasicAdEventType.onAdFailedToLoad,
            parameters: [
                "code": 0,
                "description": error.localizedDescription
            ]
        )
    }

    func sendOnClickedEvent() {
        sendBasicAdEvent(
            type: BasicAdEventType.onAdClicked
        )
    }

    func sendOnLeftApplicationEvent() {
        sendBasicAdEvent(
            type: BasicAdEventType.onLeftApplication
        )
    }
    
    func sendOnDidDismissScreenEvent() {
        sendBasicAdEvent(
            type: BasicAdEventType.didDismissScreen
        )
    }
    
    func sendOnWillPresentScreenEvent() {
        sendBasicAdEvent(
            type: BasicAdEventType.willPresentScreen
        )
    }
    
    func sendOnImpressionEvent(data: String?) {
        sendBasicAdEvent(
            type: BasicAdEventType.onImpression,
            parameters: [
                "data": data
            ]
        )
    }
    
    private func sendBasicAdEvent(
        type: BasicAdEventType,
        parameters: [String: Any?]? = nil
    ) {
        sendEvent(
            type: type.getValue(),
            parameters: parameters
        )
    }
    
    enum BasicAdEventType {
        case onAdLoaded
        case onAdFailedToLoad
        case onAdClicked
        case onLeftApplication
        case didDismissScreen
        case willPresentScreen
        case onImpression
        
        func getValue() -> String {
            switch self {
                case .onAdLoaded:
                    return "onAdLoaded"
                case .onAdFailedToLoad:
                    return "onAdFailedToLoad"
                case .onAdClicked:
                    return "onAdClicked"
                case .onLeftApplication:
                    return "onLeftApplication"
                case .didDismissScreen:
                    return "didDismissScreen"
                case .willPresentScreen:
                    return "willPresentScreen"
                case .onImpression:
                    return "onImpression"
            }
        }
    }
}
