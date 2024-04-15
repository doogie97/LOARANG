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
        return CharacterDetailEntity(profile: profile(dto.ArmoryProfile))
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
}
