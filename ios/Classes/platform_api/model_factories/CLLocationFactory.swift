//
//  CLLocationFactory.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation
import CoreLocation

class CLLocationFactory {
    static func fromMap(map: [String: Any?]) -> CLLocation {
        let latitude = Double(map["latitude"] as! String)
        let longitude = Double(map["longitude"] as! String)
        
        return CLLocation(
            latitude: latitude!,
            longitude: longitude!
        )
    }
}
