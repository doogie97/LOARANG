//
//  GetCharacterDetailUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import Foundation
import SwiftyJSON

struct GetCharacterDetailUseCase {
    private let networkRepository: NetworkRepositoryable
    private let crawlManager: NewCrawlManagerable
    init(networkRepository: NetworkRepositoryable,
         crawlManagerable: NewCrawlManagerable) {
        self.networkRepository = networkRepository
        self.crawlManager = crawlManagerable
    }
    
    func excute(name: String) async throws -> CharacterDetailEntity {
        do {
            let dto = try await networkRepository.getCharacterDetail(name: name)
            
            let skillInfo = try await crawlManager.getSkillInfo(name)
            let equipments = equipments(dto.ArmoryEquipment)
            
            var battleEquipments = [CharacterDetailEntity.Equipment]()
            var jewelrys = [CharacterDetailEntity.Equipment]()
            var etcEquipments = [CharacterDetailEntity.Equipment]()
            
            var elixirTotalLevel = 0
            var activeSpecialEffect: CharacterDetailEntity.SpecialElixirEffectInfo?
            var elixirInfo: CharacterDetailEntity.ElixirInfo? {
                if elixirTotalLevel == 0 {
                    return nil
                } else {
                    return CharacterDetailEntity.ElixirInfo(totlaLevel: elixirTotalLevel,
                                                            activeSpecialEffect: activeSpecialEffect)
                }
            }
            
            var transcendenceGradeSum = 0
            var transcendenceTotalCount = 0
            var transcendenceInfo: CharacterDetailEntity.TranscendenceInfo? {
                if transcendenceGradeSum == 0 {
                    return nil
                } else {
                    return CharacterDetailEntity.TranscendenceInfo(
                        averageGrade: round(Double(transcendenceGradeSum) / 6 * 10) / 10,
                        totalCount: transcendenceTotalCount
                    )
                }
            }
            
            for equipment in equipments {
                switch equipment.equipmentType {
                case .무기, .투구, .상의, .하의, .장갑, .어깨:
                    battleEquipments.append(equipment)
                    equipment.elixirs?.forEach {
                        elixirTotalLevel += $0.level
                    }
                    
                    transcendenceGradeSum += equipment.transcendence?.grade ?? 0
                    transcendenceTotalCount += equipment.transcendence?.count ?? 0
                    if activeSpecialEffect == nil, equipment.specialElixirEffect != nil {
                        activeSpecialEffect = equipment.specialElixirEffect
                    }
                case .목걸이, .귀걸이, .반지, .어빌리티스톤, .팔찌:
                    jewelrys.append(equipment)
                case .나침반, .부적, .unknown:
                    etcEquipments.append(equipment)
                }
            }
            
            return CharacterDetailEntity(
                profile: profile(dto.ArmoryProfile),
                skillInfo: skillInfo,
                battleEquipments: battleEquipments,
                jewelrys: jewelrys,
                etcEquipments: etcEquipments,
                elixirInfo: elixirInfo,
                transcendenceInfo: transcendenceInfo,
                engravigs: engravig(dto.ArmoryEngraving), 
                gems: gems(dto.ArmoryGem),
                cardInfo: cardInfo(dto.ArmoryCard)
            )
        } catch let error {
            throw error
        }
    }
    //MARK: - profile
    private func profile(_ dto: CharactersDetailDTO.ArmoryProfile?) -> CharacterDetailEntity.Profile {
        return CharacterDetailEntity.Profile(
            gameServer: GameServer(rawValue: dto?.ServerName ?? "") ?? .unknown,
            battleLevel: dto?.CharacterLevel ?? 0,
            itemLevel: dto?.ItemMaxLevel ?? "",
            expeditionLevel: dto?.ExpeditionLevel ?? 0,
            characterName: dto?.CharacterName ?? "",
            characterClass: CharacterClass(rawValue: dto?.CharacterClassName ?? "") ?? .unknown,
            imageUrl: dto?.CharacterImage ?? "",
            title: dto?.Title ?? "",
            pvpGradeName: dto?.PvpGradeName ?? "",
            townName: dto?.TownName ?? "",
            guildName: dto?.GuildName ?? "",
            stats: (dto?.Stats ?? []).compactMap {
                return CharacterDetailEntity.Stat(
                    statType: StatType(rawValue: $0.statType ?? "") ?? .unknown,
                    value: Int($0.Value ?? "") ?? 0
                )
            },
            tendencies: (dto?.Tendencies ?? []).compactMap {
                return CharacterDetailEntity.Tendency(
                    tendencyType: TendencyType(rawValue: $0.tendencyType ?? "") ?? .unknown,
                    value: $0.Value ?? 0
                )
            }
        )
    }
    //MARK: - engravig
    private func engravig(_ dto: CharactersDetailDTO.ArmoryEngraving?) -> [CharacterDetailEntity.Engravig] {
        return (dto?.Effects ?? []).compactMap {
            let separtedInfo = $0.Name?.components(separatedBy: " Lv. ")
            return CharacterDetailEntity.Engravig(
                imageUrl: $0.Icon ?? "",
                name: separtedInfo?.first ?? "",
                level: Int(separtedInfo?.last ?? "") ?? 0,
                description: $0.Description ?? ""
            )
        }
    }
    
    private func gems(_ dto: CharactersDetailDTO.ArmoryGem?) -> [CharacterDetailEntity.Gem] {
        var attGems = [CharacterDetailEntity.Gem]()
        var cooltimeGems = [CharacterDetailEntity.Gem]()
        (dto?.Gems ?? []).forEach {
            let jsonData = JSON(($0.Tooltip ?? "").data(using: .utf8) ?? Data())
            let tooltipStr = jsonData["Element_004"]["value"]["Element_001"].stringValue
            let description = tooltipStr.insideAngleBrackets + (jsonData["Element_004"]["value"]["Element_001"].stringValue.components(separatedBy: ">").last ?? "")
            let gem = CharacterDetailEntity.Gem(
                name: ($0.Name ?? "").insideAngleBrackets,
                imageUrl: $0.Icon ?? "",
                level: $0.Level ?? 0,
                grade: Grade(rawValue: $0.Grade ?? "") ?? .unknown,
                description: description
            )
            if gem.name.contains("멸화") {
                attGems.append(gem)
            } else {
                cooltimeGems.append(gem)
            }
        }
        
        return attGems + cooltimeGems
    }
    
    private func cardInfo(_ dto: CharactersDetailDTO.ArmoryCard?) -> CharacterDetailEntity.CardInfo {
        let cards = (dto?.Cards ?? []).compactMap {
            return CharacterDetailEntity.Card(
                name: $0.Name ?? "",
                imageUrl: $0.Icon ?? "",
                awakeCount: $0.AwakeCount ?? 0,
                awakeTotal: $0.AwakeTotal ?? 0,
                grade: Grade(rawValue: $0.Grade ?? "") ?? .unknown
            )
        }
        
        var effects = [CharacterDetailEntity.CardEffect]()
        for effect in dto?.Effects ?? [] {
            (effect.Items ?? []).forEach {
                effects.append(CharacterDetailEntity.CardEffect(
                    name: $0.Name ?? "",
                    description: $0.Description ?? ""
                ))
            }
        }
        
        return CharacterDetailEntity.CardInfo(cards: cards,
                                              effects: effects)
    }
}
//MARK: - equipment
extension GetCharacterDetailUseCase {
    private func equipments(_ dto: [CharactersDetailDTO.Equipment]?) -> [CharacterDetailEntity.Equipment] {
        return (dto ?? []).compactMap {
            let equipmentType = EquipmentType(rawValue: $0.equipmentType ?? "") ?? .unknown
            let equipmentDetailInfo = equipmentDetailInfo($0.Tooltip,
                                                          equipmentType: equipmentType)
            return CharacterDetailEntity.Equipment(
                equipmentType: equipmentType,
                name: $0.Name ?? "",
                imageUrl: $0.Icon ?? "",
                grade: Grade(rawValue: $0.Grade ?? "") ?? .unknown,
                qualityValue: equipmentDetailInfo.qualityValue,
                itemLevel: equipmentDetailInfo.itemLevel,
                itemTypeTitle: equipmentDetailInfo.itemTypeTitle,
                basicEffect: equipmentDetailInfo.basicEffect,
                additionalEffect: equipmentDetailInfo.additionalEffect,
                setOptionName: equipmentDetailInfo.setOptionName,
                setOptionLevelStr: equipmentDetailInfo.setOptionLevelStr,
                elixirs: equipmentDetailInfo.elixirs, 
                specialElixirEffect: equipmentDetailInfo.specialElixirEffect,
                transcendence: equipmentDetailInfo.transcendence,
                highReforgingLevel: equipmentDetailInfo.highReforgingLevel,
                engraving: equipmentDetailInfo.engraving
            )
        }
    }
    
    private func equipmentDetailInfo(_ tooltip: String?, equipmentType: EquipmentType) -> EquipmentDetailInfo {
        let jsonData = JSON((tooltip ?? "").data(using: .utf8) ?? Data())
        
        var basicEffect = [String]()
        var additionalEffect = [String]()
        var setOption = ""
        var engraving = [(name: String, value: Int)]()
        var elixirs: [CharacterDetailEntity.Elixir]?
        var specialElixirEffect: CharacterDetailEntity.SpecialElixirEffectInfo?
        var transcendence: CharacterDetailEntity.Transcendence?
        
        for number in 4...12 {
            let firstParseJson = jsonData["Element_\(number.formattedNumber)"]["value"]
            
            let firstParseJson000Str = firstParseJson["Element_000"].stringValue
            
            if firstParseJson000Str.contains("기본 효과") || firstParseJson000Str.contains("팔찌 효과") {
                basicEffect = firstParseJson["Element_001"].stringValue.components(separatedBy: "<BR>").compactMap { return $0.insideAngleBrackets }
                if equipmentType == .팔찌 {
                    let effects = braceletEffects(firstParseJson)
                    basicEffect = effects.basic
                    additionalEffect = effects.additional
                }
            }
            
            if firstParseJson000Str.contains("추가 효과") || firstParseJson000Str.contains("세공 단계") {
                additionalEffect = firstParseJson["Element_001"].stringValue.components(separatedBy: "<BR>").compactMap { return $0.insideAngleBrackets }
            }
            
            
            if firstParseJson000Str.contains("세트 효과 레벨") {
                setOption = firstParseJson["Element_001"].stringValue
            }
            
            
            if firstParseJson["Element_000"]["topStr"].stringValue.contains("각인 효과") {
                engraving = parseEngraving(firstParseJson)
            }
            
            
            let secondParseJsonStr = firstParseJson["Element_000"]["topStr"].stringValue
            if secondParseJsonStr.contains("엘릭서") {
                elixirs = parseElixirs(firstParseJson)
            }
            
            if secondParseJsonStr.contains("연성 추가 효과") && secondParseJsonStr.contains("단계") {
                specialElixirEffect = parseSpecialElixirEffect(firstParseJson)
            }
            
            if secondParseJsonStr.contains("[초월]") {
                let separatedStrArr = secondParseJsonStr.components(separatedBy: ">")
                transcendence = CharacterDetailEntity.Transcendence(
                    grade: Int(separatedStrArr[safe: 3]?.components(separatedBy: "<").first ?? "") ?? 0,
                    count: Int(separatedStrArr.last ?? "") ?? 0
                )
            }
        }
        
        let itemTitle = jsonData["Element_001"]["value"]
        
        return EquipmentDetailInfo(
            qualityValue: itemTitle["qualityValue"].intValue,
            itemLevel: Int(itemTitle["leftStr2"].stringValue.components(separatedBy: " ")[safe: 3] ?? "") ?? 0,
            itemTypeTitle: itemTitle["leftStr0"].stringValue.insideAngleBrackets,
            reinforcementLevel: Int(jsonData["Element_000"]["value"].stringValue.components(separatedBy: ">+").last?.components(separatedBy: " ").first ?? "") ?? 0,
            highReforgingLevel: parseHighReforgingLevel(jsonData),
            basicEffect: basicEffect,
            additionalEffect: additionalEffect,
            setOptionName: setOption.components(separatedBy: " <").first ?? "",
            setOptionLevelStr: setOption.insideAngleBrackets,
            elixirs: elixirs,
            specialElixirEffect: specialElixirEffect,
            transcendence: transcendence,
            engraving: engraving
        )
    }
    
    func braceletEffects(_ firstParseJson: JSON) -> (basic: [String], additional: [String]) {
        var effects = (basic: [String](), additional: [String]())
        firstParseJson["Element_001"].stringValue.components(separatedBy: "<img src=\'emoticon_tooltip_bracelet").forEach {
            if !$0.isEmptyString {
                if $0.contains(" +") {
                    if let effect = $0.replacingOccurrences(of: "<BR>", with: "").components(separatedBy: ">").last {
                        effects.basic.append(effect.trimmingCharacters(in: .whitespaces))
                    }
                } else {
                    
                    if let effect = $0.components(separatedBy: "[<FONT COLOR=\'\'>")[safe: 1]?.components(separatedBy: "<").first {
                        effects.additional.append(effect)
                    }
                }
            }
        }
        return effects
    }
    
    private func parseHighReforgingLevel(_ jsonData: JSON) -> Int? {
        let highReforgingInfo = jsonData["Element_005"]["value"].stringValue
        if highReforgingInfo.contains("상급 재련") {
            let str = highReforgingInfo.components(separatedBy: ">").joined().components(separatedBy: "'")[safe: 6]?.components(separatedBy: "<").first ?? ""
            return Int(str)
        } else {
            return nil
        }
    }
    
    private func parseEngraving(_ firstParseJson: JSON) -> [(name: String, value: Int)] {
        var engraving = [(name: String, value: Int)]()
        let engravingsJson = firstParseJson["Element_000"]["contentStr"]
        var elementIndex = 0
        while elementIndex != -1 {
            if elementIndex != -1 {
                let engravingStr = engravingsJson["Element_\(elementIndex.formattedNumber)"]["contentStr"].stringValue
                if engravingStr.contains("활성도"){
                    let separated = engravingStr.components(separatedBy: "] ")
                    let name = separated.first?.insideAngleBrackets ?? ""
                    let value = Int(separated.last?.replacingOccurrences(of: "<BR>", with: "").replacingOccurrences(of: "활성도 ", with: "") ?? "") ?? 0
                    engraving.append((name: name, value: value))
                    elementIndex += 1
                } else {
                    elementIndex = -1
                }
            }
        }
        return engraving
    }
    
    private func parseElixirs(_ firstParseJson: JSON) -> [CharacterDetailEntity.Elixir] {
        var elixirs = [CharacterDetailEntity.Elixir]()
        let elixirsJson = firstParseJson["Element_000"]["contentStr"]
        var elementIndex = 0
        while elementIndex != -1 {
            let elixirString = elixirsJson["Element_\(elementIndex.formattedNumber)"]["contentStr"].stringValue
            if elixirString.isEmptyString {
                elementIndex = -1
            } else {
                let separatedStrArr = elixirString.components(separatedBy: ">")
                let level = Int((separatedStrArr[safe: 3]?.replacingOccurrences(of: "</FONT", with: "") ?? "").replacingOccurrences(of: "Lv.", with: "")) ?? 0
                var effects = [(effect: String, value: String)]()
                var effectIndex = 5
                while effectIndex != -1 {
                    if let effectStr = separatedStrArr[safe: effectIndex] {
                        var separated = effectStr.components(separatedBy: " ")
                        let value = separated.removeLast()
                        let effect = separated.joined(separator: " ")
                        effects.append((effect: effect, value: value))
                        effectIndex += 1
                    } else {
                        effectIndex = -1
                    }
                }
                
                elixirs.append(CharacterDetailEntity.Elixir(
                    name: separatedStrArr[safe: 2]?.components(separatedBy: " <").first ?? "",
                    level: level,
                    effects: effects)
                )
                elementIndex += 1
            }
        }
        return elixirs
    }
    
    private func parseSpecialElixirEffect(_ firstParseJson: JSON) -> CharacterDetailEntity.SpecialElixirEffectInfo {
        let effectJson = firstParseJson["Element_000"]
        let separatedTitle = firstParseJson["Element_000"]["topStr"].stringValue.components(separatedBy: "<")[safe: 4]?.components(separatedBy: ">").last?.components(separatedBy: " (")
        let name = separatedTitle?.first ?? ""
        let grade = Int(separatedTitle?.last?.replacingOccurrences(of: "단계)", with: "") ?? "") ?? 0
        var effects = [CharacterDetailEntity.SpecialElixirEffect]()
        if grade > 0 {
            for index in 0..<grade {
                let separatedEffect = effectJson["contentStr"]["Element_\(index.formattedNumber)"]["contentStr"].stringValue.components(separatedBy: "<br>")
                let separatedFirstEffect = separatedEffect.first?.components(separatedBy: ">") ?? []
                let gradeStr = separatedFirstEffect[safe: 2]?.components(separatedBy: " : ").first ?? ""
                let activeLevelStr = separatedFirstEffect[safe: 4]?.components(separatedBy: "<").first?.components(separatedBy: " ").last
                effects.append(CharacterDetailEntity.SpecialElixirEffect(title: name + " " + gradeStr,
                                                                         activeLevel: Int(activeLevelStr ?? "") ?? 0,
                                                                         effect: separatedEffect.last ?? ""))
            }
        }
        return CharacterDetailEntity.SpecialElixirEffectInfo(name: name,
                                                             grade: grade,
                                                             effects: effects)
    }
    
    struct EquipmentDetailInfo {
        let qualityValue: Int
        let itemLevel: Int
        let itemTypeTitle: String
        ///기본 강화 레벨
        let reinforcementLevel: Int
        ///상급 강화 레벨
        let highReforgingLevel: Int?
        let basicEffect: [String]
        let additionalEffect: [String]
        let setOptionName: String
        let setOptionLevelStr: String
        let elixirs: [CharacterDetailEntity.Elixir]?
        let specialElixirEffect: CharacterDetailEntity.SpecialElixirEffectInfo?
        let transcendence: CharacterDetailEntity.Transcendence?
        let engraving: [(name: String, value: Int)]
    }
}

//CharacterDetail 마무리 후 문제없이 작동하면 strint + Extension파일로 이동 예정
extension String {
    var isEmptyString: Bool {
        self.replacingOccurrences(of: " ", with: "").isEmpty
    }
    
    var insideAngleBrackets: String {
        let firstString = self.replacingOccurrences(of: "><", with: "")
        guard let startIndex = firstString.firstIndex(of: ">"),
              let endIndex = firstString.lastIndex(of: "<"),
              startIndex < endIndex else {
            return self
        }
        let extractedString = firstString[firstString.index(after: startIndex)..<endIndex]
        return String(extractedString)
    }
}
