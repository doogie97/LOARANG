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
}

// MARK: - 장작 장비 관련
extension JsonInfoManager {
    func getEquipmentsInfo() -> Equips {
        let equipmentsJson: [(title: String, json: JSON)] = JSON(jsonInfo["Equip"]).compactMap { (title, JSON) in
            if !title.contains("Gem") {
                return (title, JSON)
            }
            return nil
        }
        
        return Equips(battleEquipments: getBattleEquipments(json: equipmentsJson),
                      accessories: getAccessories(json: equipmentsJson),
                      engrave: getEngrave(JSON(jsonInfo["Engrave"])),
                      avatar: getAvatar(json: equipmentsJson),
                      specialEquipment: getSpecialEquipments(json: equipmentsJson),
                      gems: getGemsInfo(),
                      card: nil)
    }
    
    private func getBattleEquipments(json: [(title: String, json: JSON)]) -> BattleEquipments {
        var head: EquipmentPart?
        var shoulder: EquipmentPart?
        var top: EquipmentPart?
        var bottom: EquipmentPart?
        var gloves: EquipmentPart?
        var weapon: EquipmentPart?
        
        for info in json {
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
            }
        }
        
        return BattleEquipments(head: head,
                                shoulder: shoulder,
                                top: top,
                                bottom: bottom,
                                gloves: gloves,
                                weapon: weapon)
    }
    
    private func getAccessories(json: [(title: String, json: JSON)]) -> Accessories {
        var necklace: EquipmentPart?
        var firstEarring: EquipmentPart?
        var secondEarring: EquipmentPart?
        var firstRing: EquipmentPart?
        var secondRing: EquipmentPart?
        var bracelet: EquipmentPart?
        var abilityStone: EquipmentPart?
        
        for info in json {
            if info.title.contains(EquimentIndex.necklace.rawValue) {
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
        
        return Accessories(necklace: necklace,
                           firstEarring: firstEarring,
                           secondEarring: secondEarring,
                           firstRing: firstRing,
                           secondRing: secondRing,
                           bracelet: bracelet,
                           abilityStone: abilityStone)
    }
    
    private func getAvatar(json: [(title: String, json: JSON)]) -> Avatar {
        var mainWeaponAvatar: EquipmentPart?
        var mainHeadAvatar: EquipmentPart?
        var mainTopAvatar: EquipmentPart?
        var mainBottomAvatar: EquipmentPart?
        var instrumentAvarat: EquipmentPart?
        var fisrtFaceAvarat: EquipmentPart?
        var secondFaceAvarat: EquipmentPart?
        var subWeaponAvatar: EquipmentPart?
        var subHeadAvatar: EquipmentPart?
        var subTopAvatar: EquipmentPart?
        var subBottomAvatar: EquipmentPart?
        
        for info in json {
            if info.title.contains(EquimentIndex.mainWeaponAvatar.rawValue) {
                mainWeaponAvatar = getEquipmentPart(info.json, type: .avatar)
            } else if info.title.contains(EquimentIndex.mainHeadAvatar.rawValue) {
                mainHeadAvatar = getEquipmentPart(info.json, type: .avatar)
            } else if info.title.contains(EquimentIndex.mainTopAvatar.rawValue) {
                mainTopAvatar = getEquipmentPart(info.json, type: .avatar)
            } else if info.title.contains(EquimentIndex.mainBottomAvatar.rawValue) {
                mainBottomAvatar = getEquipmentPart(info.json, type: .avatar)
            } else if info.title.contains(EquimentIndex.instrumentAvarat.rawValue) {
                instrumentAvarat = getEquipmentPart(info.json, type: .avatar)
            } else if info.title.contains(EquimentIndex.fisrtFaceAvarat.rawValue) {
                fisrtFaceAvarat = getEquipmentPart(info.json, type: .avatar)
            } else if info.title.contains(EquimentIndex.secondFaceAvarat.rawValue) {
                secondFaceAvarat = getEquipmentPart(info.json, type: .avatar)
            } else if info.title.contains(EquimentIndex.subWeaponAvatar.rawValue) {
                subWeaponAvatar = getEquipmentPart(info.json, type: .subAvatar)
            } else if info.title.contains(EquimentIndex.subHeadAvatar.rawValue) {
                subHeadAvatar = getEquipmentPart(info.json, type: .subAvatar)
            } else if info.title.contains(EquimentIndex.subTopAvatar.rawValue) {
                subTopAvatar = getEquipmentPart(info.json, type: .subAvatar)
            } else if info.title.contains(EquimentIndex.subBottomAvatar.rawValue) {
                subBottomAvatar = getEquipmentPart(info.json, type: .subAvatar)
            }
        }
        
        return Avatar(mainWeaponAvatar: mainWeaponAvatar,
                      mainHeadAvatar: mainHeadAvatar,
                      mainTopAvatar: mainTopAvatar,
                      mainBottomAvatar: mainBottomAvatar,
                      instrumentAvarat: instrumentAvarat,
                      fisrtFaceAvarat: fisrtFaceAvarat,
                      secondFaceAvarat: secondFaceAvarat,
                      subWeaponAvatar: subWeaponAvatar,
                      subHeadAvatar: subHeadAvatar,
                      subTopAvatar: subTopAvatar,
                      subBottomAvatar: subBottomAvatar)
    }
    
    private func getSpecialEquipments(json: [(title: String, json: JSON)]) -> SpecialEquipments {
        var compass: EquipmentPart?
        var amulet: EquipmentPart?
        var emblem: EquipmentPart?
        
        for info in json {
            if info.title.contains(EquimentIndex.compass.rawValue) {
                compass = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.amulet.rawValue) {
                amulet = getEquipmentPart(info.json, type: .accessory)
            } else if info.title.contains(EquimentIndex.emblem.rawValue) {
                emblem = getEquipmentPart(info.json, type: .accessory)
            }
        }
        
        return SpecialEquipments(compass: compass,
                                 amulet: amulet,
                                 emblem: emblem)
    }
    
    private func getEquipmentPart(_ json: JSON, type: EquipmentType) -> EquipmentPart {
        var battleEffects: String? {
            switch type {
            case .battleEquipment:
                return getBattleEffects(json)
            case .accessory:
                return getAccesaryEffects(json)
            case .avatar:
                return getAvatarEffects(json)
            case .subAvatar:
                return getSubAvatarEffects(json)
            }
        }
        return EquipmentPart(basicInfo: getEquipmentBasicInfo(json),
                             battleEffects: battleEffects?.replacingOccurrences(of: "<BR><BR><BR>", with: "")
                                                          .replacingOccurrences(of: "거래 불가", with: "")
                                                          .replacingOccurrences(of: "|", with: ""))
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
                                               activation: engrave.1["Element_001"]["value"]["leftText"].engraveActivation)
            } else if engrave.0.contains("001") {
                secondEngraves = EquipedEngrave(name: engrave.1["Element_000"]["value"].stringValue,
                                                activation: engrave.1["Element_001"]["value"]["leftText"].engraveActivation)
            }
        }
        
        return (firstEngraves, secondEngraves)
    }
    
    //MARK: - 아바타 효과
    private func getAvatarEffects(_ json: JSON) -> String {
        let basicEffect = json["Element_005"]["value"]["Element_000"].stringValue //거래 제한 아바타
        + json["Element_004"]["value"]["Element_000"].stringValue //무한 거래 가능 아바타
        + "<BR>" + json["Element_005"]["value"]["Element_001"].stringValue
        + json["Element_004"]["value"]["Element_001"].stringValue + "<BR><BR>"
        
        
        let aditionalEffect = json["Element_006"]["value"]["titleStr"].stringValue //거래 제한 아바타
        + json["Element_005"]["value"]["titleStr"].stringValue //무한 거래 가능 아바타
        + json["Element_004"]["value"]["titleStr"].stringValue
        + "<BR>" + json["Element_006"]["value"]["contentStr"].propensityString
        + json["Element_005"]["value"]["contentStr"].propensityString
        + json["Element_004"]["value"]["contentStr"].propensityString
        
        return basicEffect + aditionalEffect
    }
    
    private func getSubAvatarEffects(_ json: JSON) -> String {
        let topStr = json["Element_005"]["value"].stringValue //거래 제한 아바타
        + json["Element_004"]["value"].stringValue //무한 거래 가능 아바타
        + "<BR>"
        
        let basicEffect =
        json["Element_006"]["value"]["Element_000"].stringValue //거래 제한 아바타
        + json["Element_005"]["value"]["Element_000"].stringValue //무한 거래 가능 아바타
        + "<BR>" + json["Element_006"]["value"]["Element_001"].stringValue
        + json["Element_005"]["value"]["Element_001"].stringValue
        + "<BR><BR>"
        
        let aditionalEffect = json["Element_007"]["value"]["titleStr"].stringValue //거래 제한 아바타
        + json["Element_006"]["value"]["titleStr"].stringValue //무한 거래 가능 아바타
        + "<BR>" + json["Element_007"]["value"]["contentStr"].propensityString
        + json["Element_006"]["value"]["contentStr"].propensityString
        
        return topStr + basicEffect + aditionalEffect
    }
}

// MARK: - 장착 보석 관련
extension JsonInfoManager {
    func getGemsInfo() -> [Gem] {
        let gemsJson: [(title: String, json: JSON)] = JSON(jsonInfo["Equip"]).compactMap { (title, JSON) in
            if title.contains("Gem") {
                return (title, JSON)
            }
            return nil
        }

        let gemInfo: [Gem] = gemsJson.map {
            let name = $0.json["Element_000"]["value"].stringValue
            let grade = $0.json["Element_001"]["value"]["slotData"]["iconGrade"].intValue
            let lvString = $0.json["Element_001"]["value"]["slotData"]["rtString"].stringValue
            let imageURL = imageBaseURL + $0.json["Element_001"]["value"]["slotData"]["iconPath"].stringValue
            let effect = $0.json["Element_004"]["value"]["Element_001"].stringValue + $0.json["Element_005"]["value"]["Element_001"].stringValue
            
            return Gem(name: name, grade: grade, lvString: lvString, effect: effect, imageURL: imageURL)
        }
        
        return gemInfo.sorted {
            let first = $0.name.htmlToString.components(separatedBy: " ")
            let second = $1.name.htmlToString.components(separatedBy: " ")
            
            if first[safe: 0] == second[safe: 0] {
                return first[safe: 1] ?? "" < second[safe: 1] ?? ""
            } else {
                return first[safe: 0] ?? "" > second[safe: 0] ?? ""
            }
        }
    }
}

//MARK: - 스킬 관련
extension JsonInfoManager {
    func getSkills() -> [Skill] {
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
