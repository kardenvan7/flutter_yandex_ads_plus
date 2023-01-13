//
//  AdEvent.swift
//  flutter_yandex_ads_plus
//
//  Created by apple on 30.12.2022.
//

import Foundation

class AdEvent {
    private let uid: String
    private let type: String
    private let parameters: [String: Any?]?

    init(
        uid: String,
        type: String,
        parameters: [String: Any?]? = nil
    ) {
        self.uid = uid
        self.type = type
        self.parameters = parameters
    }
    
    func toMap() -> [String: Any?] {
        return [
            "uid": uid,
            "type": type,
            "parameters": parameters
        ]
    }
}
