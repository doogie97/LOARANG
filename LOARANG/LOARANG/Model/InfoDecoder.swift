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
        
        let gemJson = JSON(json["Equip"]).gemInfo
        let equipmentInfo = JSON(json["Equip"])
        getEquipmentInfo(equipmentInfo)
        
        let cards = getCardInfo(cardJson)
        let effects = getCardSetEffect(cardSetJson)
        let cardInfo = CardInfo(cards: cards, effects: effects)
//        let gems = getGemInfo(gemJson)
        return UserJsonInfo(cardInfo: cardInfo)
        
        //전체 장비(아바타,악세 포함) json
        let equipmentJson = JSON(json["Equip"]).equipInfo
        //only 장비만
        let equipments = getEquipments(equipmentJson)
        
        //최종 적으로 UserJsonInfo에 들어갈 형태의 모든 장비들(현재는 only장비만 있으나 악세, 아바타도 추가예정)
        let equipmentInfo = EquipmentInfo(equipments: equipments)

        return UserJsonInfo(cardInfo: cardInfo, equipmenInfo: equipmentInfo)
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
    
    private func getEquipments(_ json: [(String, JSON)]) -> Equipments {       
        var head: EquipmentPart?
        var shoulder: EquipmentPart?
        var top: EquipmentPart?
        var bottom: EquipmentPart?
        var weapon: EquipmentPart?
        
        for info in json {
            if info.0.contains(EquimentIndex.head.rawValue) {
                head = info.1.equipmentPart
            } else if info.0.contains(EquimentIndex.shoulder.rawValue) {
                shoulder = info.1.equipmentPart
            } else if info.0.contains(EquimentIndex.top.rawValue) {
                top = info.1.equipmentPart
            } else if info.0.contains(EquimentIndex.bottom.rawValue) {
                bottom = info.1.equipmentPart
            } else if info.0.contains(EquimentIndex.weapon.rawValue) {
                weapon = info.1.equipmentPart
            }
        }

        return Equipments(haed: head, shoulder: shoulder, top: top, bottom: bottom, weapon: weapon)
    }
}
