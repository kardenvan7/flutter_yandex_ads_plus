//
//  FlutterYandexAdsApi.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation
import YandexMobileAds

class FlutterYandexAdsApi {
    let eventDispatcher: AdEventDispatcher
    private let methodCallReceiver: AdMethodCallReceiver
    
    init(
        messenger: FlutterBinaryMessenger
    ) {
        YandexAdsSdkFacade.initialize()

        self.eventDispatcher = AdEventDispatcher(
            channelName: PlatfromApiConfig.eventChannelName,
            binaryMessenger: messenger
        )
        
        self.methodCallReceiver = AdMethodCallReceiver(
            name: PlatfromApiConfig.methodChannelName,
            binaryMessenger: messenger,
            eventDispatcher: eventDispatcher
        )
    }
    
    func dispose() {
        eventDispatcher.dispose()
        methodCallReceiver.dispose()
    }
}
