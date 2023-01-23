//
//  InterstitialYandexAdOrganizer.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 23.01.2023.
//

import Foundation

class InterstitialYandexAdOrganizer {
    private let eventDispatcher: AdEventDispatcher
    private var ads: [String: InterstitialYandexAd] = [:]
    
    init(eventDispatcher: AdEventDispatcher) {
        self.eventDispatcher = eventDispatcher
    }
    
    func createAndLoadAd(args: InterstitialAdArguments) {
        let key = args.uid

        removeAdIfExists(uid: key)

        let ad = createAd(args: args)
        ads[key] = ad
        
        ad.load(parameters: args.adParameters)
    }
    
    func showAd(uid: String) throws {
        if let ad = ads[uid] {
            try ad.show()
        } else {
            throw PluginError.runtimeError(
                "Ad can not be shown. It has to be loaded first"
            )
        }
    }
    
    func removeAd(uid: String) {
        if let ad = ads.removeValue(forKey: uid) {
            ad.destroy()
        }
    }
    
    private func createAd(args: InterstitialAdArguments)
    -> InterstitialYandexAd {
        return InterstitialYandexAd(
            adUnitId: args.adId,
            eventDispatcher: InterstitialAdEventDispatcherFacade(
                uid: args.uid,
                dispatcher: eventDispatcher
            )
        )
    }
    
    private func removeAdIfExists(uid: String) {
        ads.removeValue(forKey: uid)
    }
}
