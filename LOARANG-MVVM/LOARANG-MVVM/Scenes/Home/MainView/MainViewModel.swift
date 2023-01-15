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
    func viewDidAppear()
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
    private let networkManager: NetworkManagerable
    
    init(storage: AppStorageable, networkManager: NetworkManagerable) {
        self.storage = storage
        self.networkManager = networkManager
        self.mainUser = storage.mainUser
        self.bookmarkUser = storage.bookMark
    }
    
    func viewDidAppear() {
        getEvent()
        getNotice()
    }
    
    private func getEvent() {
        guard events.value.isEmpty else {
            return
        }
        
        Task {
            do {
                let news = try await networkManager.request(NewsAPIModel(), resultType: [News].self)
                await MainActor.run {
                    events.accept(news)
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept(error.limitErrorMessage ?? "이벤트 정보를 가져올 수 없습니다.")
                }
            }
        }
    }
    
    private func getNotice() {
        guard notices.value.isEmpty else {
            return
        }
        
        crawlManager.getNotice { [weak self] result in
            switch result {
            case .success(let notice):
                self?.notices.accept(notice)
            case .failure(let error):
                self?.showAlert.accept(error.errorMessage)
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
