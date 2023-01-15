//
//  NativeAdEventDispatcher.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class NativeAdEventDispatcherFacade: BasicAdEventDispatcherFacade {
    func sendOnCloseEvent() {
        sendNativeAdEvent(
            type: NativeAdEventType.onClose
        )
    }
    
    private func sendNativeAdEvent(
        type: NativeAdEventType,
        parameters: [String: Any?]? = nil
    ) {
        sendEvent(
            type: type.getValue(),
            parameters: parameters
        )
    }
    
    enum NativeAdEventType {
        case onClose
        
        func getValue() -> String {
            switch self {
            case .onClose:
                return "onClose"
            }
        }
    }
}
