//
//  BannerViewArguments.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 21.10.2022.
//

import Foundation

class BannerAdViewArguments {
    let id: String!
    let height: Int?
    let width: Int?
    let additionalLoadParams: [String: String]?

    init(
        id: String,
        height: Int?,
        width: Int?,
        additionalParams: [String: String]?
    ) {
        self.id = id
        self.height = height
        self.width = width
        self.additionalLoadParams = additionalParams
    }
}
