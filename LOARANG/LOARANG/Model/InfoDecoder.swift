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
        let cardSetJson = JSON(json["CardSet"])
        
        let cards = getCardInfo(json: cardJson)
        let effects = getCardSetEffect(json: cardSetJson)
        return CardInfo(cards: cards, effect: effects)
    }
    
    private func getCardInfo(json: JSON) -> [Card] {
        let cardArray = json.sortedUp
        let cards: [Card] = cardArray.compactMap {
            return Card(name: $0["Element_000"]["value"].stringValue.centerName,
                        tierGrade: $0["Element_001"]["value"]["tierGrade"].intValue,
                        awakeCount: $0["Element_001"]["value"]["awakeCount"].intValue,
                        awakeTotal: $0["Element_001"]["value"]["awakeTotal"].intValue)
        }
        return cards
    }
    
    private func getCardSetEffect(json: JSON) -> [CardSetEffect] {
        var cardSetEffects: [CardSetEffect] = []
        
        let cardArray = json.sortedUp
        for card in cardArray {
            var effects = card.sortedUp.compactMap { effect in
                CardSetEffect(desc: effect["desc"].stringValue,
                              title: effect["title"].stringValue)
            }
            
            let _ = effects.popFirst()
            cardSetEffects.append(contentsOf: effects)
        }
        
        return cardSetEffects
    }
}
