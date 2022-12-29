//
//  AdEvent.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class AdEvent {
    private let viewUid: String
    private let type: String
    private let parameters: [String: Any?]?

    init(
        viewUid: String,
        type: String,
        parameters: [String: Any?]? = nil
    ) {
        self.viewUid = viewUid
        self.type = type
        self.parameters = parameters
    }
    
    func toMap() -> [String: Any?] {
        return [
            "view_uid": viewUid,
            "type": type,
            "parameters": parameters
        ]
    }
}
