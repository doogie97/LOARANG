//
//  GetRecentUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct GetRecentUserUseCase {
    private let localStorage: LocalStorageable
    
    init(localStorage: LocalStorageable) {
        self.localStorage = localStorage
    }
    
    func execute() -> [RecentUserEntity] {
        return localStorage.recentUsers()
    }
}
