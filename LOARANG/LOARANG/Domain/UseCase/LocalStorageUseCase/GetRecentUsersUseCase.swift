//
//  GetRecentUsersUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct GetRecentUsersUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute() -> [RecentUserEntity] {
        return localStorage.recentUsers().compactMap {
            return $0.toEntity
        }
    }
}
