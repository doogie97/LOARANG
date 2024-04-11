//
//  AddRecentUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct AddRecentUserUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute(user: RecentUserEntity) throws {
        do {
            try localStorage.addRecentUser(user)
            ViewChangeManager.shared.recentUsers.accept(localStorage.recentUsers().compactMap {
                return $0.toEntity
            })
        } catch let error {
            throw error
        }
    }
}
