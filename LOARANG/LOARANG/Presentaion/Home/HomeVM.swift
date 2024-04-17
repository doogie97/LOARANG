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
import UIKit

protocol HomeVMable: HomeVMInput, HomeVMOutput, AnyObject {}

protocol HomeVMInput {
    func viewDidLoad()
    func touchViewAction(_ touchCase: HomeVM.ActionCase)
}

protocol HomeVMOutput {
    var setViewContents: PublishRelay<HomeVM.ViewContents> { get }
    var reloadMainUserSection: PublishRelay<Void> { get }
    var reloadBookmark: PublishRelay<Void> { get }
    var appendBookmarkCell: PublishRelay<Int> { get }
    var deleteBookmarkCell: PublishRelay<IndexPath> { get }
    var updateBookmarkCell: PublishRelay<IndexPath> { get }
    var isLoading: PublishRelay<Bool> { get }
    var showAlert: PublishRelay<HomeVM.AlertCase> { get }
    var showNextView: PublishRelay<HomeVM.NextViewCase> { get }
}

final class HomeVM: HomeVMable {
    private let getHomeGameInfoUseCase: GetHomeGameInfoUseCase
    private let getHomeCharactersUseCase: GetHomeCharactersUseCase
    private let deleteBookmarkUseCase: DeleteBookmarkUseCase
    private let getCharacterDetailUseCase: GetCharacterDetailUseCase
    private let changeMainUserUseCase: ChangeMainUserUseCase
    private let disposeBag = DisposeBag()
    
    private var homeGameInfo: HomeGameInfoEntity?
    ///유저 삭제시 false로 변경 필요
    private var hasMainUser = false
    private var bookmarkUsers = [BookmarkUserEntity]()
    
    private var isViewDidLoad = false
    
    init(getHomeGameInfoUseCase: GetHomeGameInfoUseCase,
         getHomeCharactersUseCase: GetHomeCharactersUseCase,
         deleteBookmarkUseCase: DeleteBookmarkUseCase,
         getCharacterDetailUseCase: GetCharacterDetailUseCase,
         changeMainUserUseCase: ChangeMainUserUseCase) {
        self.getHomeGameInfoUseCase = getHomeGameInfoUseCase
        self.getHomeCharactersUseCase = getHomeCharactersUseCase
        self.deleteBookmarkUseCase = deleteBookmarkUseCase
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.changeMainUserUseCase = changeMainUserUseCase
        bindViewChangeManager()
    }
    
    private func bindViewChangeManager() {
        ViewChangeManager.shared.bookmarkUsers.withUnretained(self)
            .subscribe { owner, bookmarkUsers in
                let oldBookmarkUsers = owner.bookmarkUsers
                owner.bookmarkUsers = bookmarkUsers
                if owner.isViewDidLoad {
                    //기존 즐겨찾기 유저가 0명일 때 -> reload
                    if oldBookmarkUsers.count == 0 {
                        owner.reloadBookmark.accept(())
                        return
                    }
                    
                    //기존 즐겨찾기 유저가 새로 accept된 즐겨찾기 유저 보다 적을 경우 => 추가된 경우
                    if oldBookmarkUsers.count < bookmarkUsers.count {
                        owner.appendBookmarkCell.accept(bookmarkUsers.count)
                        return
                    }
                    
                    //기존 즐겨찾기 유저가 새로 accept된 즐겨찾기 유저 보다 많을 경우 => 삭제된 경우
                    if oldBookmarkUsers.count > bookmarkUsers.count {
                        for (index, userInfo) in oldBookmarkUsers.enumerated() {
                            if !bookmarkUsers.contains(where: { $0.name == userInfo.name }) {
                                owner.deleteBookmarkCell.accept(IndexPath(item: index,
                                                                          section: HomeSectionView.SectionCase.bookmark.rawValue))
                            }
                        }
                        return
                    }
                    
                    //기존 즐겨찾기 유저와 새로 accept된 즐겨찾기 유저와 같을 경우 => update
                    if oldBookmarkUsers.count == bookmarkUsers.count {
                        var changedIndex: Int?
                        for index in 0..<bookmarkUsers.count {
                            let oldUserInfo = oldBookmarkUsers[index]
                            let newUserInfo = bookmarkUsers[index]
                            if oldUserInfo.name != newUserInfo.name || oldUserInfo.characterClass != newUserInfo.characterClass || oldUserInfo.imageUrl != newUserInfo.imageUrl {
                                changedIndex = index
                            }
                        }
                        guard let changedIndex = changedIndex else {
                            return
                        }
                        owner.updateBookmarkCell.accept(IndexPath(item: changedIndex,
                                                                  section: HomeSectionView.SectionCase.bookmark.rawValue))
                        return
                    }
                }
            }
            .disposed(by: disposeBag)
        
        ViewChangeManager.shared.mainUser.withUnretained(self)
            .subscribe { owner, mainUser in
                    //기존에 유저가 없음 -> 유저가 추가됨 => reload
                if let _ = mainUser {
                    if !owner.hasMainUser {
                        owner.reloadMainUserSection.accept(())
                        owner.hasMainUser = true
                    }
                } else {
                    //기존에 유저가 있음 -> 유저가 삭제됨 => reload
                    if owner.hasMainUser {
                        owner.reloadMainUserSection.accept(())
                        owner.hasMainUser = false
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Input
    func viewDidLoad() {
        getHomeGameInfo()
        getHomeCharacters()
        requestTraking()
        isViewDidLoad = true
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
                    if let error = (error as? APIError),
                       error == .statusCodeError(503) {
                        showAlert.accept(.inspection(message: error.errorMessage))
                    } else {
                        showAlert.accept(.pop(messege: error.errorMessage))
                    }
                    isLoading.accept(false)
                }
            }
        }
    }
    
    private func getHomeCharacters() {
        let homeCharacters = getHomeCharactersUseCase.execute()
        ViewChangeManager.shared.mainUser.accept(homeCharacters.mainUser)
        ViewChangeManager.shared.bookmarkUsers.accept(homeCharacters.bookmarkUsers)
        if homeCharacters.mainUser != nil {
            self.hasMainUser = true
        }
        self.bookmarkUsers = homeCharacters.bookmarkUsers
    }
    
    enum ActionCase {
        case mainUser
        case touchRegistMainUserButton
        case searchMainUser(name: String)
        case changeMainUser(userInfo: CharacterDetailEntity)
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
            showNextView.accept(.characterDetail(name: name))
        case .touchRegistMainUserButton:
            showAlert.accept(.searchMainUser)
        case .searchMainUser(let name):
            getCharacterDetail(name)
        case .changeMainUser(let userInfo):
            changeMainUser(userInfo)
        case .bookmarkUser(let rowIndex):
            guard let name = ViewChangeManager.shared.bookmarkUsers.value[safe: rowIndex]?.name else {
                return
            }
            showNextView.accept(.characterDetail(name: name))
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
            //bindViewChangeManager에서 뷰 반영 할 것이기 때문에 삭제까지만 진행
        } catch let error {
            showAlert.accept(.basic(message: error.errorMessage))
        }
    }
    
    private func getCharacterDetail(_ name: String) {
        isLoading.accept(true)
        Task {
            do {
                let userInfo = try await getCharacterDetailUseCase.excute(name: name)
                await MainActor.run {
                    showAlert.accept(.checkMainUer(userInfo: userInfo))
                    isLoading.accept(false)
                }
            } catch let error {
                await MainActor.run {
                    if let apiError = error as? APIError, apiError == .DecodingError {
                        showAlert.accept(.basic(message: "해당 캐릭터를 찾을 수 없습니다."))
                    } else {
                        showAlert.accept(.basic(message: error.errorMessage))
                    }
                    isLoading.accept(false)
                }
            }
        }
    }
    
    private func changeMainUser(_ userInfo: CharacterDetailEntity) {
        do {
            try changeMainUserUseCase.execute(user: userInfo.toLocalStorageEntity)
            showAlert.accept(.basic(message: "대표 캐릭터 설정이 완료되었습니다!"))
        } catch let error {
            showAlert.accept(.basic(message: error.errorMessage))
        }
    }
    
    //MARK: - Output
    enum NextViewCase {
        case searchView
        case webView(url: String?, title: String)
        case characterDetail(name: String)
    }
    
    enum AlertCase {
        case inspection(message: String)
        case pop(messege: String)
        case basic(message: String)
        case searchMainUser
        case checkMainUer(userInfo: CharacterDetailEntity)
    }
    
    struct ViewContents {
        weak var viewModel: HomeVMable?
        let homeGameInfo: HomeGameInfoEntity
    }
    
    let setViewContents = PublishRelay<ViewContents>()
    let reloadMainUserSection = PublishRelay<Void>()
    let reloadBookmark = PublishRelay<Void>()
    let appendBookmarkCell = PublishRelay<Int>()
    let deleteBookmarkCell = PublishRelay<IndexPath>()
    let updateBookmarkCell = PublishRelay<IndexPath>()
    let isLoading = PublishRelay<Bool>()
    let showAlert = PublishRelay<AlertCase>()
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
