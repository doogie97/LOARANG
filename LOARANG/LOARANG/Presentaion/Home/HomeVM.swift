//
//  HomeVM.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import RxRelay

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
    
    private var homeGameInfo: HomeGameInfoEntity?
    private var homeCharacters: HomeCharactersEntity?
    
    init(getHomeGameInfoUseCase: GetHomeGameInfoUseCase,
         getHomeCharactersUseCase: GetHomeCharactersUseCase) {
        self.getHomeGameInfoUseCase = getHomeGameInfoUseCase
        self.getHomeCharactersUseCase = getHomeCharactersUseCase
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
                self.homeGameInfo = try await getHomeGameInfoUseCase.execute()
                await MainActor.run {
                    checkViewContents()
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
        self.homeCharacters = getHomeCharactersUseCase.execute()
        checkViewContents()
    }
    
    private func checkViewContents() {
        guard let homeGameInfo = self.homeGameInfo,
              let homeCharacters = self.homeCharacters else {
            return
        }
        
        setViewContents.accept(ViewContents(viewModel: self,
                                            homeGameInfo: homeGameInfo,
                                            homeCharacters: homeCharacters))
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
        let homeCharacters: HomeCharactersEntity
    }
    
    let setViewContents = PublishRelay<ViewContents>()
    let isLoading = PublishRelay<Bool>()
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
