//
//  GetCharacterDetailUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import Foundation

struct GetCharacterDetailUseCase {
    private let networkRepository: NetworkRepositoryable
    init(networkRepository: NetworkRepositoryable) {
        self.networkRepository = networkRepository
    }
    
    func excute(name: String) async throws -> CharacterDetailEntity {
        let dto = try await networkRepository.getCharacterDetail(name: name)
        return CharacterDetailEntity(
            profile: profile(dto.ArmoryProfile),
            skills: skills(dto.ArmorySkills).sorted(by: { $0.level > $1.level})
        )
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
    
    private func skills(_ dto: [CharactersDetailDTO.ArmorySkill]?) -> [CharacterDetailEntity.Skill] {
        return (dto ?? []).compactMap {
            let tripod = ($0.Tripods ?? []).compactMap {
                if $0.IsSelected == true {
                    return CharacterDetailEntity.Tripod(
                        name: $0.Name ?? "",
                        imageUrl: $0.Icon ?? "",
                        level: $0.Level ?? 0,
                        isSelected: $0.IsSelected ?? false,
                        tooltip: $0.Tooltip ?? ""
                    )
                } else {
                    return nil
                }
            }
            //룬&트라이포드가 없고 1레벨인 스킬은 미장착 스킬로 판단해 nil return
            if $0.Rune == nil && tripod.isEmpty == true && $0.Level == 1 {
                return nil
            } else {
                var rune: CharacterDetailEntity.Rune?
                if let runeDTO = $0.Rune {
                    var toolTip: String {
                        if let jsonData = (runeDTO.Tooltip ?? "").data(using: .utf8),
                           let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                           let itemPartBox = jsonDict["Element_002"] as? [String: Any],
                           let valueDict = itemPartBox["value"] as? [String: String],
                           let toolTip = valueDict["Element_001"] {
                            return toolTip
                        } else {
                            return ""
                        }
                    }
                    rune = CharacterDetailEntity.Rune(name: runeDTO.Name ?? "",
                                                      imageUrl: runeDTO.Icon ?? "",
                                                      grade: Grade(rawValue: runeDTO.Grade ?? "") ?? .unknown,
                                                      tooltip: toolTip)
                }
                
                return CharacterDetailEntity.Skill(
                    name: $0.Name ?? "",
                    imageUrl: $0.Icon ?? "",
                    level: $0.Level ?? 0,
                    tripods: tripod,
                    rune: rune,
                    tooltip: $0.Tooltip ?? ""
                )
            }
        }
    }
}
