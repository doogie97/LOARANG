//
//  HomeVM.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import RxRelay
import RxSwift

protocol HomeVMable: HomeVMInput, HomeVMOutput, AnyObject {}

protocol HomeVMInput {
    func viewDidLoad()
    func touchSearchButton()
    func touchCell(_ touchCase: HomeVM.TouchCellCase)
}

protocol HomeVMOutput {
    var setViewContents: PublishRelay<HomeVM.ViewContents> { get }
    var isLoading: PublishRelay<Bool> { get }
    var showNextView: PublishRelay<HomeVM.NextViewCase> { get }
}

final class HomeVM: HomeVMable {
    private let getHomeGameInfoUseCase: GetHomeGameInfoUseCase
    private let getHomeCharactersUseCase: GetHomeCharactersUseCase
    private let disposeBag = DisposeBag()
    
    private var homeGameInfo: HomeGameInfoEntity?
    private var bookmarkUsers = [BookmarkUserEntity]()
    
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
                print("VM의 BookmarkUsers와 비교해 해당 인덱스만 리로드")
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - Input
    func viewDidLoad() {
        getHomeGameInfo()
        getHomeCharacters()
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
                    print(error.errorMessage)
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
        case event(rowIndex: Int)
        case notice(rowIndex: Int)
    }
    
    func touchCell(_ touchCase: TouchCellCase) {
        switch touchCase {
        case .mainUser:
            print("메인 유저 검색")
        case .bookmarkUser(let rowIndex):
            print("\(rowIndex) 북마크 유저 검색")
        case .event(let rowIndex):
            print("\(rowIndex) 이벤트")
        case .notice(let rowIndex):
            print("\(rowIndex) 공지")
        }
    }
    
    //MARK: - Output
    enum NextViewCase {
        case searchView
    }
    
    struct ViewContents {
        weak var viewModel: HomeVMable?
        let homeGameInfo: HomeGameInfoEntity
    }
    
    let setViewContents = PublishRelay<ViewContents>()
    let isLoading = PublishRelay<Bool>()
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
