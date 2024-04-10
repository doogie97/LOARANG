//
//  RecentUserCellViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/06.
//

protocol RecentUserCellViewModelable: RecentUserCellViewModelInput, RecentUserCellViewModelOutput {}

protocol RecentUserCellViewModelInput {
    func touchDeleteButton()
    func touchBookmarkButton()
}

protocol RecentUserCellViewModelOutput {
    var userInfo: RecentUser { get }
    var isBookmarkUser: Bool { get }
}

final class RecentUserCellViewModel: RecentUserCellViewModelable {
    private let storage: AppStorageable
    private let addBookmarkUseCase: AddBookmarkUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    
    init(storage: AppStorageable,
         addBookmarkUseCase: AddBookmarkUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase,
         userInfo: RecentUser) {
        self.storage = storage
        self.addBookmarkUseCase = addBookmarkUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        self.userInfo = userInfo
        self.isBookmarkUser = ViewChangeManager.shared.bookmarkUsers.value.contains(where: { $0.name == userInfo.name })
    }
    
    //in
    func touchDeleteButton() {
        do {
            try storage.deleteRecentUser(userInfo.name)
        } catch {}
    }
    
    func touchBookmarkButton() {
        do {
            if isBookmarkUser {
                try deleteBookmarkUseCase.execute(name: userInfo.name)
            } else {
                try addBookmarkUseCase.execute(user: BookmarkUser(name: userInfo.name,
                                                                  image: userInfo.image,
                                                                  class: userInfo.class))
            }
        } catch {}
        
        isBookmarkUser = ViewChangeManager.shared.bookmarkUsers.value.contains(where: { $0.name == userInfo.name })
    }
    
    //out
    let userInfo: RecentUser
    var isBookmarkUser: Bool
}
