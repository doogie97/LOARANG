//
//  MainViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay
import AppTrackingTransparency

protocol MainViewModelInOut: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelInput {
    func viewDidLoad()
    
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
    var checkUser: PublishRelay<MainUser> { get }
    var bookmarkUser: BehaviorRelay<[BookmarkUser]> { get }
    var events: BehaviorRelay<[EventDTO]> { get }
    var notices: BehaviorRelay<[LostArkNotice]> { get }
    var showSearchView: PublishRelay<Void> { get }
    var showUserInfo: PublishRelay<String> { get }
    var showWebView: PublishRelay<(url: URL, title: String)> { get }
    var showAlert: PublishRelay<String> { get }
    var showExitAlert: PublishRelay<(title: String, message: String)> { get }
    var startedLoading: PublishRelay<Void> { get }
    var finishedLoading: PublishRelay<Void> { get }
}

final class MainViewModel: MainViewModelInOut {
    private let storage: AppStorageable
    private let crawlManager = CrawlManager() // 크롤링 -> API로 전면 수정 후 제거 필요
    private let networkManager = NetworkManager()
    
    private let getHomeInfoUseCase: GetHomeInfoUseCase
    private let getHomeCharactersUseCase: GetHomeCharactersUseCase
    private let changeMainUserUseCase: ChangeMainUserUseCase
    
    init(storage: AppStorageable,
         getHomeInfoUseCase: GetHomeInfoUseCase,
         getHomeCharactersUseCase: GetHomeCharactersUseCase,
         changeMainUserUseCase: ChangeMainUserUseCase) {
        self.getHomeInfoUseCase = getHomeInfoUseCase
        self.getHomeCharactersUseCase = getHomeCharactersUseCase
        self.changeMainUserUseCase = changeMainUserUseCase
        self.storage = storage
        self.bookmarkUser = storage.bookMark
    }
    
    // in
    func viewDidLoad() {
        requestTraking()
        startedLoading.accept(())
        Task {
            do {
                let homeEntity = try await getHomeInfoUseCase.execute()
                
                let news = try await networkManager.request(EventListGET(),
                                                            resultType: [EventDTO].self)
                let notices = try await crawlManager.getNotice()
                await MainActor.run {
                    self.notices.accept(notices)
                    self.events.accept(news)
                    finishedLoading.accept(())
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept(error.errorMessage)
                    finishedLoading.accept(())
                }
            }
        }
        
        let homeCharactersEntity = getHomeCharactersUseCase.execute()
        ViewChangeManager.shared.mainUser.accept(homeCharactersEntity.mainUser)
    }
    
    private func requestTraking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("status= authorized")
                case .denied:
                    print("status= denied")
                case .notDetermined:
                    print("status= notDetermined")
                case .restricted:
                    print("status= restricted")
                @unknown default:
                    print("status= default")
                }
            }
        }
    }
    
    func touchSerachButton() {
        showSearchView.accept(())
    }
    
    func touchMainUser() {
        guard let name = ViewChangeManager.shared.mainUser.value?.name else {
            return
        }
        
        showUserInfo.accept(name)
    }
    
    func touchMainUserSearchButton(_ userName: String) {
        startedLoading.accept(())
        Task {
            do {
                let searchResult = try await crawlManager.getUserInfo(userName)
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
                await MainActor.run {
                    showAlert.accept(error.errorMessage)
                    finishedLoading.accept(())
                }                
            }
        }
    }
    
    func changeMainUser(_ mainUser: MainUser) {
        do {
            try changeMainUserUseCase.execute(user: mainUser)
            ViewChangeManager.shared.mainUser.accept(mainUser)
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
    let checkUser = PublishRelay<MainUser>()
    let bookmarkUser: BehaviorRelay<[BookmarkUser]>
    let events = BehaviorRelay<[EventDTO]>(value: [])
    let notices = BehaviorRelay<[LostArkNotice]>(value: [])
    let showSearchView = PublishRelay<Void>()
    let showUserInfo = PublishRelay<String>()
    let showWebView = PublishRelay<(url: URL, title: String)>()
    let showAlert = PublishRelay<String>()
    let showExitAlert = PublishRelay<(title: String, message: String)>()
    let startedLoading = PublishRelay<Void>()
    let finishedLoading = PublishRelay<Void>()
}
