//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class NativeYandexAdViewArguments {
    let viewUid: String
    let adUid: String
    let height: Int
    let width: Int
    let theme: NativeYandexAdViewTheme
    let additionalParameters: [String: String]?
    
    init(
        viewUid: String,
        adUid: String,
        height: Int,
        width: Int,
        theme: NativeYandexAdViewTheme,
        additionalParameters: [String: String]?
    ) {
        self.viewUid = viewUid
        self.adUid = adUid
        self.height = height
        self.width = width
        self.theme = theme
        self.additionalParameters = additionalParameters
    }
}
