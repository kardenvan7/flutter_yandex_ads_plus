//
//  AdParametersFactory.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 14.01.2023.
//

import Foundation
import CoreLocation

class AdParametersFactory {
    public static func fromMap(map: [String: Any?]) -> AdParameters {
        let rawAge = map["age"]
        var age: NSNumber?
        
        if (rawAge is NSString) {
            age = NSNumber(value: (rawAge as! NSString).integerValue)
        }
        
        let rawContextTags = map["context_tags"]
        var contextTags: [String]? = nil
        
        if (rawContextTags is [Any?]) {
            contextTags = []
            
            for (tag) in (rawContextTags as! [Any?]) {
                if (tag is String) {
                    contextTags!.append(tag as! String)
                }
            }
        }
        
        let rawLocation = map["location"]
        var location: CLLocation? = nil
        
        if (rawLocation is [String: String]) {
            let latitude = rawLocation["latitude"]
        }
        
        return AdParameters(
            age: age,
            biddingData: map["bidding_data"] as! String?,
            contextQuery: map["context_query"] as! String?,
            contextTags: contextTags,
            gender: map["gender"] as! String?,
            location: <#T##CLLocation?#>,
            custom: [String : String]?
        )
    }
}
