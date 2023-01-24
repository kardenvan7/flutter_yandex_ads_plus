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
    let parameters: AdParameters?
    
    init(
        uid: String,
        adId: String,
        height: Int,
        width: Int,
        theme: NativeYandexAdViewTheme,
        parameters: AdParameters?
    ) {
        self.uid = uid
        self.adUid = adId
        self.height = height
        self.width = width
        self.theme = theme
        self.parameters = parameters
    }
}
