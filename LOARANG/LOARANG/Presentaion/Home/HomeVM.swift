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
    var reloadBookmark: PublishRelay<Void> { get }
    var deleteBookmarkCell: PublishRelay<IndexPath> { get }
    var isLoading: PublishRelay<Bool> { get }
    var showAlert: PublishRelay<String> { get }
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
        ViewChangeManager.shared.mainUser.withUnretained(self)
            .subscribe { owner, mainUser in
                print("\(mainUser?.name)으로 대표 캐릭터 수정")
            }
            .disposed(by: disposeBag)
        
        ViewChangeManager.shared.bookmarkUsers.withUnretained(self)
            .subscribe { owner, _ in
                if !owner.isViewOnTop {
                    owner.reloadBookmark.accept(())
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
            deleteBookmarkUser(rowIndex)
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
    
    private func deleteBookmarkUser(_ rowIndex: Int) {
        guard let userName = ViewChangeManager.shared.bookmarkUsers.value[safe: rowIndex]?.name else {
            showAlert.accept("해당 유저를 찾을 수 없습니다.")
            return
        }
        
        do {
            //유저 삭제시 usecase에서 accept되기에 상단 bindViewChangeManger에서 변경 반영
            try deleteBookmarkUseCase.execute(name: userName)
            deleteBookmarkCell.accept(IndexPath(item: rowIndex,
                                                section: HomeSectionView.SectionCase.bookmark.rawValue))
        } catch let error {
            showAlert.accept(error.errorMessage)
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
    
    let setViewContents = PublishRelay<ViewContents>()
    let reloadBookmark = PublishRelay<Void>()
    let deleteBookmarkCell = PublishRelay<IndexPath>()
    let isLoading = PublishRelay<Bool>()
    let showAlert = PublishRelay<String>()
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
