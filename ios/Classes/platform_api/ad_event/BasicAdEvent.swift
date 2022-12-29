//
//  BannerAdEvent.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class BasicAdEvent: AdEvent {
    init(
        viewUid: String,
        type: BasicAdEventType,
        parameters: [String: Any?]? = nil
    ) {

        super.init(
            viewUid: viewUid,
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
