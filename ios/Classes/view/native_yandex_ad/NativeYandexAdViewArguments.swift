//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class NativeYandexAdViewArguments {
    let uid: String
    let adUid: String
    let height: Int
    let width: Int
    let theme: NativeYandexAdViewTheme
    let additionalParameters: [String: String]?
    
    init(
        uid: String,
        adId: String,
        height: Int,
        width: Int,
        theme: NativeYandexAdViewTheme,
        additionalParameters: [String: String]?
    ) {
        self.uid = uid
        self.adUid = adId
        self.height = height
        self.width = width
        self.theme = theme
        self.additionalParameters = additionalParameters
    }
}
