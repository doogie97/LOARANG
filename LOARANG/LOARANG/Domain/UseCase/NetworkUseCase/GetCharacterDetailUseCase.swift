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
            
            return CharacterDetailEntity(
                profile: profile(dto.ArmoryProfile),
                skillInfo: skillInfo,
                equipments: equipments(dto.ArmoryEquipment)
            )
        } catch let error {
            throw error
        }
    }
    
    private func profile(_ dto: CharactersDetailDTO.ArmoryProfile?) -> CharacterDetailEntity.Profile {
        return CharacterDetailEntity.Profile(
            gameServer: GameServer(rawValue: dto?.ServerName ?? "") ?? .unknown,
            battleLevel: dto?.CharacterLevel ?? 0,
            itemLevel: dto?.ItemMaxLevel ?? "",
            expeditionLevel: dto?.ExpeditionLevel ?? 0,
            characterName: dto?.CharacterName ?? "",
            characterClass: CharacterClass(rawValue: dto?.CharacterClassName ?? "") ?? .unknown,
            imageUrl: dto?.CharacterImage ?? ""
        )
    }
    
    private func equipments(_ dto: [CharactersDetailDTO.Equipment]?) -> [CharacterDetailEntity.Equipment] {
        return (dto ?? []).compactMap {
            let equipmentDetailInfo = equipmentDetailInfo($0.Tooltip)
            return CharacterDetailEntity.Equipment(
                equipment: EquipmentType(rawValue: $0.equipmentType ?? "") ?? .unknown,
                name: $0.Name ?? "",
                imageUrl: $0.Icon ?? "",
                grade: Grade(rawValue: $0.Grade ?? "") ?? .unknown,
                qualityValue: equipmentDetailInfo.qualityValue,
                itemLevel: equipmentDetailInfo.itemLevel,
                itemTypeTitle: equipmentDetailInfo.itemTypeTitle,
                setOptionName: equipmentDetailInfo.setOptionName,
                setOptionLevelStr: equipmentDetailInfo.setOptionLevelStr, 
                elixirs: equipmentDetailInfo.elixirs,
                transcendence: equipmentDetailInfo.transcendence
            )
        }
    }
    
    private func equipmentDetailInfo(_ tooltip: String?) -> EquipmentDetailInfo {
        let jsonData = JSON((tooltip ?? "").data(using: .utf8) ?? Data())
        
        var basicEffect = [String]()
        var additionalEffect = [String]()
        var setOption = ""
        var elixirs: [CharacterDetailEntity.Elixir]?
        var transcendence: CharacterDetailEntity.Transcendence?
        for number in 4...12 {
            let firstParseJson = jsonData["Element_\(number.formattedNumber)"]["value"]
            
            let firstParseJson000Str = firstParseJson["Element_000"].stringValue
            //기본 효과
            if firstParseJson000Str.contains("기본 효과") {
                basicEffect = firstParseJson["Element_001"].stringValue.components(separatedBy: "<BR>").compactMap { return $0.insideAngleBrackets }
            }
            
            // 추가 효과
            if firstParseJson000Str.contains("추가 효과") || firstParseJson000Str.contains("세공 단계") {
                additionalEffect = firstParseJson["Element_001"].stringValue.components(separatedBy: "<BR>").compactMap { return $0.insideAngleBrackets }
            }
            
            //세트 옵션
            if firstParseJson000Str.contains("세트 효과 레벨") {
                setOption = firstParseJson["Element_001"].stringValue
            }
            
            let secondParseJsonStr = firstParseJson["Element_000"]["topStr"].stringValue
            //엘릭서
            if secondParseJsonStr.contains("엘릭서") {
                let elixirsJson = firstParseJson["Element_000"]["contentStr"]
                var elixirStrings = [String]()
                var elementIndex = 0
                while elementIndex != -1 {
                    let elixirString = elixirsJson["Element_\(elementIndex.formattedNumber)"]["contentStr"].stringValue
                    if elixirString.isEmptyString {
                        elementIndex = -1
                    } else {
                        elixirStrings.append(elixirString)
                        elementIndex += 1
                    }
                }
                elixirs = elixirStrings.compactMap {
                    let searatedStrArr = $0.components(separatedBy: ">")
                    return CharacterDetailEntity.Elixir(
                        name: searatedStrArr[safe: 2]?.components(separatedBy: " <").first ?? "",
                        level: searatedStrArr[safe: 3]?.replacingOccurrences(of: "</FONT", with: "") ?? "",
                        effect: searatedStrArr.last ?? ""
                    )
                }
            }
            
            //초월
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
            itemLevel: itemTitle["leftStr2"].stringValue.insideAngleBrackets,
            itemTypeTitle: itemTitle["leftStr0"].stringValue.insideAngleBrackets, 
            basicEffect: basicEffect,
            additionalEffect: additionalEffect,
            setOptionName: setOption.components(separatedBy: " <").first ?? "",
            setOptionLevelStr: setOption.insideAngleBrackets, 
            elixirs: elixirs, 
            transcendence: transcendence
        )
    }
    
    struct EquipmentDetailInfo {
        let qualityValue: Int
        let itemLevel: String
        let itemTypeTitle: String
        let basicEffect: [String]
        let additionalEffect: [String]
        let setOptionName: String
        let setOptionLevelStr: String
        let elixirs: [CharacterDetailEntity.Elixir]?
        let transcendence: CharacterDetailEntity.Transcendence?
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
