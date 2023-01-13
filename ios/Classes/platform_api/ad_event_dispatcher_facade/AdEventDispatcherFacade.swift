//
//  AdEventDispatcher.swift
//  device_info_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class AdEventDispatcherFacade {
    private let uid: String
    private var dispatcher: AdEventDispatcher
    
    init(uid: String, dispatcher: AdEventDispatcher) {
        self.uid = uid
        self.dispatcher = dispatcher
    }
    
    func sendEvent(type: String, parameters: [String: Any?]?) {
        dispatcher.sendEvent(
            event: AdEvent(uid: uid, type: type, parameters: parameters)
        )
    }
}
