//
//  NetworkRepository.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

protocol NetworkRepositoryable {
    func getAppVersion() async -> String?
    func getEventList() async throws -> [GameEventDTO]
    func getGameNoticeList() async throws -> [GameNoticeDTO]
    func getChallengeAbyssDungeons() async throws -> [ChallengeAbyssDungeonDTO]
    func getChallengeGuardianRaids() async throws -> ChallengeGuardianRaidsDTO
    func getCharacterDetail(name: String) async throws -> CharactersDetailDTO
    func getOwnCharacters(name: String) async throws -> [CharacterBasicInfoDTO]
}

struct NetworkRepository: NetworkRepositoryable {
    private let networkManager: NetworkManagerable
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func getAppVersion() async -> String? {
        let requstable = AppVersionGET()
        
        return try? await networkManager.request(requstable, resultType: AppVersionDTO.self).results?.first?.version
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
    
    func getChallengeAbyssDungeons() async throws -> [ChallengeAbyssDungeonDTO] {
        let requestable = ChallengeAbyssDungeonsGET()
        
        do {
            return try await networkManager.request(requestable, resultType: [ChallengeAbyssDungeonDTO].self)
        } catch let error {
            throw error
        }
    }
    
    func getChallengeGuardianRaids() async throws -> ChallengeGuardianRaidsDTO {
        let requestable = ChallengeGuardianRaidsGET()
        
        do {
            return try await networkManager.request(requestable, resultType: ChallengeGuardianRaidsDTO.self)
        } catch let error {
            throw error
        }
    }
    
    func getCharacterDetail(name: String) async throws -> CharactersDetailDTO {
        let requestable = CharacterDetailGET(name: name)
        
        do {
            return try await networkManager.request(requestable, resultType: CharactersDetailDTO.self)
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
