//
//  GetHomeGameInfoUseCase.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

struct GetHomeGameInfoUseCase {
    private let networkRepository: NetworkRepositoryable
    
    init(networkRepository: NetworkRepositoryable) {
        self.networkRepository = networkRepository
    }
    
    func execute() async throws -> HomeGameInfoEntity {
        do {
            let eventDTO = try await networkRepository.getEventList()
            let noticeDTO = try await networkRepository.getGameNoticeList()
            let challengeAbyssDungeonsDTO = try await networkRepository.getChallengeAbyssDungeons()
            return HomeGameInfoEntity(eventList: eventDTO.compactMap {
                return $0.toEntity
            },
                                      noticeList: noticeDTO.compactMap {
                return $0.toEntity
            },
                                      challengeAbyssDungeonEntity: challengeAbyssDungeonsDTO.compactMap {
                return $0.toEntity
            })
        } catch let error {
            throw error
        }
    }
}
