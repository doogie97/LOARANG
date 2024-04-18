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
                itemTypeTitle: equipmentDetailInfo.itemTypeTitle
            )
        }
    }
    
    private func equipmentDetailInfo(_ tooltip: String?) -> EquipmentDetailInfo {
        let jsonData = JSON((tooltip ?? "").data(using: .utf8) ?? Data())
        let itemTitle = jsonData["Element_001"]["value"]
        return EquipmentDetailInfo(
            qualityValue: itemTitle["qualityValue"].intValue,
            itemLevel: itemTitle["leftStr2"].stringValue.insideAngleBrackets,
            itemTypeTitle: itemTitle["leftStr0"].stringValue.insideAngleBrackets
        )
    }
    
    struct EquipmentDetailInfo {
        let qualityValue: Int
        let itemLevel: String
        let itemTypeTitle: String
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
