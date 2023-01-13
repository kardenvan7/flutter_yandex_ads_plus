//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerAdViewArgumentsFactory {
    
    public static func fromMap(args: [String: Any?]) -> BannerYandexAdViewArguments {
            var uid = args["uid"]
        
            if (!(uid is String)) {
                PluginLogger.log(
                    message: "Argument \"uid\" is not valid"
                )
            }
        
            var adId = args["ad_id"]
        
            if (!(adId is String)) {
                PluginLogger.log(
                    message: "Argument \"ad_id\" is not valid"
                )
            }
        
            var height = args["height"]

            if (!(height is Int)) {
                PluginLogger.log(
                    message: "Argument \"height\" is not valid"
                )
            }
        
            var width = args["width"]

            if (!(width is Int)) {
                PluginLogger.log(
                    message: "Argument \"width\" is not valid"
                )
            }

            return BannerYandexAdViewArguments(
                uid: uid as! String,
                adId: adId as! String,
                height: height as! Int,
                width: width as! Int,
                additionalParams: args["additional_load_parameters"] as? [String: String],
                settings: BannerAdViewSettingsFactory.fromMap(
                    map: args["settings"] as! [String: Any?]
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
