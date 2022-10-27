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
    
    init(
        id: String,
        height: Int,
        width: Int,
        theme: NativeAdViewTheme
    ) {
        self.id = id
        self.height = height
        self.width = width
        self.theme = theme
    }
}
