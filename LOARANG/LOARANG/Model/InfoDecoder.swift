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
    
    private func getCardInfo(json: JSON) -> [Card] {
        let cardArray = json.sortedUp
        let cards = cardArray.compactMap {
            Card(name: $0["Element_000"]["value"].stringValue,
                 awakeCount: $0["Element_001"]["value"]["awakeCount"].intValue,
                 awakeTotal: $0["Element_001"]["value"]["awakeTotal"].intValue)
        }
        
        let userCards = CardInfo(first: carddd.popFirst() , second: carddd.popFirst(), third: carddd.popFirst(), fourth: carddd.popFirst(), fifth: carddd.popFirst(), sixth: carddd.popFirst())
        
        return userCards
    }
}
