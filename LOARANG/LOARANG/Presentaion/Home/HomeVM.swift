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
