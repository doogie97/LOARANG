//
//  ChangeMainUserUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct ChangeMainUserUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute(user: MainUserEntity) throws {
        do {
            try localStorage.changeMainUser(user)
            ViewChangeManager.shared.mainUser.accept(user)
        } catch let error {
            throw error
        }
    }
}
