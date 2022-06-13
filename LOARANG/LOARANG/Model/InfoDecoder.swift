//
//  InfoDecoder.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/13.
//

import Foundation

struct InfoDecoder {
    static func decode(info: String) {
        guard let data = info.data(using: .utf8) else { return }
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
            if let info = json["Card"] {
                print(info)
            }
        }
    }
}
