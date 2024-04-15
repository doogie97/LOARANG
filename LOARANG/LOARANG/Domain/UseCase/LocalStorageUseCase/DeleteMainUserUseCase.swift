//
//  DeleteMainUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

struct DeleteMainUserUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute() throws {
        do {
            try localStorage.deleteMainUser()
            ViewChangeManager.shared.mainUser.accept(nil)
        } catch let error {
            throw error
        }
    }
}

