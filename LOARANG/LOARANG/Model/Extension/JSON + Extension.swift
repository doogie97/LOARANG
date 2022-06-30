//
//  JSON + Extension.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

import SwiftyJSON

extension JSON {
    var sortedUp: [JSON] {
        let sortedJson = self.sorted { first, second in
            return first.0 < second.0
        }
        
        let jsonArray = sortedJson.compactMap {
            return $0.1
        }
        
        return jsonArray
    }
    
    var gemInfo: [JSON] {
        let infoJson: [(String, JSON)] = self.compactMap {
            if $0.0.contains("Gem") {
                return $0
            }
            return nil
        }
        
        let sortedJson = infoJson.sorted { first, second in
            return first.0 < second.0
        }
        
        let jsonArray = sortedJson.compactMap {
            return $0.1
        }
        
        return jsonArray
    }
    
    var equipInfo: [(String, JSON)] {
        let infoJson: [(String, JSON)] = self.compactMap {
            if !$0.0.contains("Gem") {
                return $0
            }
            return nil
        }
        
        return infoJson
    }
}
// MARK: - basicEquipmentPart
extension JSON {
    var equipmentPart: EquipmentPart? {
        //만렙일 경우 007번 부터 효과 시작, 만렙이 아닐경우 007번은 재련단계이며 008부터 효과 시작
        let isFullLv = self["Element_007"]["type"].stringValue != "Progress"
        let elementNum = isFullLv ? 7 : 8

        let equipment = EquipmentPart(titlt: title(self),
                                      part: partName(self),
                                      lv: itemLV(self),
                                      quality: itemQuality(self),
                                      grade: itemGrade(self),
                                      basicEffects: basicEffects(self),
                                      estherEffect: estherEffets(self, elementNum: elementNum),
                                      triPods: triPods(self, elementNum: elementNum),
                                      setEffects: setEffects(self, elementNum: elementNum),
                                      imageURL: imageURL(self))
        
        return equipment
    }
    
    private func title(_ json: JSON) -> String {
        return json["Element_000"]["value"].stringValue.centerNameOne
    }
    
    private func partName(_ json: JSON) -> String {
        return json["Element_001"]["value"]["leftStr0"].stringValue.centerNameTwo
    }
    
    private func itemLV(_ json: JSON) -> String {
        self["Element_001"]["value"]["leftStr2"].stringValue.centerNameOne
    }
    
    private func itemQuality(_ json: JSON) -> Int? {
        self["Element_001"]["value"]["qualityValue"].intValue < 0 ? nil : self["Element_001"]["value"]["qualityValue"].intValue
    }
    
    private func itemGrade(_ json: JSON) -> Int {
        self["Element_001"]["value"]["slotData"]["iconGrade"].intValue
    }
    
    private func basicEffects(_ json: JSON) -> BasicEffects {
        if json["Element_005"]["value"]["Element_001"].stringValue == "" {
            return BasicEffects(basicEffect: json["Element_006"]["value"]["Element_001"].stringValue,
                                aditionalEffect: nil)
        }
        
        return BasicEffects(basicEffect: json["Element_005"]["value"]["Element_001"].stringValue,
                            aditionalEffect: json["Element_006"]["value"]["Element_001"].stringValue)
    }
    
    private func estherEffets(_ json: JSON, elementNum: Int) -> EstherEffect? {
        if json["Element_001"]["value"]["slotData"]["iconGrade"].intValue == 7 {
            return EstherEffect(
                firstEffect:                                                                  self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue.estherEffect,
                secondEffect: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue.estherEffect)
        }
        
        return nil
    }
    
    private func triPods(_ json: JSON, elementNum: Int) -> Tripods? {
        if json["Element_006"]["value"].stringValue.contains("트라이포드 효과 적용 불가") || self["Element_007"]["value"].stringValue.contains("트라이포드 효과 적용 불가") {
            return nil
        }
        
        if json["Element_001"]["value"]["slotData"]["iconGrade"].intValue == 7 {
            return Tripods(
                firstTripod: json["Element_\((elementNum + 1).threeNum)"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue.tripod,
                secondTripod: json["Element_\((elementNum + 1).threeNum)"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue.tripod,
                thirdTripod: json["Element_\((elementNum + 1).threeNum)"]["value"]["Element_000"]["contentStr"]["Element_002"]["contentStr"].stringValue.tripod)
        }
        
        return Tripods(
            firstTripod: json["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue.tripod,
            secondTripod: json["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue.tripod,
            thirdTripod: json["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_002"]["contentStr"].stringValue.tripod)
    }
    private func setEffects(_ json: JSON, elementNum: Int) -> SetEffects? {
        if json["Element_006"]["value"].stringValue.contains("트라이포드 효과 적용 불가") || self["Element_007"]["value"].stringValue.contains("트라이포드 효과 적용 불가") {
            return nil
        }
        
        if json["Element_001"]["value"]["slotData"]["iconGrade"].intValue == 7 {
            return SetEffects(setEffectLv: nil,
                              effects: SetEffects.Effects(
                                firstSetEffect: json["Element_\((elementNum + 2).threeNum)"]["value"]["Element_001"].stringValue,
                                secondSetEffect: nil,
                                thirdSetEffect: nil))
        }
        
        return SetEffects(setEffectLv: json["Element_\((elementNum + 1).threeNum)"]["value"]["Element_001"].stringValue.setLv,
                          effects: SetEffects.Effects(
                            firstSetEffect: json["Element_\((elementNum + 2).threeNum)"]["value"]["Element_001"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                            secondSetEffect: json["Element_\((elementNum + 2).threeNum)"]["value"]["Element_002"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                            thirdSetEffect: json["Element_\((elementNum + 2).threeNum)"]["value"]["Element_003"]["contentStr"]["Element_000"]["contentStr"].stringValue))
    }
    
    private func imageURL(_ json: JSON) -> String {
        let imageURL = "https://cdn-lostark.game.onstove.com/"
        return imageURL + json["Element_001"]["value"]["slotData"]["iconPath"].stringValue
    }
}


