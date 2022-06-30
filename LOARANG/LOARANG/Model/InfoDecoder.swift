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
        let cards = getCardInfo(cardJson)
        let effects = getCardSetEffect(cardSetJson)
        
        let cardInfo = CardInfo(cards: cards, effects: effects)
        
        let eqJson = JSON(json["Equip"])
        let equipmentInfo = getWholeEquipments(eqJson)

        return UserJsonInfo(cardInfo: cardInfo, equipmenInfo: equipmentInfo)
    }
    
    private func getCardInfo(_ json: [JSON]) -> [Card] {
        let cards: [Card] = json.compactMap {
            return Card(name: $0["Element_000"]["value"].stringValue.centerNameOne,
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
    
    private func getWholeEquipments(_ json: JSON) -> EquipmentInfo {
        let equipments = getOnlyEquipments(json.equipInfo)
        let gems = getGemInfo(json.gemInfo)
        
        return EquipmentInfo(equipments: equipments, gems: gems)
    }
    
    private func getOnlyEquipments(_ json: [(String, JSON)]) -> Equipments {
        //여기서 장비 뿐만 아니라 아바타 등등 다가져와야함 그니까 Equipments의 프로퍼티가 많아져야함
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
    
    private func getGemInfo(_ json: [JSON]) -> [Gem] {
        let gems: [Gem] = json.compactMap {
            return Gem(name: $0["Element_000"]["value"].stringValue.centerNameOne,
                       grade: $0["Element_001"]["value"]["slotData"]["iconGrade"].intValue,
                       lvString: $0["Element_001"]["value"]["slotData"]["rtString"].stringValue,
                       effect: $0["Element_004"]["value"]["Element_001"].stringValue.centerNameOne)
        }
        return gems
    }
}
