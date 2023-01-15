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
        return AdParameters(
            age: parseAgeFromJson(json: map["age"] as Any?),
            biddingData: map["bidding_data"] as? String,
            headerBiddingData: map["headers_bidding_data"] as? String,
            contextQuery: map["context_query"] as? String,
            contextTags: parseContextTagsListFromJson(
                json: map["context_tags"] as Any?
            ),
            gender: map["gender"] as? String,
            location: parseCLLocationFromJson(json: map["location"] as Any?),
            custom: parseCustomParametersFromJson(
                json: map["custom"] as Any?
            )
        )
    }
    
    private static func parseCustomParametersFromJson(json: Any?)
        -> [String: String]? {
        var custom: [String: String]? = nil
        
        if (json is [String : Any?]) {
            custom = [:]
                
            for (key, value) in (json as! [String: Any?]) {
                if (value is String) {
                    custom![key] = value as? String
                }
            }
        }
        
        return custom
    }
    
    private static func parseContextTagsListFromJson(json: Any?) -> [String]? {
        var contextTags: [String]? = nil
        
        if (json is [Any?]) {
            contextTags = []
            
            for (tag) in (json as! [Any?]) {
                if (tag is String) {
                    contextTags!.append(tag as! String)
                }
            }
        }
        
        return contextTags
    }
    
    private static func parseCLLocationFromJson(json: Any?) -> CLLocation? {
        var location: CLLocation? = nil
        
        if (json is [String: Any?]) {
            location = CLLocationFactory.fromMap(
                map: json as! [String: Any?]
            )
        }
        
        return location
    }
    
    private static func parseAgeFromJson(json: Any?) -> NSNumber? {
        var age: NSNumber?
        
        if (json is Int) {
            age = NSNumber(value: json as! Int)
        }
        
        return age
    }
}
