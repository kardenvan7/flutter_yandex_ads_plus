//
//  NativeAdTemplateAppearanceFactory.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 27.10.2022.
//

import Foundation
import YandexMobileAds


class NativeAdTemplateAppearanceFactory {
    public static func fromTheme(theme: NativeAdViewTheme) -> YMANativeTemplateAppearance {
        let appearance = YMAMutableNativeTemplateAppearance.default()

        appearance.backgroundColor = theme.bannerTheme.backgroundColor
        appearance.contentPadding = YMAHorizontalOffset(
            left: theme.bannerTheme.leftPadding,
            right: theme.bannerTheme.rightPadding
        )
        appearance.borderColor = theme.bannerTheme.borderColor
        appearance.borderWidth = theme.bannerTheme.borderWidth

        appearance.titleAppearance = YMALabelAppearanceFactory.fromTheme(
            theme: theme.titleStyle
        )

        appearance.bodyAppearance = YMALabelAppearanceFactory.fromTheme(
            theme: theme.bodyStyle
        )

        appearance.domainAppearance = YMALabelAppearanceFactory.fromTheme(
            theme: theme.domainStyle
        )
        
        appearance.callToActionAppearance = YMAButtonAppearanceFactory.fromTheme(
            theme: theme.buttonTheme
        )
        
        appearance.ratingAppearance = YMARatingAppearanceFactory.fromTheme(
            theme: theme.ratingTheme
        )
        
        return appearance
    }
    
    class YMALabelAppearanceFactory {
        public static func fromTheme(
            theme: NativeAdViewTheme.NativeAdLabelTheme
        ) -> YMALabelAppearance {
            return YMALabelAppearance(
                font: theme.font,
                textColor: theme.color
            )
        }
    }
    
    class YMAButtonAppearanceFactory {
        public static func fromTheme(
            theme: NativeAdViewTheme.NativeAdButtonTheme
        ) -> YMAButtonAppearance {
            return YMAButtonAppearance(
                textAppearance: YMALabelAppearanceFactory.fromTheme(
                    theme: theme.textStyle
                ),
                normalColor: theme.normalColor,
                highlightedColor: theme.hightlightedColor,
                borderColor: theme.borderColor,
                borderWidth: theme.borderWidth
            )
        }
    }
    
    class YMARatingAppearanceFactory {
        public static func fromTheme(
            theme: NativeAdViewTheme.NativeAdRatingTheme
        ) -> YMARatingAppearance {
            return YMARatingAppearance(
                emptyStarColor: theme.emptyStarColor,
                filledStarColor: theme.filledStarColor,
                starSize: theme.starSize
            )
        }
    }
}
