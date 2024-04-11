//
//  AddBookmarkUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct AddBookmarkUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute(user: BookmarkUserEntity) throws {
        let oldValue = ViewChangeManager.shared.bookmarkUsers.value
        do {
            try localStorage.addBookmarkUser(user.toDTO)
            let newValue = oldValue + [user]
            ViewChangeManager.shared.bookmarkUsers.accept(newValue)
        } catch let error {
            throw error
        }
    }
}
