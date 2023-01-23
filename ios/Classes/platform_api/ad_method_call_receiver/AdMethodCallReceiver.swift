//
//  AdEventReceiver.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation

class AdMethodCallReceiver {
    private let methodChannel: FlutterMethodChannel
    private let interstitialAdOrganizer: InterstitialYandexAdOrganizer
    
    init(
        name: String,
        binaryMessenger: FlutterBinaryMessenger,
        eventDispatcher: AdEventDispatcher
    ) {
        self.methodChannel = FlutterMethodChannel(
            name: name,
            binaryMessenger: binaryMessenger
        )
        self.interstitialAdOrganizer = InterstitialYandexAdOrganizer(
            eventDispatcher: eventDispatcher
        )

        methodChannel.setMethodCallHandler(handler)
    }
    
    private func handler(call: FlutterMethodCall, result: FlutterResult) {
        switch call.method {
        case "loadInterstitialAd":
            loadInterstitialAd(call: call, result: result)
        case "showInterstitialAd":
            showInterstitialAd(call: call, result: result)
        case "removeInterstitialAd":
            removeInterstitialAd(call: call, result: result)
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
        
        interstitialAdOrganizer.createAndLoadAd(args: args)
        
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
            try interstitialAdOrganizer.showAd(uid: uid as! String)
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

        interstitialAdOrganizer.removeAd(uid: uid as! String)
        
        result(nil)
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
