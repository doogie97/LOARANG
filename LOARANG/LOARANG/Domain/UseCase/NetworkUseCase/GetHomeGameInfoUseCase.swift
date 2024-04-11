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
            return HomeGameInfoEntity(eventList: eventList(eventDTO),
                                      noticeList: noticeDTO.compactMap {
                return $0.toEntity
            })
        } catch let error {
            throw error
        }
    }
    
    private func eventList(_ eventListDTO: [GameEventDTO]?) -> [GmaeEventEntity] {
        return (eventListDTO ?? []).compactMap {
            return GmaeEventEntity(title: $0.title ?? "",
                         thumbnailImgUrl: $0.thumbnail ?? "",
                         url: $0.link ?? "",
                         startDate: $0.startDate ?? "",
                         endDate: $0.endDate ?? "",
                         rewardDate: $0.rewardDate ?? "")
        }
    }
}
