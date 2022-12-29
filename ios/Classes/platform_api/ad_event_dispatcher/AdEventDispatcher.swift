//
//  AdEventDispatcher.swift
//  device_info_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class AdEventDispatcher {
    private var eventSink: FlutterEventSink? = nil
    
    func setSink(sink: @escaping FlutterEventSink) {
        eventSink = sink
    }
    
    func removeSink() {
        eventSink = nil
    }
    
    func sendEvent(event: AdEvent) {
        eventSink?(event.toMap())
    }
}
