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
    
    var equipmentPart: EquipmentPart? {
        //만렙일 경우 007번 부터 효과 시작, 만렙이 아닐경우 007번은 재련단계이며 008부터 효과 시작
        let isFullLv = self["Element_007"]["type"].stringValue != "Progress"
        let elementNum = isFullLv ? 7 : 8
        let imageURL = "https://cdn-lostark.game.onstove.com/"
        
        //에스더 무기 장착시 효과 위치가 달라 별도의 처리 필요
        if self["Element_001"]["value"]["slotData"]["iconGrade"].intValue == 7 {
            let equipment = EquipmentPart(titlt: self["Element_000"]["value"].stringValue.centerNameOne,
                                          part: self["Element_001"]["value"]["leftStr0"].stringValue.centerNameTwo,
                                          lv: self["Element_001"]["value"]["leftStr2"].stringValue.centerNameOne,
                                          quality: self["Element_001"]["value"]["qualityValue"].intValue,
                                          grade: self["Element_001"]["value"]["slotData"]["iconGrade"].intValue,
                                          basicEffects: self["Element_005"]["value"]["Element_001"].stringValue,
                                          additionalEffects: self["Element_006"]["value"]["Element_001"].stringValue,
                                          estherEffect: EstherEffect(
                                                first:                                                                  self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue.estherEffect,
                                                second: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue.estherEffect),
                                          firstTripod: self["Element_\((elementNum + 1).threeNum)"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue.tripod,
                                          secondTripod: self["Element_\((elementNum + 1).threeNum)"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue.tripod,
                                          thirdTripod: self["Element_\((elementNum + 1).threeNum)"]["value"]["Element_000"]["contentStr"]["Element_002"]["contentStr"].stringValue.tripod,
                                          setEffectLv: "",
                                          firstSetEffect: self["Element_\((elementNum + 2).threeNum)"]["value"]["Element_001"].stringValue,
                                          secondSetEffect: "",
                                          thirdSetEffect: "",
                                          imageURL: imageURL + self["Element_001"]["value"]["slotData"]["iconPath"].stringValue)
            return equipment
        }
        
        let equipment = EquipmentPart(titlt: self["Element_000"]["value"].stringValue.centerNameOne,
                                      part: self["Element_001"]["value"]["leftStr0"].stringValue.centerNameTwo,
                                      lv: self["Element_001"]["value"]["leftStr2"].stringValue.centerNameOne,
                                      quality: self["Element_001"]["value"]["qualityValue"].intValue,
                                      grade: self["Element_001"]["value"]["slotData"]["iconGrade"].intValue,
                                      basicEffects: self["Element_005"]["value"]["Element_001"].stringValue,
                                      additionalEffects: self["Element_006"]["value"]["Element_001"].stringValue,
                                      estherEffect: nil,
                                      firstTripod: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue.tripod,
                                      secondTripod: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue.tripod,
                                      thirdTripod: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_002"]["contentStr"].stringValue.tripod,
                                      setEffectLv: self["Element_\((elementNum + 1).threeNum)"]["value"]["Element_001"].stringValue.setLv,
                                      firstSetEffect: self["Element_\((elementNum + 2).threeNum)"]["value"]["Element_001"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                                      secondSetEffect: self["Element_\((elementNum + 2).threeNum)"]["value"]["Element_002"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                                      thirdSetEffect: self["Element_\((elementNum + 2).threeNum)"]["value"]["Element_003"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                                      imageURL: imageURL + self["Element_001"]["value"]["slotData"]["iconPath"].stringValue)
        
        return equipment
    }
}


