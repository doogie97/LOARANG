//
//  SearchViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput, AnyObject {}

protocol SearchViewModelInput {
    func viewDidLoad()
    func touchBackButton()
    func touchSearchButton(_ name: String)
    func touchRecentUserCell(_ index: Int)
    func touchBookmarkButton(index: Int, isNowBookmark: Bool)
    func touchDeleteRecentUserButton(_ index: Int)
    func touchClearRecentUserButton()
}

protocol SearchViewModelOutput {
    var popView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<String> { get }
    var hideKeyboard: PublishRelay<Void> { get }
}

final class SearchViewModel: SearchViewModelable {
    private let storage: AppStorageable
    private let getRecentUsersUseCase: GetRecentUsersUseCase
    private let addBookmarkUseCase: AddBookmarkUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    private let deleteRecentUserUseCase: DeleteRecentUserUseCase
    
    init(storage: AppStorageable,
         getRecentUsersUseCase: GetRecentUsersUseCase,
         addBookmarkUseCase: AddBookmarkUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase,
         deleteRecentUserUseCase: DeleteRecentUserUseCase) {
        self.storage = storage
        self.getRecentUsersUseCase = getRecentUsersUseCase
        self.addBookmarkUseCase = addBookmarkUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        self.deleteRecentUserUseCase = deleteRecentUserUseCase
    }
    
    //in
    func viewDidLoad() {
        let recentUsers = getRecentUsersUseCase.execute()
        ViewChangeManager.shared.recentUsers.accept(recentUsers)
    }
    
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
                try addBookmarkUseCase.execute(user: BookmarkUserEntity(name: recentUser.name,
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
            try deleteRecentUserUseCase.execute(name: name)
        } catch {}
    }
    
    func touchClearRecentUserButton() {
        hideKeyboard.accept(())
        do {
            try deleteRecentUserUseCase.execute(isClear: true)
        } catch {}
    }
    
    //out
    let popView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<String>()
    let hideKeyboard = PublishRelay<Void>()
}
