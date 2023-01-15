//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation
import UIKit

class NativeAdViewArgumentsFactory {
    public static func fromMap(map: [String: Any?]) -> NativeYandexAdViewArguments {
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
                
        return NativeYandexAdViewArguments(
            uid: uid as! String,
            adId: adId as! String,
            height: height as! Int,
            width: width as! Int,
            theme: NativeAdViewThemeFactory.fromMap(
                map: map["theme"] as! [String: Any?]
            ),
            parameters: parameters
        )
    }
    
    class NativeAdViewThemeFactory {
        public static func fromMap(map: [String: Any?]) -> NativeYandexAdViewTheme {
            return NativeYandexAdViewTheme(
                titleStyle: NativeAdLabelThemeFactory.fromMap(
                    map: map["title_style"] as! [String: Any?]
                ),
                bodyStyle: NativeAdLabelThemeFactory.fromMap(
                    map: map["body_style"] as! [String: Any?]
                ),
                domainStyle: NativeAdLabelThemeFactory.fromMap(
                    map: map["domain_style"] as! [String: Any?]
                ),
                ageStyle: NativeAdLabelThemeFactory.fromMap(
                    map: map["age_style"] as! [String: Any?]
                ),
                sponsoredStyle: NativeAdLabelThemeFactory.fromMap(
                    map: map["sponsored_style"] as! [String: Any?]
                ),
                reviewCountStyle: NativeAdLabelThemeFactory.fromMap(
                    map: map["review_count_style"] as! [String: Any?]
                ),
                warningStyle: NativeAdLabelThemeFactory.fromMap(
                    map: map["warning_style"] as! [String: Any?]
                ),
                bannerTheme: NativeAdBannerThemeFactory.fromMap(
                    map: map["banner_theme"] as! [String: Any?]
                ),
                buttonTheme: NativeAdButtonThemeFactory.fromMap(
                    map: map["button_theme"] as! [String : Any?]
                ),
                ratingTheme: NativeAdRatingThemeFactory.fromMap(
                    map: map["rating_theme"] as! [String: Any?]
                )
            )
        }
        
        class NativeAdLabelThemeFactory {
            public static func fromMap(map: [String: Any?]) ->
                NativeYandexAdViewTheme.NativeAdLabelTheme {
                    let defaultFont = UIFont.systemFont(
                        ofSize: CGFloat((map["font_size"] as! Double))
                    )

                    let font: UIFont
                    
                    if (map["font_family"] as? String) != nil {
                        font = UIFont(
                            name: map["font_family"] as! String,
                            size: CGFloat(map["font_size"] as! Double)
                        ) ?? defaultFont
                    } else {
                        font = defaultFont
                    }
                    
                    let color = UIColor(
                            hexString: map["color"] as! String,
                            defaultColor: UIColor.black
                        )
                    
                    return NativeYandexAdViewTheme.NativeAdLabelTheme(
                        font: font,
                        color: color
                    )
                }
        }
        
        class NativeAdBannerThemeFactory {
            public static func fromMap(map: [String: Any?]) -> NativeYandexAdViewTheme.NativeAdBannerTheme {
                let backgroundColor: UIColor = UIColor(
                    hexString: map["background_color"] as! String,
                    defaultColor: UIColor.white.withAlphaComponent(0)
                )
                let borderColor: UIColor = UIColor(
                    hexString: map["border_color"] as! String,
                    defaultColor: UIColor.white.withAlphaComponent(0)
                )
                
                
                return NativeYandexAdViewTheme.NativeAdBannerTheme(
                    backgroundColor: backgroundColor,
                    borderWidth:
                        CGFloat(map["border_width"] as! Double),
                    borderColor: borderColor,
                    leftPadding: CGFloat(
                        map["left_padding"] as! Double
                    ),
                    rightPadding: CGFloat(
                        map["right_padding"] as! Double
                    )
                )
            }
        }
        
        class NativeAdButtonThemeFactory {
            public static func fromMap(map: [String: Any?]) ->
            NativeYandexAdViewTheme.NativeAdButtonTheme {
                return NativeYandexAdViewTheme.NativeAdButtonTheme(
                    normalColor: UIColor(
                        hexString: map["background_color"] as! String,
                        defaultColor: UIColor.white
                    ),
                    hightlightedColor: UIColor(
                        hexString: map["pressed_background_color"] as! String,
                        defaultColor: UIColor.gray
                    ),
                    borderWidth: CGFloat(
                        map["border_width"] as! Double
                    ),
                    borderColor: UIColor(
                        hexString: map["border_color"] as! String,
                        defaultColor: UIColor.black
                    ),
                    textStyle: NativeAdLabelThemeFactory.fromMap(map: map["text_style"] as! [String: Any?]
                    )
                )
            }
        }
        
        class NativeAdRatingThemeFactory {
            public static func fromMap(map: [String: Any?]) ->
            NativeYandexAdViewTheme.NativeAdRatingTheme {
                return NativeYandexAdViewTheme.NativeAdRatingTheme(
                   emptyStarColor: UIColor(
                        hexString: map["star_color"] as! String,
                        defaultColor: UIColor.gray
                   ),
                   filledStarColor: UIColor(
                        hexString: map["progress_star_color"] as! String,
                        defaultColor: UIColor.systemYellow
                   ),
                   starSize: CGFloat(map["star_size"] as! Double)
                )
            }
        }
    }
}
