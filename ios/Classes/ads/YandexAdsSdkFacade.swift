//
//  YandexAdsSDKFacade.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 24.01.2023.
//

import Foundation
import YandexMobileAds

class YandexAdsSdkFacade {
    static func initialize() {
        YMAMobileAds.initialize()
    }
    
    static func enableLogging(value: Bool) {
        if (value) {
            YMAMobileAds.enableLogging()
            PluginLogger.log(
                message: "Logging enabled."
            )
        } else {
            PluginLogger.log(
                message: "Logging can be disabled only by restarting the app."
            )
        }
    }
    
    static func enableVisibilityErrorIndicator(value: Bool) {
        YMAMobileAds.enableVisibilityErrorIndicator(
            for: value ? YMADeviceType.hardware : []
        )

        PluginLogger.log(
            message: "Debug error indicator \(value ? "enabled" : "disabled")."
        )
    }
    
    static func setLocationTrackingEnabled(value: Bool) {
        YMAMobileAds.setLocationTrackingEnabled(value)
        
        PluginLogger.log(
            message: "Location tracking \(value ? "enabled" : "disabled")."
        )
    }
    
    static func setUserConsent(value: Bool) {
        YMAMobileAds.setUserConsent(value)
        
        PluginLogger.log(
            message: "User consent \(value ? "enabled" : "disabled")"
        )
    }

    static func getSdkVersion() -> String {
        return YMAMobileAds.sdkVersion()
    }
}
