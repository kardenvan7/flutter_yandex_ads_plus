//
//  InterstitialAdArgumentsFactory.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation

class RewardedAdArgumentsFactory {
    static func fromMap(map: [String: Any?]) -> RewardedAdArguments {
        return RewardedAdArguments(
            uid: map["uid"] as! String,
            adId: map["ad_id"] as! String,
            adParameters: parseAdParametersFromJson(
                json: map["parameters"] as Any?
            )
        )
    }
    
    private static func parseAdParametersFromJson(json: Any?) -> AdParameters? {
        if (!(json is [String:Any?])) {
            return nil
        }
            
        return AdParametersFactory.fromMap(
            map: json as! [String: Any?]
        )
    }
}
