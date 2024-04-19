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
                elixirs: equipmentDetailInfo.elixirs
            )
        }
    }
    
    private func equipmentDetailInfo(_ tooltip: String?) -> EquipmentDetailInfo {
        let jsonData = JSON((tooltip ?? "").data(using: .utf8) ?? Data())
        var setOption = ""
        var elixirs: [CharacterDetailEntity.Elixir]?
        for number in 8...12 {
            //세트옵션
            let jsonInfo = jsonData["Element_\(number.formattedNumber)"]["value"]
            
            if jsonInfo["Element_000"].stringValue.contains("세트 효과 레벨") {
                setOption = jsonInfo["Element_001"].stringValue
            }
            
            //엘릭서
            if jsonInfo["Element_000"]["topStr"].stringValue.contains("엘릭서") {
                let elixirsJson = jsonInfo["Element_000"]["contentStr"]
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
        }
        let itemTitle = jsonData["Element_001"]["value"]
        return EquipmentDetailInfo(
            qualityValue: itemTitle["qualityValue"].intValue,
            itemLevel: itemTitle["leftStr2"].stringValue.insideAngleBrackets,
            itemTypeTitle: itemTitle["leftStr0"].stringValue.insideAngleBrackets, 
            setOptionName: setOption.components(separatedBy: " <").first ?? "",
            setOptionLevelStr: setOption.insideAngleBrackets, 
            elixirs: elixirs
        )
    }
    
    struct EquipmentDetailInfo {
        let qualityValue: Int
        let itemLevel: String
        let itemTypeTitle: String
        let setOptionName: String
        let setOptionLevelStr: String
        let elixirs: [CharacterDetailEntity.Elixir]?
    }
}

//CharacterDetail 마무리 후 문제없이 작동하면 strint + Extension파일로 이동 예정
extension String {
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
