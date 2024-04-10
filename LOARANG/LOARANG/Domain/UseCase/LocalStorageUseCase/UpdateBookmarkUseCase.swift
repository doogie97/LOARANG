//
//  UpdateBookmarkUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

struct UpdateBookmarkUseCase {
    private let localStorage: LocalStorageable
    
    init(localStorage: LocalStorageable) {
        self.localStorage = localStorage
    }
    
    func execute(user: BookmarkUserEntity) throws {
        do {
            try localStorage.updateBookmarkUser(user)
            ViewChangeManager.shared.bookmarkUsers.accept(localStorage.bookmarkUsers())
        } catch let error {
            throw error
        }
    }
}
