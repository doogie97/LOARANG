//
//  InfoDecoder.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/13.
//
import SwiftyJSON

struct InfoDecoder {
    static let shared = InfoDecoder()
    private init() {}
    
        let json = JSON(data)
        let items = JSON(json["Equip"])
        for (index, sub) in items {
            if index.description.contains("Gem"){
//                print(sub["Element_000"]["value"])
            } else {
                print(sub["Element_000"]["value"])
            }
        }
    }
}
