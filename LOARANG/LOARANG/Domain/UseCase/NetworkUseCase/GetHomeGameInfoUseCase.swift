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
            
            let appVersion = await networkRepository.getAppVersion() ?? ""
            let eventDTO = try await networkRepository.getEventList()
            let noticeDTO = try await networkRepository.getGameNoticeList()
            let challengeAbyssDungeonsDTO = try await networkRepository.getChallengeAbyssDungeons()
            let challengeGuardianRaidsDTO = try await networkRepository.getChallengeGuardianRaids()
            return HomeGameInfoEntity(
                appStoreVesion: appVersion,
                eventList: eventDTO.compactMap {
                    return $0.toEntity
                },
                noticeList: noticeDTO.compactMap {
                    return $0.toEntity
                },
                challengeAbyssDungeonEntity: challengeAbyssDungeonsDTO.compactMap {
                    return $0.toEntity
                },
                challengeGuardianRaidsEntity: (challengeGuardianRaidsDTO.raids ?? []).compactMap {
                    return $0.toEntity
                }
            )
        } catch let error {
            throw error
        }
    }
}
