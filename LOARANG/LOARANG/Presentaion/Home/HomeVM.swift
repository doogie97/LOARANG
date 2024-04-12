//
//  HomeVM.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import Foundation
import RxRelay
import RxSwift

protocol HomeVMable: HomeVMInput, HomeVMOutput, AnyObject {}

protocol HomeVMInput {
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisAppear()
    func touchSearchButton()
    func touchCell(_ touchCase: HomeVM.TouchCellCase)
}

protocol HomeVMOutput {
    var setViewContents: PublishRelay<HomeVM.ViewContents> { get }
    var setBookmark: PublishRelay<HomeVM.SetBookmarkCase> { get }
    var isLoading: PublishRelay<Bool> { get }
    var showAlert: PublishRelay<String> { get }
    var showNextView: PublishRelay<HomeVM.NextViewCase> { get }
}

final class HomeVM: HomeVMable {
    private let getHomeGameInfoUseCase: GetHomeGameInfoUseCase
    private let getHomeCharactersUseCase: GetHomeCharactersUseCase
    private let disposeBag = DisposeBag()
    
    private var homeGameInfo: HomeGameInfoEntity?
    private var bookmarkUsers = [BookmarkUserEntity]()
    
    private var isViewOnTop = true
    
    init(getHomeGameInfoUseCase: GetHomeGameInfoUseCase,
         getHomeCharactersUseCase: GetHomeCharactersUseCase) {
        self.getHomeGameInfoUseCase = getHomeGameInfoUseCase
        self.getHomeCharactersUseCase = getHomeCharactersUseCase
        bindViewChangeManager()
    }
    
    private func bindViewChangeManager() {
        ViewChangeManager.shared.mainUser.withUnretained(self)
            .subscribe { owner, mainUser in
                print("\(mainUser?.name)으로 대표 캐릭터 수정")
            }
            .disposed(by: disposeBag)
        
        ViewChangeManager.shared.bookmarkUsers.withUnretained(self)
            .subscribe { owner, bookmarkUsers in
                self.bookmarkUsers = bookmarkUsers
                if !owner.isViewOnTop {
                    owner.setBookmark.accept(.reload)
                }
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Input
    func viewDidLoad() {
        getHomeGameInfo()
        getHomeCharacters()
    }
    
    func viewDidAppear() {
        isViewOnTop = true
    }
    
    func viewDidDisAppear() {
        isViewOnTop = false
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
                    showAlert.accept(error.errorMessage)
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
    
    func touchSearchButton() {
        showNextView.accept(.searchView)
    }
    
    enum TouchCellCase {
        case mainUser
        case bookmarkUser(rowIndex: Int)
        case bookmarkStarButton(rowIndex: Int)
        case event(rowIndex: Int)
        case notice(rowIndex: Int)
    }
    
    func touchCell(_ touchCase: TouchCellCase) {
        switch touchCase {
        case .mainUser:
            print("메인 유저 검색")
        case .bookmarkUser(let rowIndex):
            print("\(rowIndex) 북마크 유저 검색")
        case .bookmarkStarButton(let rowIndex):
            print("\(rowIndex) 북마크 유저 삭제")
        case .event(let rowIndex):
            guard let eventUrl = homeGameInfo?.eventList[safe: rowIndex]?.eventUrl,
                  let url = URL(string: eventUrl) else {
                showAlert.accept("해당 이벤트를 찾을 수 없습니다.")
                return
            }
            showNextView.accept(.webView(url: url, title: "이벤트"))
        case .notice(let rowIndex):
            guard let eventUrl = homeGameInfo?.noticeList[safe: rowIndex]?.url,
                  let url = URL(string: eventUrl) else {
                showAlert.accept("해당 공지사항을 찾을 수 없습니다.")
                return
            }
            showNextView.accept(.webView(url: url, title: "공지사항"))
        }
    }
    
    //MARK: - Output
    enum NextViewCase {
        case searchView
        case webView(url: URL, title: String)
    }
    
    struct ViewContents {
        weak var viewModel: HomeVMable?
        let homeGameInfo: HomeGameInfoEntity
    }
    
    enum SetBookmarkCase {
        case reload
        case append
        case delete
    }
    
    let setViewContents = PublishRelay<ViewContents>()
    let setBookmark = PublishRelay<SetBookmarkCase>()
    let isLoading = PublishRelay<Bool>()
    let showAlert = PublishRelay<String>()
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
