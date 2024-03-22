//
//  GetOwnCharactersUseCase.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

struct GetOwnCharactersUseCase {
    private let networkRepository: NetworkRepositoryable
    init(networkRepository: NetworkRepositoryable) {
        self.networkRepository = networkRepository
    }
    
    func execute(name: String) async throws -> [CharacterBasicInfoEntity] {
        do {
            let characterListDTO = try await networkRepository.getOwnCharacters(name: name)
            return characterListDTO.compactMap {
                return CharacterBasicInfoEntity(gameServer: GameServer(rawValue: $0.serverName ?? "") ?? .unknown,
                                                characterName: $0.characterName ?? "",
                                                characterLevel: $0.characterLevel ?? 0,
                                                characterClass: CharacterClass(rawValue: $0.characterClassName ?? "") ?? .unknown,
                                                itemAvgLevel: $0.itemAvgLevel ?? "",
                                                itemMaxLevel: $0.itemMaxLevel ?? "")
            }
        } catch let error {
            throw error
        }
    }
}
