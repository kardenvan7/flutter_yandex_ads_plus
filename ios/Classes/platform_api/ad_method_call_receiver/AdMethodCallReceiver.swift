//
//  AdEventReceiver.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation

class AdMethodCallReceiver {
    private let methodChannel: FlutterMethodChannel
    private let eventDispatcher: AdEventDispatcher
    
    init(
        name: String,
        binaryMessenger: FlutterBinaryMessenger,
        eventDispatcher: AdEventDispatcher
    ) {
        self.methodChannel = FlutterMethodChannel(
            name: name,
            binaryMessenger: binaryMessenger
        )
        self.eventDispatcher = eventDispatcher

        methodChannel.setMethodCallHandler(handler)
    }
    
    private func handler(call: FlutterMethodCall, result: FlutterResult) {
        switch call.method {
        case "showInterstitialAd":
            showInterstitialAd(call: call, result: result)
        default:
            handleUnknownMethodCall(call: call, result: result)
        }
    }
    
    private func showInterstitialAd(
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
        
        let ad = InterstitialYandexAd(
            adUnitId: args.adId,
            eventDispatcher: InterstitialAdEventDispatcherFacade(
                uid: args.uid,
                dispatcher: eventDispatcher
            )
        )
        
        ad.loadAndShow(parameters: args.adParameters)
        
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
