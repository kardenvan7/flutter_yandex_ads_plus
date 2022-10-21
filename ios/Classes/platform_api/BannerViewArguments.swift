//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerViewArguments {
    let id: String!
    let height: Int?
    let width: Int?
    
    init(id: String, height: Int?, width: Int?) {
        self.id = id
        self.height = height
        self.width = width
    }
    
    public static func fromMap(args: [String: Any?]) -> BannerViewArguments {
            return BannerViewArguments(
                id: args["ad_id"] as! String,
                height: args["height"] as! Int?,
                width: args["width"] as! Int?
            )
        }
}
