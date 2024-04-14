//
//  HomeVM.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import Foundation
import RxRelay
import RxSwift
import AppTrackingTransparency

protocol HomeVMable: HomeVMInput, HomeVMOutput, AnyObject {}

protocol HomeVMInput {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisAppear()
    func touchViewAction(_ touchCase: HomeVM.ActionCase)
}

protocol HomeVMOutput {
    var setViewContents: PublishRelay<HomeVM.ViewContents> { get }
    var reloadMainUserSection: PublishRelay<Void> { get }
    var reloadBookmark: PublishRelay<Void> { get }
    var deleteBookmarkCell: PublishRelay<IndexPath> { get }
    var isLoading: PublishRelay<Bool> { get }
    var showAlert: PublishRelay<HomeVM.AlertCase> { get }
    var showNextView: PublishRelay<HomeVM.NextViewCase> { get }
}

final class HomeVM: HomeVMable {
    private let getHomeGameInfoUseCase: GetHomeGameInfoUseCase
    private let getHomeCharactersUseCase: GetHomeCharactersUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    private let disposeBag = DisposeBag()
    
    private var homeGameInfo: HomeGameInfoEntity?
    
    private var isViewOnTop = true
    
    init(getHomeGameInfoUseCase: GetHomeGameInfoUseCase,
         getHomeCharactersUseCase: GetHomeCharactersUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase) {
        self.getHomeGameInfoUseCase = getHomeGameInfoUseCase
        self.getHomeCharactersUseCase = getHomeCharactersUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        bindViewChangeManager()
    }
    
    private func bindViewChangeManager() {
        ViewChangeManager.shared.bookmarkUsers.withUnretained(self)
            .subscribe { owner, _ in
                if !owner.isViewOnTop {
                    owner.reloadBookmark.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        ViewChangeManager.shared.mainUser.withUnretained(self)
            .subscribe { owner, mainUser in
                owner.reloadMainUserSection.accept(())
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Input
    func viewDidLoad() {
        getHomeGameInfo()
        getHomeCharacters()
        requestTraking()
    }
    
    func viewDidAppear() {
        isViewOnTop = true
    }
    
    func viewDidDisAppear() {
        isViewOnTop = false
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
    
    private func getHomeGameInfo() {
        isLoading.accept(true)
        Task {
            do {
                let homeGameInfo = try await getHomeGameInfoUseCase.execute()
                self.homeGameInfo = homeGameInfo
                await MainActor.run {
                    setViewContents.accept(ViewContents(viewModel: self,
                                                        homeGameInfo: homeGameInfo))
                    isLoading.accept(false)
                }
            } catch let error {
                await MainActor.run {
                    showAlert.accept(.pop(messege: error.errorMessage))
                    isLoading.accept(false)
                }
            }
        }
    }
    
    private func getHomeCharacters() {
        let homeCharacters = getHomeCharactersUseCase.execute()
        ViewChangeManager.shared.mainUser.accept(homeCharacters.mainUser)
        ViewChangeManager.shared.bookmarkUsers.accept(homeCharacters.bookmarkUsers)
    }
    
    enum ActionCase {
        case mainUser
        case touchRegistMainUserButton
        case bookmarkUser(rowIndex: Int)
        case bookmarkStarButton(rowIndex: Int)
        case search
        case event(rowIndex: Int)
        case notice(rowIndex: Int)
        case moreEvent
        case moreNotice
    }
    
    func touchViewAction(_ actionCase: ActionCase) {
        switch actionCase {
        case .mainUser:
            guard let name = ViewChangeManager.shared.mainUser.value?.name else {
                return
            }
            showNextView.accept(.charterDetail(name: name))
            print("대표 캐릭터 등록을 위한 검색")
        case .touchRegistMainUserButton:
        case .bookmarkUser(let rowIndex):
            guard let name = ViewChangeManager.shared.bookmarkUsers.value[safe: rowIndex]?.name else {
                return
            }
            showNextView.accept(.charterDetail(name: name))
        case .bookmarkStarButton(let rowIndex):
            deleteBookmarkUser(rowIndex)
        case .search:
            showNextView.accept(.searchView)
        case .event(let rowIndex):
            showNextView.accept(.webView(url: homeGameInfo?.eventList[safe: rowIndex]?.eventUrl, title: "이벤트"))
        case .notice(let rowIndex):
            showNextView.accept(.webView(url: homeGameInfo?.noticeList[safe: rowIndex]?.url, title: "공지사항"))
        case .moreEvent:
            showNextView.accept(.webView(url: "https://lostark.game.onstove.com/News/Event/Now", title: "이벤트"))
        case .moreNotice:
            showNextView.accept(.webView(url: "https://lostark.game.onstove.com/News/Notice/List", title: "공지사항"))
        }
    }
    
    private func deleteBookmarkUser(_ rowIndex: Int) {
        guard let userName = ViewChangeManager.shared.bookmarkUsers.value[safe: rowIndex]?.name else {
            showAlert.accept(.basic(message: "해당 유저를 찾을 수 없습니다."))
            return
        }
        
        do {
            try deleteBookmarkUseCase.execute(name: userName)
            deleteBookmarkCell.accept(IndexPath(item: rowIndex,
                                                section: HomeSectionView.SectionCase.bookmark.rawValue))
        } catch let error {
            showAlert.accept(.basic(message: error.errorMessage))
        }
    }
    
    //MARK: - Output
    enum NextViewCase {
        case searchView
        case webView(url: String?, title: String)
        case charterDetail(name: String)
    }
    
    enum AlertCase {
        case pop(messege: String)
        case basic(message: String)
    }
    
    struct ViewContents {
        weak var viewModel: HomeVMable?
        let homeGameInfo: HomeGameInfoEntity
    }
    
    let setViewContents = PublishRelay<ViewContents>()
    let reloadMainUserSection = PublishRelay<Void>()
    let reloadBookmark = PublishRelay<Void>()
    let deleteBookmarkCell = PublishRelay<IndexPath>()
    let isLoading = PublishRelay<Bool>()
    let showAlert = PublishRelay<AlertCase>()
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
