//
//  BasicAdEventDispatcher.swift
//  device_info_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class BasicAdEventDispatcher: AdEventDispatcher {
    func sendOnAdLoadedEvent(viewUid: String) {
        sendBasicAdEvent(
            viewUid: viewUid,
            type: BasicAdEvent.BasicAdEventType.onAdLoaded
        )
    }

    func sendOnAdFailedToLoadEvent(viewUid: String, error: Error) {
        sendBasicAdEvent(
            viewUid: viewUid,
            type: BasicAdEvent.BasicAdEventType.onAdFailedToLoad,
            parameters: [
                "code": 0,
                "description": error.localizedDescription
            ]
        )
    }

    func sendOnAdClickedEvent(viewUid: String) {
        sendBasicAdEvent(
            viewUid: viewUid,
            type: BasicAdEvent.BasicAdEventType.onAdClicked
        )
    }

    func sendLeftApplicationEvent(viewUid: String) {
        sendBasicAdEvent(
            viewUid: viewUid,
            type: BasicAdEvent.BasicAdEventType.onLeftApplication
        )
    }
    
    func sendDidDismissScreenEvent(viewUid: String) {
        sendBasicAdEvent(
            viewUid: viewUid,
            type: BasicAdEvent.BasicAdEventType.didDismissScreen
        )
    }
    
    func sendWillPresentScreenEvent(viewUid: String) {
        sendBasicAdEvent(
            viewUid: viewUid,
            type: BasicAdEvent.BasicAdEventType.willPresentScreen
        )
    }
    
    func sendOnImpressionEvent(viewUid: String, data: String?) {
        sendBasicAdEvent(
            viewUid: viewUid,
            type: BasicAdEvent.BasicAdEventType.onImpression,
            parameters: [
                "data": data
            ]
        )
    }
    
    private func sendBasicAdEvent(
        viewUid: String,
        type: BasicAdEvent.BasicAdEventType,
        parameters: [String: Any?]? = nil
    ) {
        sendEvent(
            event: BasicAdEvent(
                viewUid: viewUid,
                type: type,
                parameters: parameters
            )
        )
    }
}
