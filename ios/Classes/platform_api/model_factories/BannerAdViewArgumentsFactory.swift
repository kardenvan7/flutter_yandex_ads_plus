//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerAdViewArgumentsFactory {
    
    public static func fromMap(map: [String: Any?]) -> BannerYandexAdViewArguments {
        let uid = map["uid"]
    
        if (!(uid is String)) {
            PluginLogger.log(
                message: "Argument \"uid\" is not valid"
            )
        }
    
        let adId = map["ad_id"]
    
        if (!(adId is String)) {
            PluginLogger.log(
                message: "Argument \"ad_id\" is not valid"
            )
        }
    
        let height = map["height"]

        if (!(height is Int)) {
            PluginLogger.log(
                message: "Argument \"height\" is not valid"
            )
        }
    
        let width = map["width"]

        if (!(width is Int)) {
            PluginLogger.log(
                message: "Argument \"width\" is not valid"
            )
        }
    
        let rawParameters = map["parameters"]
        var parameters: AdParameters? = nil
        
        if (rawParameters is [String:Any?]) {
            parameters = AdParametersFactory.fromMap(
                map: map["parameters"] as! [String: Any?]
            )
        }

        return BannerYandexAdViewArguments(
            uid: uid as! String,
            adId: adId as! String,
            height: height as! Int,
            width: width as! Int,
            parameters: parameters,
            settings: BannerAdViewSettingsFactory.fromMap(
                map: map["settings"] as! [String: Any?]
            )
        )
    }
    
    class BannerAdViewSettingsFactory {
        public static func fromMap(map: [String: Any?]) -> BannerYandexAdViewSettings {
            return BannerYandexAdViewSettings(
                translatesAutoresizingMaskIntoConstraints:
                    map[
                        "translates_auto_resizing_mask_into_constraints"
                    ] as! Bool
            )
        }
    }
}
