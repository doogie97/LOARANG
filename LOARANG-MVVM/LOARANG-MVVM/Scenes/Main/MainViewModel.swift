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
    func touchNoticeCell(_ index: Int)
    func touchMoreNoticeButton()
}
protocol MainViewModelOutput {
    var mainUser: BehaviorRelay<MainUser?> { get }
    var checkUser: PublishRelay<MainUser> { get }
    var bookmarkUser: BehaviorRelay<[BookmarkUser]> { get }
    var events: BehaviorRelay<[News]> { get }
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
    private let crawlManager = CrawlManager() // 크롤링 -> API로 전면 수정 후 제거 필요
    private let networkManager = NetworkManager()
    
    init(storage: AppStorageable) {
        self.storage = storage
        self.mainUser = storage.mainUser
        self.bookmarkUser = storage.bookMark
        
        getEvent()
        getNotice()
    }
    
    private func getEvent() {
        networkManager.request(NewsAPIModel(), resultType: [News].self) { [weak self] result in
            switch result {
            case .success(let news):
                self?.events.accept(news)
            case .failure(let error):
                self?.showAlert.accept(error.errorMessage)
            }
        }
    }
    
    private func getNotice() {
        Task {
            do {
                let notices = try await crawlManager.getNotice()
                await MainActor.run {
                    self.notices.accept(notices)
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept(error.errorMessage)
                }
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
        Task {
            do {
                let searchResult = try await crawlManager.getUserInfo2(userName)
                await MainActor.run {
                    checkUser.accept(MainUser(image: searchResult.mainInfo.userImage,
                                              battleLV: searchResult.mainInfo.battleLV,
                                              name: searchResult.mainInfo.name,
                                              class: searchResult.mainInfo.`class`,
                                              itemLV: searchResult.mainInfo.itemLV,
                                              server: searchResult.mainInfo.server))
                    finishedLoading.accept(())
                }
            } catch let error {
                showAlert.accept(error.errorMessage)
                finishedLoading.accept(())
            }
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
        guard let urlString = events.value[safe: index]?.link else {
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
    
    func touchNoticeCell(_ index: Int) {
        guard let urlString = notices.value[safe: index]?.noticeURL else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        showWebView.accept((url: url, title: "공지사항"))
    }
    
    func touchMoreNoticeButton() {
        guard let url = URL(string: "https://lostark.game.onstove.com/News/Notice/List") else {
            return
        }
        
        showWebView.accept((url: url, title: "공지사항"))
    }
    
    // out
    let mainUser: BehaviorRelay<MainUser?>
    let checkUser = PublishRelay<MainUser>()
    let bookmarkUser: BehaviorRelay<[BookmarkUser]>
    let events = BehaviorRelay<[News]>(value: [])
    let notices = BehaviorRelay<[LostArkNotice]>(value: [])
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<String>()
    let showWebView = PublishRelay<(url: URL, title: String)>()
    let showAlert = PublishRelay<String>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
}
