//
//  AddRecentUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct AddRecentUserUseCase {
    private let localStorage: LocalStorageable
    
    init(localStorage: LocalStorageable) {
        self.localStorage = localStorage
    }
    
    func execute(user: RecentUserEntity) throws {
        do {
            try localStorage.addRecentUser(user)
            ViewChangeManager.shared.recentUsers.accept(localStorage.recentUsers())
        } catch let error {
            throw error
        }
    }
}
