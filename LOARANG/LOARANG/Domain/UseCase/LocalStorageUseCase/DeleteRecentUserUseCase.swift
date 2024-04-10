//
//  DeleteRecentUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct DeleteRecentUserUseCase {
    private let localStorage: LocalStorageable
    
    init(localStorage: LocalStorageable) {
        self.localStorage = localStorage
    }
    
    func execute(name: String) throws {
        do {
            try localStorage.deleteRecentUser(name)
            ViewChangeManager.shared.recentUsers.accept(localStorage.recentUsers())
        } catch let error {
            throw error
        }
    }
}
