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
    
    var equipmentPart: EquipmentPart {
        let isFullLv = self["Element_007"]["type"].stringValue == "Progress"
        let elementNum = isFullLv ? 8 : 7
        
        let equipment = EquipmentPart(titlt: self["Element_000"]["value"].stringValue.centerName,
                                  part: self["Element_001"]["value"]["leftStr0"].stringValue,
                                  lv: self["Element_001"]["value"]["leftStr2"].stringValue.centerName,
                                  quality: self["Element_001"]["value"]["qualityValue"].intValue,
                                  grade: self["Element_001"]["value"]["slotData"]["iconGrade"].intValue,
                                  basicEffects: self["Element_005"]["value"]["Element_001"].stringValue.replacingOccurrences(of: "<BR>", with: "\n"),
                                  additionalEffects: self["Element_006"]["value"]["Element_001"].stringValue,
                                  firstTripod: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                                  secondTripod: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_001"]["contentStr"].stringValue,
                                  thirdTripod: self["Element_\(elementNum.threeNum)"]["value"]["Element_000"]["contentStr"]["Element_002"]["contentStr"].stringValue,
                                  setEffectLv: self["Element_\((elementNum + 1).threeNum)"]["value"]["Element_001"].stringValue,
                                  firstSetEffect: self["Element_\((elementNum + 2).threeNum)"]["value"]["Element_001"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                                  secondSetEffect: self["Element_\((elementNum + 2).threeNum)"]["value"]["Element_002"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                                  thirdSetEffect: self["Element_\((elementNum + 2).threeNum)"]["value"]["Element_003"]["contentStr"]["Element_000"]["contentStr"].stringValue,
                                  imageURL: self["Element_001"]["value"]["slotData"]["iconPath"].stringValue)
        
        return equipment
    }
}


