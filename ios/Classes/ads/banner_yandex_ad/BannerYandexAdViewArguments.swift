//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerYandexAdViewArguments {
    let uid: String
    let adId: String
    let height: Int
    let width: Int
    let parameters: AdParameters?
    let settings: BannerYandexAdViewSettings

    init(
        uid: String,
        adId: String,
        height: Int,
        width: Int,
        parameters: AdParameters?,
        settings: BannerYandexAdViewSettings
    ) {
        self.uid = uid
        self.adId = adId
        self.height = height
        self.width = width
        self.parameters = parameters
        self.settings = settings
    }
}
