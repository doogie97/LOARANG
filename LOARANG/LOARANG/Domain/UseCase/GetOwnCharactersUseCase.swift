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
    
    func execute(name: String) async throws -> OwnCharactersEntity {
        do {
            let characterListDTO = try await networkRepository.getOwnCharacters(name: name)
            
            return OwnCharactersEntity(serverList: serverList(characterListDTO))
        }
        catch let error {
            throw error
        }
    }
    
    private func serverList(_ dto: [CharacterBasicInfoDTO]) -> [OwnCharactersEntity.ServerInfo] {
        var serverListDic: [GameServer : (index: Int, serverInfo: OwnCharactersEntity.ServerInfo)] = [:]
        var serverListIndex = 0
        let characters = characters(dto)
        for character in characters {
            if let serverInfo = serverListDic[character.gameServer] {
                serverListDic[character.gameServer]?.serverInfo.characters.append(character)
            } else {
                serverListDic[character.gameServer] = (serverListIndex, OwnCharactersEntity.ServerInfo(gameServer: character.gameServer,
                                                                                     characters: [character]))
                serverListIndex += 1
            }
        }
        var serverList: [OwnCharactersEntity.ServerInfo] = (serverListDic.sorted { $0.value.index < $1.value.index }).compactMap {
            return $0.value.serverInfo
        }
        
        return serverList
    }
    
    private func characters(_ dto: [CharacterBasicInfoDTO]) -> [OwnCharactersEntity.Character] {
        return dto.compactMap {
            return OwnCharactersEntity.Character(gameServer: GameServer(rawValue: $0.serverName ?? "") ?? .unknown,
                                                 characterName: $0.characterName ?? "",
                                                 characterLevel: $0.characterLevel ?? 0,
                                                 characterClass: CharacterClass(rawValue: $0.characterClassName ?? "") ?? .unknown,
                                                 itemAvgLevel: $0.itemAvgLevel ?? "",
                                                 itemMaxLevel: $0.itemMaxLevel ?? "")
        }.sorted {
            let firstDoubleItemLevel = Double($0.itemMaxLevel.replacingOccurrences(of: ",", with: "")) ?? 0
            let secondDoubleItemLevel = Double($1.itemMaxLevel.replacingOccurrences(of: ",", with: "")) ?? 0
            return firstDoubleItemLevel > secondDoubleItemLevel
        }
    }
}
