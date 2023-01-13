//
//  FlutterYandexAdsApi.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class FlutterYandexAdsApi {
    let eventDispatcher: AdEventDispatcher
    
    init(
        messenger: FlutterBinaryMessenger
    ) {
        self.eventDispatcher = AdEventDispatcher(
            channelName: PlatfromApiConfig.eventChannelName,
            binaryMessenger: messenger
        )
    }
    
    func dispose() {
        eventDispatcher.dispose()
    }
}
