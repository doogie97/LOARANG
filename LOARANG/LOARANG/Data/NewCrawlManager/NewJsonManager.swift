//
//  NewJsonManager.swift
//  LOARANG
//
//  Created by Doogie on 4/17/24.
//

import SwiftyJSON
import Foundation

protocol NewJsonInfoManagerable {
    func getSkills(jsonString: String) -> [Skill]
}

final class NewJsonInfoManager: NewJsonInfoManagerable {
    private let imageBaseURL = "https://cdn-lostark.game.onstove.com/"
    
    func getSkills(jsonString: String) -> [Skill] {
        let jsonInfo = JSON(jsonString.data(using: .utf8) ?? Data())
        let skillJson = JSON(jsonInfo["Skill"])
        
        let validSkillTitles = getValidSkillTitles(json: skillJson)
        
        let skills: [Skill] = validSkillTitles.compactMap {
            let json = skillJson[$0]
            
            let name = json["Element_000"]["value"].stringValue
            let coolTime = json["Element_001"]["value"]["leftText"].stringValue
            let actionType = json["Element_001"]["value"]["name"].stringValue
            let skillType = json["Element_001"]["value"]["level"].stringValue
            let imageURL = imageBaseURL + json["Element_001"]["value"]["slotData"]["iconPath"].stringValue
            let battleType = json["Element_002"]["value"].stringValue.replacingOccurrences(of: "|", with: "")
            let skillLv = json["Element_003"]["value"].stringValue
            
            let skillDescription = json["Element_004"]["value"].stringValue.replacingOccurrences(of: "|", with: "")
            + "<BR><BR>" + json["Element_005"]["value"].stringValue
            var tripods: [Tripod]?
            
            var runeEffect = ""
            var gemEffect = ""
            
            for i in json {
                if i.1["type"].stringValue == "TripodSkillCustom" {
                    tripods = [getTripods(json: i.1["value"]["Element_000"]),
                               getTripods(json: i.1["value"]["Element_001"]),
                               getTripods(json: i.1["value"]["Element_002"])]
                } else if i.1["value"]["Element_000"].stringValue.contains("스킬 룬 효과") {
                    runeEffect = i.1["value"]["Element_001"].stringValue
                } else if i.1["value"]["Element_000"].stringValue.contains("보석 효과") {
                    gemEffect = i.1["value"]["Element_001"].stringValue
                }
            }
            
            
            return Skill(name: name,
                         coolTime: coolTime,
                         actionType: actionType,
                         skillType: skillType,
                         imageURL: imageURL,
                         battleType: battleType,
                         skillLv: skillLv,
                         skillDescription: skillDescription,
                         tripods: tripods ?? [],
                         runeEffect: runeEffect.htmlToAttributedString(fontSize: 1),
                         gemEffect: gemEffect.htmlToAttributedString(fontSize: 1))
        }
        return skills
    }
    
    private func getValidSkillTitles(json: JSON) -> [String] {
        return json.compactMap { (title, json) in
            guard let skillLv = Int(json["Element_003"]["value"].stringValue
                .replacingOccurrences(of: "스킬 레벨 ", with: "")
                .replacingOccurrences(of: " (최대)", with: "")) else {
                return nil
            }
            
            if skillLv > 1 {
                return title
            }
            
            for i in json {
                if i.1["value"]["Element_000"].stringValue.contains("스킬 룬 효과") {
                    return title
                } else if i.1["value"]["Element_000"].stringValue.contains("보석 효과") {
                    return title
                }
            }
            
            return nil
        }.sorted()
    }
    
    private func getTripods(json: JSON) -> Tripod {
        let name = json["name"].stringValue.htmlToString
        let description = json["desc"].stringValue
        let lv = json["tier"].stringValue
        let imageURL = imageBaseURL + json["slotData"]["iconPath"].stringValue
        
        return Tripod(name: name, description: description, lv: lv, imageURL: imageURL)
    }
}
