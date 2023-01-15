//
//  AdParameters.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 14.01.2023.
//

import Foundation
import CoreLocation

class AdParameters {
    let age: NSNumber?
    let biddingData: String?
    let headerBiddingData: String?
    let contextQuery: String?
    let contextTags: [String]?
    let gender: String?
    let location: CLLocation?
    let custom: [String: String]?
    
    init(age: NSNumber?, biddingData: String?, headerBiddingData: String?, contextQuery: String?, contextTags: [String]?, gender: String?, location: CLLocation?, custom: [String : String]?) {
        self.age = age
        self.biddingData = biddingData
        self.headerBiddingData = headerBiddingData
        self.contextQuery = contextQuery
        self.contextTags = contextTags
        self.gender = gender
        self.location = location
        self.custom = custom
    }
}
