//
//  JsonInfoManager.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/18.
//

import SwiftyJSON

struct JsonInfoManager {
    private let jsonInfo: JSON
    private let imageBaseURL = "https://cdn-lostark.game.onstove.com/"
    
    init(jsonString: String) throws {
        guard let jsonInfo = jsonString.data(using: .utf8) else {
            throw CrawlError.jsonInfoError
        }
        
        self.jsonInfo = JSON(jsonInfo)
    }
    
    func getEquipmentsInfo() -> Equipments { //battleEquipments 반환
        let eqJson = JSON(jsonInfo["Equip"])
        
        let equipmentsJsons: [(title: String, json: JSON)] = eqJson.compactMap { (title, JSON) in
            if !title.contains("Gem") {
                return (title, JSON)
            }
            return nil
        }
        
        var head: EquipmentPart?
        var shoulder: EquipmentPart?
        var top: EquipmentPart?
        var bottom: EquipmentPart?
        var gloves: EquipmentPart?
        var weapon: EquipmentPart?
        
        for info in equipmentsJsons {
            if info.title.contains(EquimentIndex.head.rawValue) {
                head = getBattleEquipmentPart(info.json)
            } else if info.title.contains(EquimentIndex.shoulder.rawValue) {
                shoulder = getBattleEquipmentPart(info.json)
            } else if info.title.contains(EquimentIndex.top.rawValue) {
                top = getBattleEquipmentPart(info.json)
            } else if info.title.contains(EquimentIndex.bottom.rawValue) {
                bottom = getBattleEquipmentPart(info.json)
            } else if info.title.contains(EquimentIndex.glove.rawValue) {
                gloves = getBattleEquipmentPart(info.json)
            } else if info.title.contains(EquimentIndex.weapon.rawValue) {
                weapon = getBattleEquipmentPart(info.json)
            }
        }
        let battleEquipments = BattleEquipments(head: head, shoulder: shoulder, top: top, bottom: bottom, gloves: gloves, weapon: weapon, necklace: nil, firstEarring: nil, secondEarring: nil, firstRing: nil, secondRing: nil, abilityStone: nil, bracelet: nil)
        return Equipments(battleEquipments: battleEquipments, avatar: nil)
    }
    
    //MARK: - 전투 장비
    private func getEquipmentBasicInfo(_ json: JSON) -> EquipmentBasicInfo {
        return EquipmentBasicInfo(name: json["Element_000"]["value"].stringValue,
                                  part: json["Element_001"]["value"]["leftStr0"].stringValue,
                                  lv: json["Element_001"]["value"]["leftStr2"].stringValue,
                                  quality: json["Element_001"]["value"]["qualityValue"].intValue,
                                  grade: json["Element_001"]["value"]["slotData"]["iconGrade"].intValue,
                                  imageURL: imageBaseURL + json["Element_001"]["value"]["slotData"]["iconPath"].stringValue)
    }
    
    private func getBattleEquipmentPart(_ json: JSON) -> EquipmentPart {
        return EquipmentPart(basicInfo: getEquipmentBasicInfo(json),
                             battleEffects: getBattleEffects(json))
    }
    
    //MARK: - 전투 장비 효과
    private func getBattleEffects(_ json: JSON) -> String {
        let isEsther = json["Element_001"]["value"]["slotData"]["iconGrade"].intValue == 7
        
        let basicEffect = json["Element_005"]["value"]["Element_000"].stringValue
        + "<BR>" + json["Element_005"]["value"]["Element_001"].stringValue + "<BR><BR>"
        
        let aditionalEffect = json["Element_006"]["value"]["Element_000"].stringValue
        + "<BR>" + json["Element_006"]["value"]["Element_001"].stringValue + "<BR><BR>"
        
        if isEsther {
            let estherEffects = getEstherEffect(json)

            return basicEffect + aditionalEffect + estherEffects
        } else {
            let setEffects = getSetEffect(json)

            return basicEffect + aditionalEffect + setEffects
        }
    }
    
    private func getEstherEffect(_ json: JSON) -> String {
        let topStr = json["Element_007"]["value"]["Element_000"]["topStr"].stringValue
        let firstEffect = "• " + json["Element_007"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue
        let secondEffect = "• " + json["Element_007"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue
        let setEffect = json["Element_008"]["value"]["Element_000"].stringValue + "<BR>" + json["Element_008"]["value"]["Element_001"].stringValue
        
        return topStr + "<BR>" + firstEffect + "<BR>" + secondEffect + "<BR><BR>" + setEffect
    }
    
    private func getSetEffect(_ json: JSON) -> String {
        let isFullLv = json["Element_007"]["type"].stringValue != "Progress"
        
        let setEffectLv = json["Element_\("007".threeNum(isFullLv))"]["value"]["Element_000"].stringValue
        + "<BR>" + json["Element_\("007".threeNum(isFullLv))"]["value"]["Element_001"].stringValue
        
        let firstSetEffect = json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_001"]["topStr"].stringValue + "<BR>" + json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_001"]["contentStr"]["Element_000"]["contentStr"].stringValue
        
        let secondSetEffect = json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_002"]["topStr"].stringValue + "<BR>" + json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_002"]["contentStr"]["Element_000"]["contentStr"].stringValue
        
        let thirdSetEffect = json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_003"]["topStr"].stringValue + "<BR>" + json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_003"]["contentStr"]["Element_000"]["contentStr"].stringValue
        
        return setEffectLv + "<BR><BR>" + firstSetEffect + "<BR><BR>" + secondSetEffect + "<BR><BR>" + thirdSetEffect
    }
}
