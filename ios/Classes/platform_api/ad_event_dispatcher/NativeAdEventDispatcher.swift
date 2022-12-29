//
//  NativeAdEventDispatcher.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class NativeAdEventDispatcher: BasicAdEventDispatcher {
    func sendOnAdCloseEvent(viewUid: String) {
        sendNativeAdEvent(
            viewUid: viewUid,
            type: NativeAdEvent.NativeAdEventType.onClose
        )
    }
    
    private func sendNativeAdEvent(
        viewUid: String,
        type: NativeAdEvent.NativeAdEventType,
        parameters: [String: Any?]? = nil
    ) {
        sendEvent(
            event: NativeAdEvent(
                viewUid: viewUid,
                type: type,
                parameters: parameters
            )
        )
    }
}
