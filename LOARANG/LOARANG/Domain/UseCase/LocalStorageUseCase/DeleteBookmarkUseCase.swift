//
//  DeleteBookmarkUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct DeleteBookmarkUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute(name: String) throws {
        do {
            try localStorage.deleteBookmarkUser(name)
            ViewChangeManager.shared.bookmarkUsers.accept(localStorage.bookmarkUsers())
        } catch let error {
            throw error
        }
    }
}
