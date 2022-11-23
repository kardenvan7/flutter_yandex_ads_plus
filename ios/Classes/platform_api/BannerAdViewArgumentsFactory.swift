//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerAdViewArgumentsFactory {
    
    public static func fromMap(args: [String: Any?]) -> BannerAdViewArguments {
            return BannerAdViewArguments(
                id: args["ad_id"] as! String,
                height: args["height"] as! Int?,
                width: args["width"] as! Int?,
                additionalParams: args["additional_load_parameters"] as? [String: String],
                settings: BannerAdViewSettingsFactory.fromMap(
                    map: args["settings"] as! [String: Any?]
                )
            )
        }
    
    class BannerAdViewSettingsFactory {
        public static func fromMap(map: [String: Any?]) -> BannerAdViewSettings {
            return BannerAdViewSettings(
                translatesAutoresizingMaskIntoConstraints:
                    map[
                        "translates_auto_resizing_mask_into_constraints"
                    ] as! Bool
            )
        }
    }
}
