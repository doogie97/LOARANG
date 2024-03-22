//
//  NetworkRepository.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

protocol NetworkRepositoryable {
    func getEventList() async throws -> [EventDTO]
}

struct NetworkRepository: NetworkRepositoryable {
    private let networkManager: NetworkManagerable
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func getEventList() async throws -> [EventDTO] {
        let requestable = EventListGET()
        
        do {
            return try await networkManager.request(requestable, resultType: [EventDTO].self)
        } catch let error {
            throw error
        }
    }
}
