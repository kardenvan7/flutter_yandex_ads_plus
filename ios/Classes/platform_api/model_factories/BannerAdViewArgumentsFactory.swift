//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerAdViewArgumentsFactory {
    
    public static func fromMap(args: [String: Any?]) -> BannerYandexAdViewArguments {
            var viewUid = args["view_uid"]
        
            if (!(viewUid is String)) {
                PluginLogger.log(
                    message: "Argument \"view_uid\" is not valid"
                )
            }
        
            var adUid = args["ad_uid"]
        
            if (!(adUid is String)) {
                PluginLogger.log(
                    message: "Argument \"ad_uid\" is not valid"
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
                viewUid: viewUid as! String,
                adUid: adUid as! String,
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
