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
    
    func decode(info: String) -> CardInfo? {
        guard let data = info.data(using: .utf8) else { return nil }
        let json = JSON(data)
        let cardJson = JSON(json["Card"])
        return getCardInfo(json: cardJson)
    }
    
    private func getCardInfo(json: JSON) -> CardInfo {
        let cardArray = json.sorted { first, second in
            return first.0 < second.0
        }
        var carddd:[Card] = []
        for i in cardArray {
            let card = Card(name: i.1["Element_000"]["value"].stringValue,
                            awakeCount: i.1["Element_001"]["value"]["awakeCount"].intValue,
                            awakeTotal: i.1["Element_001"]["value"]["awakeTotal"].intValue)
            carddd.append(card)
        }
        
        let userCards = CardInfo(first: carddd.popFirst() , second: carddd.popFirst(), third: carddd.popFirst(), fourth: carddd.popFirst(), fifth: carddd.popFirst(), sixth: carddd.popFirst())
        
        return userCards
    }
}
