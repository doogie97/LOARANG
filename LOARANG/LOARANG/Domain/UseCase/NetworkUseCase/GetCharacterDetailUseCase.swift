//
//  GetCharacterDetailUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

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
            var rune: CharacterDetailEntity.Rune?
            if let runeDTO = $0.Rune {
                rune = CharacterDetailEntity.Rune(name: runeDTO.Name ?? "",
                                                  imageUrl: runeDTO.Icon ?? "",
                                                  grade: Grade(rawValue: runeDTO.Grade ?? "") ?? .unknown,
                                                  tooltip: runeDTO.Tooltip ?? "")
            }
            
            return CharacterDetailEntity.Skill(
                name: $0.Name ?? "",
                imageUrl: $0.Icon ?? "",
                level: $0.Level ?? 0,
                tripods: ($0.Tripods ?? []).compactMap {
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
                },
                rune: rune,
                tooltip: $0.Tooltip ?? ""
            )
        }
    }
}
