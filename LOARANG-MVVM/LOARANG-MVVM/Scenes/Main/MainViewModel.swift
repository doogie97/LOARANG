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
    func touchMainUserSearchButton(_ userName: String)
    func changeMainUser(_ mainUser: MainUser)
    func touchBookMarkCell(_ index: Int)
    func touchEventCell(_ index: Int)
    func touchMoreEventButton()
}
protocol MainViewModelOutput {
    var mainUser: BehaviorRelay<MainUser?> { get }
    var checkUser: PublishRelay<MainUser> { get }
    var bookmarkUser: BehaviorRelay<[BookmarkUser]> { get }
    var events: BehaviorRelay<[LostArkEvent]> { get }
    var notices: BehaviorRelay<[LostArkNotice]> { get }
    var showSearchView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<String> { get }
    var showWebView: PublishRelay<(url: URL, title: String)> { get }
    var showAlert: PublishRelay<String> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
}

final class MainViewModel: MainViewModelInOut {
    private let storage: AppStorageable
    private let crawlManager = CrawlManager()
    
    init(storage: AppStorageable) {
        self.storage = storage
        self.mainUser = storage.mainUser
        self.bookmarkUser = storage.bookMark
        crawlManager.getEvents { [weak self] result in
            switch result {
            case .success(let event):
                self?.events.accept(event)
            case .failure(let error):
                print(error.errorMessage) //추후 에러 처리 필요(showAlert relay 생성해 처리 예정)
            }
        }
        
        crawlManager.getNotice { [weak self] result in
            switch result {
            case .success(let notice):
                self?.notices.accept(notice)
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
    
    func touchMainUserSearchButton(_ userName: String) {
        startedLoading.accept(())
        crawlManager.getUserInfo(userName) { [weak self] result in
            switch result {
            case .success(let userInfo):
                self?.checkUser.accept(MainUser(image: userInfo.mainInfo.userImage,
                                          battleLV: userInfo.mainInfo.battleLV,
                                          name: userInfo.mainInfo.name,
                                          class: userInfo.mainInfo.`class`,
                                          itemLV: userInfo.mainInfo.itemLV,
                                          server: userInfo.mainInfo.server))
            case .failure(_):
                self?.showAlert.accept("검색하신 유저가 없습니다")
            }
            self?.finishedLoading.accept(())
        }
    }
    
    func changeMainUser(_ mainUser: MainUser) {
        do {
            try storage.changeMainUser(mainUser)
            showAlert.accept("대표 캐릭터 설정이 완료되었습니다")
        } catch {
            showAlert.accept(error.errorMessage)
        }
    }
    
    func touchBookMarkCell(_ index: Int) {
        guard let userName = storage.bookMark.value[safe: index]?.name else {
            return
        }
        showUserInfo.accept(userName)
    }
    
    func touchEventCell(_ index: Int) {
        guard let urlString = events.value[safe: index]?.eventURL else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        showWebView.accept((url: url, title: "이벤트"))
    }
    
    func touchMoreEventButton() {
        guard let url = URL(string: "https://lostark.game.onstove.com/News/Event/Now") else {
            return
        }
        
        showWebView.accept((url: url, title: "이벤트"))
    }
    
    // out
    let mainUser: BehaviorRelay<MainUser?>
    let checkUser = PublishRelay<MainUser>()
    let bookmarkUser: BehaviorRelay<[BookmarkUser]>
    let events = BehaviorRelay<[LostArkEvent]>(value: [])
    let notices = BehaviorRelay<[LostArkNotice]>(value: [])
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<String>()
    let showWebView = PublishRelay<(url: URL, title: String)>()
    let showAlert = PublishRelay<String>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
}
