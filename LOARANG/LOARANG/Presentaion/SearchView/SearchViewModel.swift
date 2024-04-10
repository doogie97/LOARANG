//
//  SearchViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput, AnyObject {}

protocol SearchViewModelInput {
    func touchBackButton()
    func touchSearchButton(_ name: String)
    func touchRecentUserCell(_ index: Int)
    func touchBookmarkButton(index: Int, isNowBookmark: Bool)
    func touchDeleteRecentUserButton(_ index: Int)
    func touchClearRecentUserButton()
}

protocol SearchViewModelOutput {
    var recentUser: BehaviorRelay<[RecentUser]> { get }
    var popView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<String> { get }
    var hideKeyboard: PublishRelay<Void> { get }
}

final class SearchViewModel: SearchViewModelable {
    private let storage: AppStorageable
    private let addBookmarkUseCase: AddBookmarkUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    init(storage: AppStorageable,
         addBookmarkUseCase: AddBookmarkUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase) {
        self.storage = storage
        self.addBookmarkUseCase = addBookmarkUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        self.recentUser = ViewChangeManager.shared.recentUsers
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSearchButton(_ name: String) {
        showUserInfo.accept(name)
        hideKeyboard.accept(())
    }
    
    func touchRecentUserCell(_ index: Int) {
        hideKeyboard.accept(())
        guard let userName = ViewChangeManager.shared.recentUsers.value[safe: index]?.name else {
            return
        }
        
        showUserInfo.accept(userName)
    }
    
    func touchBookmarkButton(index: Int, isNowBookmark: Bool) {
        guard let recentUser = ViewChangeManager.shared.recentUsers.value[safe: index] else {
            return
        }
        
        if isNowBookmark {
            do {
                try deleteBookmarkUseCase.execute(name: recentUser.name)
            } catch {}
        } else {
            do {
                try addBookmarkUseCase.execute(user: BookmarkUser(name: recentUser.name,
                                                                  image: recentUser.image,
                                                                  class: recentUser.`class`))
            } catch {}
        }
    }
    
    func touchDeleteRecentUserButton(_ index: Int) {
        guard let name = ViewChangeManager.shared.recentUsers.value[safe: index]?.name else {
            return
        }
        
        do {
            try storage.deleteRecentUser(name)
        } catch {}
    }
    
    func touchClearRecentUserButton() {
        hideKeyboard.accept(())
        do {
            try storage.clearRecentUsers()
        } catch {}
    }
    
    //out
    let recentUser: BehaviorRelay<[RecentUser]>
    let popView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<String>()
    let hideKeyboard = PublishRelay<Void>()
}
