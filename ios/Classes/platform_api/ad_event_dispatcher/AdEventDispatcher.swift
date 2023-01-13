//
//  AdEventDispatcher.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 14.01.2023.
//

import Foundation

class AdEventDispatcher: NSObject {
    private let eventChannel: FlutterEventChannel
    private var eventSink: FlutterEventSink?
    
    init(
        channelName: String,
        binaryMessenger: FlutterBinaryMessenger
    ) {
        self.eventChannel = FlutterEventChannel(
            name: channelName, binaryMessenger: binaryMessenger
        )

        super.init()
        
        setStreamHandler()
    }
    
    func sendEvent(event: AdEvent) {
        eventSink?(event.toMap())
    }
    
    private func setStreamHandler() {
        eventChannel.setStreamHandler(self)
    }
    
    private func unsetStreamHandler() {
        eventChannel.setStreamHandler(nil)
    }
    
    func dispose() {
        unsetStreamHandler()
    }
}

extension AdEventDispatcher: FlutterStreamHandler {
    func onListen(
        withArguments arguments: Any?,
        eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}
