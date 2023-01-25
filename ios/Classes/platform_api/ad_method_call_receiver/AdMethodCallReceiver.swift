//
//  AdEventReceiver.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation

class AdMethodCallReceiver {
    private let methodChannel: FlutterMethodChannel
    private let interstitialAdsOrganizer: InterstitialYandexAdsOrganizer
    private let rewardedAdsOrganizer: RewardedYandexAdsOrganizer
    
    init(
        name: String,
        binaryMessenger: FlutterBinaryMessenger,
        eventDispatcher: AdEventDispatcher
    ) {
        self.methodChannel = FlutterMethodChannel(
            name: name,
            binaryMessenger: binaryMessenger
        )
        self.interstitialAdsOrganizer = InterstitialYandexAdsOrganizer(
            eventDispatcher: eventDispatcher
        )
        self.rewardedAdsOrganizer = RewardedYandexAdsOrganizer(
            eventDispatcher: eventDispatcher
        )

        methodChannel.setMethodCallHandler(handler)
    }
    
    private func handler(call: FlutterMethodCall, result: FlutterResult) {
        switch call.method {
        case "loadInterstitialAd":
            loadInterstitialAd(call: call, result: result)
            break
        case "showInterstitialAd":
            showInterstitialAd(call: call, result: result)
            break
        case "removeInterstitialAd":
            removeInterstitialAd(call: call, result: result)
            break
        case "loadRewardedAd":
            loadRewardedAd(call: call, result: result)
            break
        case "showRewardedAd":
            showRewardedAd(call: call, result: result)
            break
        case "removeRewardedAd":
            removeRewardedAd(call: call, result: result)
            break
        case "enableLogging":
            enableLogging(call: call, result: result)
            break
        case "enableDebugErrorIndicator":
            enableVisibilityErrorIndicator(call: call, result: result)
            break
        case "setLocationConsent":
            setLocationTrackingEnabled(call: call, result: result)
            break
        case "setUserConsent":
            setUserConsent(call: call, result: result)
            break
        case "getLibraryVersion":
            getLibraryVersion(call: call, result: result)
            break
        default:
            handleUnknownMethodCall(call: call, result: result)
        }
    }
    
    private func loadInterstitialAd(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let arguments = call.arguments
        
        if (!(arguments is [String: Any?])) {
            return result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Given arguments: \(String(describing: arguments))"
                )
            )
        }
        
        let args = InterstitialAdArgumentsFactory.fromMap(
            map: arguments as! [String: Any?]
        )
        
        interstitialAdsOrganizer.createAndLoadAd(args: args)
        
        result(nil)
    }
    
    private func showInterstitialAd(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let uid = call.arguments
        
        if (!(uid is String)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Uid has to be String. Given uid: \(String(describing: uid))"
                )
            )
        }

        do {
            try interstitialAdsOrganizer.showAd(uid: uid as! String)
        } catch {
            result(
                FlutterError(
                    code: "-1",
                    message: error.localizedDescription,
                    details: nil
                )
            )
        }
        
        result(nil)
    }
    
    private func removeInterstitialAd(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let uid = call.arguments
        
        if (!(uid is String)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Uid has to be String. Given uid: \(String(describing: uid))"
                )
            )
        }

        interstitialAdsOrganizer.removeAd(uid: uid as! String)
        
        result(nil)
    }
    
    private func loadRewardedAd(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let arguments = call.arguments
        
        if (!(arguments is [String: Any?])) {
            return result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Given arguments: \(String(describing: arguments))"
                )
            )
        }
        
        let args = RewardedAdArgumentsFactory.fromMap(
            map: arguments as! [String: Any?]
        )
        
        rewardedAdsOrganizer.createAndLoadAd(args: args)
        
        result(nil)
    }
    
    private func showRewardedAd(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let uid = call.arguments
        
        if (!(uid is String)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Uid has to be String. Given uid: \(String(describing: uid))"
                )
            )
        }

        do {
            try rewardedAdsOrganizer.showAd(uid: uid as! String)
        } catch {
            result(
                FlutterError(
                    code: "-1",
                    message: error.localizedDescription,
                    details: nil
                )
            )
        }
        
        result(nil)
    }
    
    private func removeRewardedAd(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let uid = call.arguments
        
        if (!(uid is String)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Uid has to be String. Given uid: \(String(describing: uid))"
                )
            )
        }

        rewardedAdsOrganizer.removeAd(uid: uid as! String)
        
        result(nil)
    }
    
    private func enableLogging(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let value = call.arguments
        
        if (!(value is Bool)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Argument has to be a boolean. Given argument: \(String(describing: value))"
                )
            )
        }

        YandexAdsSdkFacade.enableLogging(value: value as! Bool)
        
        result(nil)
    }
    
    private func enableVisibilityErrorIndicator(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let value = call.arguments
        
        if (!(value is Bool)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Argument has to be a boolean. Given argument: \(String(describing: value))"
                )
            )
        }

        YandexAdsSdkFacade.enableVisibilityErrorIndicator(value: value as! Bool)
        
        result(nil)
    }
    
    private func setLocationTrackingEnabled(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let value = call.arguments
        
        if (!(value is Bool)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Argument has to be a boolean. Given argument: \(String(describing: value))"
                )
            )
        }

        YandexAdsSdkFacade.setLocationTrackingEnabled(value: value as! Bool)
        
        result(nil)
    }
    
    private func setUserConsent(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        let value = call.arguments
        
        if (!(value is Bool)) {
            result(
                FlutterError(
                    code: "-1",
                    message: "Call arguments are invalid.",
                    details: "Argument has to be a boolean. Given argument: \(String(describing: value))"
                )
            )
        }
        
        YandexAdsSdkFacade.setUserConsent(value: value as! Bool)
        
        result(nil)
    }
    
    private func getLibraryVersion(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {        
        result(YandexAdsSdkFacade.getSdkVersion())
    }
    
    private func handleUnknownMethodCall(
        call: FlutterMethodCall,
        result: FlutterResult
    ) {
        result(FlutterMethodNotImplemented)
    }
    
    func dispose() {
        methodChannel.setMethodCallHandler(nil)
    }
}
