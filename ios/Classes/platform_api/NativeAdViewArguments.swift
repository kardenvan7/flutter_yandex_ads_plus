//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class NativeAdViewArguments {
    let id: String!
    
    init(id: String) {
        self.id = id
    }
    
    public static func fromMap(args: [String: Any?]) -> NativeAdViewArguments {
            return NativeAdViewArguments(
                id: args["ad_id"] as! String
            )
        }
}
