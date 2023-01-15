//
//  YMAMutableAdRequestFactory.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 15.01.2023.
//

import Foundation
import YandexMobileAds

class YMAAdRequestFactory {
    static func fromAdParameters(parameters: AdParameters) -> YMAAdRequest {
        let request = YMAMutableAdRequest()
        
        request.age = parameters.age
        request.location = parameters.location
        request.parameters = parameters.custom
        request.contextTags = parameters.contextTags
        request.contextQuery = parameters.contextQuery
        request.biddingData = parameters.biddingData
        request.gender = parameters.gender
        request.headerBiddingData = parameters.headerBiddingData
        
        return request
    }
}
