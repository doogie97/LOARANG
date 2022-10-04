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
}

protocol SearchViewModelOutput {
    var recentUser: BehaviorRelay<[RecentUser]> { get }
    var popView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<String> { get }
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
        showUserInfo.accept(name)
    }
    
    //out
    let recentUser: BehaviorRelay<[RecentUser]>
    let popView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<String>()
}
