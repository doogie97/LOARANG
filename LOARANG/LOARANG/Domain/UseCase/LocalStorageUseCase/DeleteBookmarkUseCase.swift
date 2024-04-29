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
        let oldValue = ViewChangeManager.shared.bookmarkUsers.value
        do {
            try localStorage.deleteBookmarkUser(name)
            let newValue = oldValue.filter { $0.name != name }
            ViewChangeManager.shared.bookmarkUsers.accept(newValue)
        } catch let error {
            throw error
        }
    }
}
