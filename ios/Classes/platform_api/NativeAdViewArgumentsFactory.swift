//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation
import UIKit

class NativeAdViewArgumentsFactory {
    public static func fromMap(args: [String: Any?]) -> NativeAdViewArguments {
            return NativeAdViewArguments(
                id: args["ad_id"] as! String,
                height: args["height"] as! Int,
                width: args["width"] as! Int,
                theme: NativeAdViewThemeFactory.fromMap(
                    map: args["theme"] as! [String: Any?]
                )
            )
        }
    
    class NativeAdViewThemeFactory {
        public static func fromMap(map: [String: Any?]) -> NativeAdViewTheme {
            return NativeAdViewTheme(
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
                NativeAdViewTheme.NativeAdLabelTheme {
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
                    
                    return NativeAdViewTheme.NativeAdLabelTheme(
                        font: font,
                        color: color
                    )
                }
        }
        
        class NativeAdBannerThemeFactory {
            public static func fromMap(map: [String: Any?]) -> NativeAdViewTheme.NativeAdBannerTheme {
                let backgroundColor: UIColor = UIColor(
                    hexString: map["background_color"] as! String,
                    defaultColor: UIColor.white.withAlphaComponent(0)
                )
                let borderColor: UIColor = UIColor(
                    hexString: map["border_color"] as! String,
                    defaultColor: UIColor.white.withAlphaComponent(0)
                )
                
                
                return NativeAdViewTheme.NativeAdBannerTheme(
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
            NativeAdViewTheme.NativeAdButtonTheme {
                return NativeAdViewTheme.NativeAdButtonTheme(
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
            NativeAdViewTheme.NativeAdRatingTheme {
                return NativeAdViewTheme.NativeAdRatingTheme(
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
