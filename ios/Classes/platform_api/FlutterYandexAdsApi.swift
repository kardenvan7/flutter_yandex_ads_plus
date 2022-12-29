//
//  FlutterYandexAdsApi.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class FlutterYandexAdsApi {
    private let bannerAdEventChannel: FlutterEventChannel
    private let nativeAdEventChannel: FlutterEventChannel
    
    let bannerAdEventDispatcher: BasicAdEventDispatcher
    let nativeAdEventDispatcher: NativeAdEventDispatcher
    
    init(
        messenger: FlutterBinaryMessenger
    ) {
        self.bannerAdEventChannel = FlutterEventChannel(
            name: PlatfromApiConfig.bannerAdEventChannelName,
            binaryMessenger: messenger
        )

        self.nativeAdEventChannel = FlutterEventChannel(
            name: PlatfromApiConfig.nativeAdEventChannelName,
            binaryMessenger: messenger
        )
        
        self.bannerAdEventDispatcher = BasicAdEventDispatcher()
        self.nativeAdEventDispatcher = NativeAdEventDispatcher()
        
        setUpStreamHandlers()
    }
    
    private func setUpStreamHandlers() {
        self.bannerAdEventChannel.setStreamHandler(
            AdEventStreamHandler(
                dispatcher: bannerAdEventDispatcher
            )
        )

        self.nativeAdEventChannel.setStreamHandler(
            AdEventStreamHandler(
                dispatcher: nativeAdEventDispatcher
            )
        )
    }
    
    func dispose() {
        bannerAdEventChannel.setStreamHandler(nil)
        nativeAdEventChannel.setStreamHandler(nil)
    }
    
    private class AdEventStreamHandler: NSObject, FlutterStreamHandler {
        private let dispatcher: AdEventDispatcher

        init(
            dispatcher: AdEventDispatcher
        ) {
            self.dispatcher = dispatcher
            super.init()
        }
        
        func onListen(
            withArguments arguments: Any?,
            eventSink events: @escaping FlutterEventSink
        ) -> FlutterError? {
            dispatcher.setSink(sink: events)
            return nil
        }
        
        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            dispatcher.removeSink()
            return nil
        }
    }
}
