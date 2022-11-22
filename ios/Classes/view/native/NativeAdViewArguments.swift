//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class NativeAdViewArguments {
    let id: String!
    let height: Int
    let width: Int
    let theme: NativeAdViewTheme
    let additionalParameters: [String: String]?
    
    init(
        id: String,
        height: Int,
        width: Int,
        theme: NativeAdViewTheme,
        additionalParameters: [String: String]?
    ) {
        self.id = id
        self.height = height
        self.width = width
        self.theme = theme
        self.additionalParameters = additionalParameters
    }
}
