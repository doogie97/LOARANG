//
//  ChangeMainUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct ChangeMainUserUseCase {
    private let localStorage: LocalStorageable
    
    init(localStorage: LocalStorageable) {
        self.localStorage = localStorage
    }
    
    func execute(user: MainUser) throws {
        do {
            try localStorage.changeMainUser(user)
        } catch let error {
            throw error
        }
    }
}
