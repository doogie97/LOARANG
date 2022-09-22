//
//  MainViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

protocol MainViewModelInOut: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {
    func touchSerachButton()
    func touchMainUser()
    func touchBookMarkCell(_ index: Int)
}
protocol MainViewModelOutput {
    var mainUser: BehaviorRelay<MainUser?> { get }
    var bookmarkUser: BehaviorRelay<[BookmarkUser]> { get }
    var events: BehaviorRelay<[LostArkEvent]> { get }
    var showSearchView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<String> { get }
}

final class MainViewModel: MainViewModelInOut {
    private var storage: AppStorageable
    
    init(storage: AppStorageable) {
        self.storage = storage
        self.mainUser = storage.mainUser
        self.bookmarkUser = storage.bookMark
        CrawlManager().getEvents { [weak self] result in
            switch result {
            case .success(let event):
                self?.events.accept(event)
            case .failure(let error):
                print(error.errorMessage) //추후 에러 처리 필요(showAlert relay 생성해 처리 예정)
            }
        }
    }
    
    // in
    func touchSerachButton() {
        showSearchView.accept(())
    }
    
    func touchMainUser() {
        guard let mainUser = mainUser.value else {
            return
        }
        
        showUserInfo.accept(mainUser.name)
    }
    
    func touchBookMarkCell(_ index: Int) {
        guard let userName = storage.bookMark.value[safe: index]?.name else {
            return
        }
        showUserInfo.accept(userName)
    }
    
    // out
    let mainUser: BehaviorRelay<MainUser?>
    let bookmarkUser: BehaviorRelay<[BookmarkUser]>
    let events = BehaviorRelay<[LostArkEvent]>(value: [])
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<String>()
}
