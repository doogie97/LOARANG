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
    
    private let imageBaseURL = "https://cdn-lostark.game.onstove.com/"
    
    func decode(info: String) -> UserJsonInfo? {
        guard let data = info.data(using: .utf8) else { return nil }
        let json = JSON(data)
        let cardJson = JSON(json["Card"]).sortedUp
        let cardSetJson = JSON(json["CardSet"]).sortedUp
        let gemJson: [JSON] = JSON(json["Equip"]).getInfo(of: "Gem")
        
        let cards = getCardInfo(cardJson)
        let effects = getCardSetEffect(cardSetJson)
        let cardInfo = CardInfo(cards: cards, effects: effects)
//        let gems = getGemInfo(gemJson)
        return UserJsonInfo(cardInfo: cardInfo)
    }
    
    private func getCardInfo(_ json: [JSON]) -> [Card] {
        let cards: [Card] = json.compactMap {
            return Card(name: $0["Element_000"]["value"].stringValue.centerName,
                        tierGrade: $0["Element_001"]["value"]["tierGrade"].intValue,
                        awakeCount: $0["Element_001"]["value"]["awakeCount"].intValue,
                        awakeTotal: $0["Element_001"]["value"]["awakeTotal"].intValue,
                        imageURL: imageBaseURL + $0["Element_001"]["value"]["iconData"]["iconPath"].stringValue)
        }
        return cards
    }
    
    private func getCardSetEffect(_ json: [JSON]) -> [CardSetEffect] {
        var cardSetEffects: [CardSetEffect] = []
        
        for card in json {
            var effects = card.sortedUp.compactMap { effect in
                CardSetEffect(desc: effect["desc"].stringValue,
                              title: effect["title"].stringValue)
            }
            
            let _ = effects.popFirst()
            cardSetEffects.append(contentsOf: effects)
        }
        
        return cardSetEffects
    }
    
//    private func getGemInfo(_ json: [JSON]) -> [Gem] {
//
//    }
}
