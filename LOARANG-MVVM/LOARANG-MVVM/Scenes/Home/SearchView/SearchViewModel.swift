//
//  SearchViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput {}

protocol SearchViewModelInput {
    func touchBackButton()
    func touchSearchButton(_ name: String)
    func touchRecentUserCell(_ index: Int)
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
    init(storage: AppStorageable) {
        self.storage = storage
        self.recentUser = storage.recentUsers
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    
    func touchSearchButton(_ name: String) {
        hideKeyboard.accept(())
        showUserInfo.accept(name)
    }
    
    func touchRecentUserCell(_ index: Int) {
        hideKeyboard.accept(())
        guard let userName = storage.recentUsers.value[safe: index]?.name else {
            return
        }
        
        showUserInfo.accept(userName)
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
