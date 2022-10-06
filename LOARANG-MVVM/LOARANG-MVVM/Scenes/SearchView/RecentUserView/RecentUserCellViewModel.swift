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
    
    init(storage: AppStorageable, userInfo: RecentUser) {
        self.storage = storage
        self.userInfo = userInfo
        self.isBookmarkUser = storage.isBookmarkUser(userInfo.name)
    }
    
    //in
    func touchDeleteButton() {
        do {
            try storage.deleteRecentUser(userInfo.name)
        } catch {}
    }
    
    func touchBookmarkButton() {
        do {
            if storage.isBookmarkUser(userInfo.name) {
                try storage.deleteUser(userInfo.name)
            } else {
                try storage.addUser(BookmarkUser(name: userInfo.name,
                                             image: userInfo.image,
                                             class: userInfo.class))
            }
        } catch {}
        
        isBookmarkUser = storage.isBookmarkUser(userInfo.name)
    }
    
    //out
    let userInfo: RecentUser
    var isBookmarkUser: Bool
}
