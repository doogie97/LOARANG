//
//  NetworkRepository.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

protocol NetworkRepositoryable {
    func getEventList() async throws -> [GameEventDTO]
    func getGameNoticeList() async throws -> [GameNoticeDTO]
    func getOwnCharacters(name: String) async throws -> [CharacterBasicInfoDTO]
}

struct NetworkRepository: NetworkRepositoryable {
    private let networkManager: NetworkManagerable
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func getEventList() async throws -> [GameEventDTO] {
        let requestable = GameEventListGET()
        
        do {
            return try await networkManager.request(requestable, resultType: [GameEventDTO].self)
        } catch let error {
            throw error
        }
    }
    
    func getGameNoticeList() async throws -> [GameNoticeDTO] {
        let requestable = GameNoticeListGET()
        
        do {
            return try await networkManager.request(requestable, resultType: [GameNoticeDTO].self)
        } catch let error {
            throw error
        }
    }
    
    func getOwnCharacters(name: String) async throws -> [CharacterBasicInfoDTO] {
        let requestable = OwnCharactersGET(name: name)
        
        do {
            return try await networkManager.request(requestable, resultType: [CharacterBasicInfoDTO].self)
        } catch let error {
            throw error
        }
    }
}
