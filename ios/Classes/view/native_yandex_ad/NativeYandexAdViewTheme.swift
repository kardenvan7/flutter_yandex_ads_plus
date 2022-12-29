//
//  NativeAdViewTheme.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 27.10.2022.
//

import Foundation

class NativeYandexAdViewTheme {
    let titleStyle: NativeAdLabelTheme
    let bodyStyle: NativeAdLabelTheme
    let domainStyle: NativeAdLabelTheme
    let ageStyle: NativeAdLabelTheme
    let sponsoredStyle: NativeAdLabelTheme
    let reviewCountStyle: NativeAdLabelTheme
    let warningStyle: NativeAdLabelTheme
    let bannerTheme: NativeAdBannerTheme
    let buttonTheme: NativeAdButtonTheme
    let ratingTheme: NativeAdRatingTheme
    
    init(
        titleStyle: NativeAdLabelTheme,
        bodyStyle: NativeAdLabelTheme,
        domainStyle: NativeAdLabelTheme,
        ageStyle: NativeAdLabelTheme,
        sponsoredStyle: NativeAdLabelTheme,
        reviewCountStyle: NativeAdLabelTheme,
        warningStyle: NativeAdLabelTheme,
        bannerTheme: NativeAdBannerTheme,
        buttonTheme: NativeAdButtonTheme,
        ratingTheme: NativeAdRatingTheme
    ) {
        self.titleStyle = titleStyle
        self.bodyStyle = bodyStyle
        self.domainStyle = domainStyle
        self.ageStyle = ageStyle
        self.sponsoredStyle = sponsoredStyle
        self.reviewCountStyle = reviewCountStyle
        self.warningStyle = warningStyle
        self.bannerTheme = bannerTheme
        self.buttonTheme = buttonTheme
        self.ratingTheme = ratingTheme
    }
    
    class NativeAdLabelTheme {
        let font: UIFont
        let color: UIColor
        
        init(
            font: UIFont,
            color: UIColor
        ) {
            self.font = font
            self.color = color
        }
    }
    
    class NativeAdBannerTheme {
        let backgroundColor: UIColor
        let borderWidth: CGFloat
        let borderColor: UIColor
        let leftPadding: CGFloat
        let rightPadding: CGFloat
        
        init(
            backgroundColor: UIColor,
            borderWidth: CGFloat,
            borderColor: UIColor,
            leftPadding: CGFloat,
            rightPadding: CGFloat
        ) {
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.leftPadding = leftPadding
            self.rightPadding = rightPadding
        }
    }
    
    class NativeAdButtonTheme {
        let normalColor: UIColor
        let hightlightedColor: UIColor
        let borderWidth: CGFloat
        let borderColor: UIColor
        let textStyle: NativeAdLabelTheme

        init(
            normalColor: UIColor,
            hightlightedColor: UIColor,
            borderWidth: CGFloat,
            borderColor: UIColor,
            textStyle: NativeAdLabelTheme
        ) {
            self.normalColor = normalColor
            self.hightlightedColor = hightlightedColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.textStyle = textStyle
        }
    }
    
    class NativeAdRatingTheme {
        let emptyStarColor: UIColor
        let filledStarColor: UIColor
        let starSize: CGFloat
        
        init(
            emptyStarColor: UIColor,
            filledStarColor: UIColor,
            starSize: CGFloat
        ) {
            self.emptyStarColor = emptyStarColor
            self.filledStarColor = filledStarColor
            self.starSize = starSize
        }
    }
}
