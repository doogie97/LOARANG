//
//  UpdateBookmarkUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct UpdateBookmarkUseCase {
    private let localStorage: LocalStorageRepositoryable
    
    init(localStorageRepository: LocalStorageRepositoryable) {
        self.localStorage = localStorageRepository
    }
    
    func execute(user: BookmarkUserEntity) throws {
        let oldValue = ViewChangeManager.shared.bookmarkUsers.value
        do {
            try localStorage.updateBookmarkUser(user.toDTO)
            let newValue = oldValue.compactMap {
                if user.name == $0.name {
                    return user
                } else {
                    return $0
                }
            }
            ViewChangeManager.shared.bookmarkUsers.accept(newValue)
        } catch let error {
            throw error
        }
    }
}
