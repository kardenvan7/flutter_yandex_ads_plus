//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerYandexAdViewArguments {
    let viewUid: String!
    let adUid: String!
    let height: Int
    let width: Int
    let additionalLoadParams: [String: String]?
    let settings: BannerYandexAdViewSettings

    init(
        viewUid: String,
        adUid: String,
        height: Int,
        width: Int,
        additionalParams: [String: String]?,
        settings: BannerYandexAdViewSettings
    ) {
        self.viewUid = viewUid
        self.adUid = adUid
        self.height = height
        self.width = width
        self.additionalLoadParams = additionalParams
        self.settings = settings
    }
}
