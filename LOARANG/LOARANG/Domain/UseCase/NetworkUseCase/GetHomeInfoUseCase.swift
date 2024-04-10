//
//  GetHomeInfoUseCase.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

struct GetHomeInfoUseCase {
    private let networkRepository: NetworkRepositoryable
    
    init(networkRepository: NetworkRepositoryable) {
        self.networkRepository = networkRepository
    }
    
    func execute() async throws -> HomeInfoEntity {
        do {
            let eventDTO = try await networkRepository.getEventList()
            return HomeInfoEntity(eventList: eventList(eventDTO))
        } catch let error {
            throw error
        }
    }
    
    private func eventList(_ eventListDTO: [EventDTO]?) -> [HomeInfoEntity.Event] {
        return (eventListDTO ?? []).compactMap {
            return HomeInfoEntity.Event(title: $0.title ?? "",
                                        thumbnailImgUrl: $0.thumbnail ?? "",
                                        url: $0.link ?? "",
                                        startDate: $0.startDate ?? "",
                                        endDate: $0.endDate ?? "",
                                        rewardDate: $0.rewardDate ?? "")
        }
    }
}
