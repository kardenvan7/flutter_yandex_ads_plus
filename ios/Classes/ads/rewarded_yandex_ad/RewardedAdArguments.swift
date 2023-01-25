//
//  InterstitialAdArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation

class RewardedAdArguments {
    let uid: String
    let adId: String
    let adParameters: AdParameters?
    
    init(uid: String, adId: String, adParameters: AdParameters?) {
        self.uid = uid
        self.adId = adId
        self.adParameters = adParameters
    }
}
