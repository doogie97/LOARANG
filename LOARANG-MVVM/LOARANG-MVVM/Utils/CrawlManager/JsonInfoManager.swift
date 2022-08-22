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
    
    func getEquipmentsInfo() -> Equipments {
        
        let equipmentsJsons: [(title: String, json: JSON)] = JSON(jsonInfo["Equip"]).compactMap { (title, JSON) in
            if !title.contains("Gem") {
                return (title, JSON)
            }
            return nil
        }
        
        //전투 장비
        var head: EquipmentPart?
        var shoulder: EquipmentPart?
        var top: EquipmentPart?
        var bottom: EquipmentPart?
        var gloves: EquipmentPart?
        var weapon: EquipmentPart?
        //장신구
        var necklace: EquipmentPart?
        var firstEarring: EquipmentPart?
        var secondEarring: EquipmentPart?
        var firstRing: EquipmentPart?
        var secondRing: EquipmentPart?
        var bracelet: EquipmentPart?
        var abilityStone: EquipmentPart?
        //각인
        let equipedEngraves = getEngrave(JSON(jsonInfo["Engrave"]))
        
        for info in equipmentsJsons {
            //전투 장비
            if info.title.contains(EquimentIndex.head.rawValue) {
                head = getEquipmentPart(info.json, type: .battleEquipment)
            } else if info.title.contains(EquimentIndex.shoulder.rawValue) {
                shoulder = getEquipmentPart(info.json, type: .battleEquipment)
            } else if info.title.contains(EquimentIndex.top.rawValue) {
                top = getEquipmentPart(info.json, type: .battleEquipment)
            } else if info.title.contains(EquimentIndex.bottom.rawValue) {
                bottom = getEquipmentPart(info.json, type: .battleEquipment)
            } else if info.title.contains(EquimentIndex.glove.rawValue) {
                gloves = getEquipmentPart(info.json, type: .battleEquipment)
            } else if info.title.contains(EquimentIndex.weapon.rawValue) {
                weapon = getEquipmentPart(info.json, type: .battleEquipment)
            //장신구
            } else if info.title.contains(EquimentIndex.necklace.rawValue) {
                necklace = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.firstEarring.rawValue) {
                firstEarring = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.secondEarring.rawValue) {
                secondEarring = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.firstRing.rawValue) {
                firstRing = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.secondRing.rawValue) {
                secondRing = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.bracelet.rawValue) {
                bracelet = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.abilityStone.rawValue) {
                abilityStone = getEquipmentPart(info.json, type: .accessory)
            }
        }
        let battleEquipments = BattleEquipments(head: head, shoulder: shoulder, top: top, bottom: bottom, gloves: gloves, weapon: weapon, necklace: necklace, firstEarring: firstEarring, secondEarring: secondEarring, firstRing: firstRing, secondRing: secondRing, bracelet: bracelet, abilityStone: abilityStone, engrave: equipedEngraves)
        return Equipments(battleEquipments: battleEquipments, avatar: nil)
    }
    
    //MARK: - 전투 장비 & 장신구
    private func getEquipmentPart(_ json: JSON, type: EquipmentType) -> EquipmentPart {
        var battleEffects: String? {
            switch type {
            case .battleEquipment:
                return getBattleEffects(json)
            case .accessory:
                return getAccesaryEffects(json)
            case .avatar:
                return nil
            }
        }
        return EquipmentPart(basicInfo: getEquipmentBasicInfo(json),
                             battleEffects: battleEffects)
    }
    
    private func getEquipmentBasicInfo(_ json: JSON) -> EquipmentBasicInfo {
        return EquipmentBasicInfo(name: json["Element_000"]["value"].stringValue,
                                  part: json["Element_001"]["value"]["leftStr0"].stringValue,
                                  lv: json["Element_001"]["value"]["leftStr2"].stringValue,
                                  quality: json["Element_001"]["value"]["qualityValue"].intValue,
                                  grade: json["Element_001"]["value"]["slotData"]["iconGrade"].intValue,
                                  imageURL: imageBaseURL + json["Element_001"]["value"]["slotData"]["iconPath"].stringValue)
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
    //MARK: - 장신구 효과
    private func getAccesaryEffects(_ json: JSON) -> String {
        let basicEffect = json["Element_004"]["value"]["Element_000"].stringValue
        + "<BR>" + json["Element_004"]["value"]["Element_001"].stringValue + "<BR><BR>"
        
        let aditionalEffect = json["Element_005"]["value"]["Element_000"].stringValue
        + "<BR>" + json["Element_005"]["value"]["Element_001"].stringValue + "<BR><BR>"
        
        let engravigs = json["Element_006"]["value"]["Element_000"].stringValue
        + "<BR>" + json["Element_006"]["value"]["Element_001"].stringValue
        
        return basicEffect + aditionalEffect + engravigs
    }
    
    //MARK: - 장착 각인
    private func getEngrave(_ json: JSON) -> (EquipedEngrave?, EquipedEngrave?) {
        var firstEngraves: EquipedEngrave?
        var secondEngraves: EquipedEngrave?
        for engrave in json {
            if engrave.0.contains("000") {
                firstEngraves = EquipedEngrave(name: engrave.1["Element_000"]["value"].stringValue,
                                               activation: engrave.1["Element_001"]["value"]["leftText"].stringValue,
                                               imageURL: imageBaseURL + engrave.1["Element_001"]["value"]["slotData"]["iconPath"].stringValue)
            } else if engrave.0.contains("001") {
                secondEngraves = EquipedEngrave(name: engrave.1["Element_000"]["value"].stringValue,
                                                activation: engrave.1["Element_001"]["value"]["leftText"].stringValue,
                                                imageURL: imageBaseURL + engrave.1["Element_001"]["value"]["slotData"]["iconPath"].stringValue)
            }
        }
        
        return (firstEngraves, secondEngraves)
    }
}
