//
//  DeleteRecentUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct DeleteRecentUserUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute(name: String = "", isClear: Bool = false) throws {
        do {
            if isClear {
                try localStorage.clearRecentUsers()
            } else {
                try localStorage.deleteRecentUser(name)
            }
            ViewChangeManager.shared.recentUsers.accept(localStorage.recentUsers().compactMap {
                return $0.toEntity
            })
        } catch let error {
            throw error
        }
    }
}
