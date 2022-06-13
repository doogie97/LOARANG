//
//  InfoDecoder.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/13.
//
import SwiftyJSON

struct InfoDecoder {
    static func decode(info: String) {
        guard let data = info.data(using: .utf8) else { return }
        let json = JSON(data)
        let items = JSON(json["Equip"])
        for i in items {
            print(i.1["Element_000"]["value"])
        }
    }
}
