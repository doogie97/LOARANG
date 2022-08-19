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
        
        var head: BattleEquipmentPart?
        var shoulder: BattleEquipmentPart?
        var top: BattleEquipmentPart?
        var bottom: BattleEquipmentPart?
        var gloves: BattleEquipmentPart?
        var weapon: BattleEquipmentPart? // 무기는 무기만의 로직을 따로 만들어야함 why? 에스더 무기 때문에
        
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
            }
        }
        let battleEquipments = BattleEquipments(head: head, shoulder: shoulder, top: top, bottom: bottom, gloves: gloves, weapon: nil)
        return Equipments(battleEquipments: battleEquipments, avatar: nil)
    }
    
    private func getBattleEquipmentPart(_ json: JSON) -> BattleEquipmentPart {
        let isFullLv = json["Element_007"]["type"].stringValue != "Progress"
        
        let basicEffects = BasicEffects(basicEffect: json["Element_005"]["value"]["Element_000"].stringValue
                                        + "<BR>" + json["Element_005"]["value"]["Element_001"].stringValue,
                                        aditionalEffect: json["Element_006"]["value"]["Element_000"].stringValue
                                        + "<BR>" + json["Element_006"]["value"]["Element_001"].stringValue)
        
        let effects = SetEffects.Effects(
            firstSetEffect: json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_001"]["topStr"].stringValue + "<BR>" + json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_001"]["contentStr"]["Element_000"]["contentStr"].stringValue,
            secondSetEffect: json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_002"]["topStr"].stringValue + "<BR>" + json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_002"]["contentStr"]["Element_000"]["contentStr"].stringValue,
            thirdSetEffect: json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_003"]["topStr"].stringValue + "<BR>" + json["Element_\("008".threeNum(isFullLv))"]["value"]["Element_003"]["contentStr"]["Element_000"]["contentStr"].stringValue)
        
        let setEffect = SetEffects(setEffectLv: json["Element_\("007".threeNum(isFullLv))"]["value"]["Element_000"].stringValue
                                   + "<BR>" + json["Element_\("007".threeNum(isFullLv))"]["value"]["Element_001"].stringValue,
                                   effects: effects)
        
        return BattleEquipmentPart(name: json["Element_000"]["value"].stringValue,
                                   part: json["Element_001"]["value"]["leftStr0"].stringValue,
                                   lv: json["Element_001"]["value"]["leftStr2"].stringValue,
                                   quality: json["Element_001"]["value"]["qualityValue"].intValue,
                                   grade: json["Element_001"]["value"]["slotData"]["iconGrade"].intValue,
                                   imageURL: imageBaseURL + json["Element_001"]["value"]["slotData"]["iconPath"].stringValue,
                                   basicEffects: basicEffects,
                                   estherEffect: nil ,//일단 nil
                                   setEffects: setEffect)
    }
}
