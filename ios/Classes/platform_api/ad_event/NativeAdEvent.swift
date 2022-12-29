//
//  NativeAdEvent.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class NativeAdEvent: AdEvent {
    init(
        viewUid: String,
        type: NativeAdEvent.NativeAdEventType,
        parameters: [String : Any?]? = nil
    ) {
        super.init(
            viewUid: viewUid,
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
