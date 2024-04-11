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
    var setViewContents: PublishRelay<Void> { get }
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
        Task {
            do {
                self.homeGameInfo = try await getHomeGameInfoUseCase.execute()
                await MainActor.run {
                    if homeCharacters != nil {
                        setViewContents.accept(())
                    }
                }
            } catch let error {
                await MainActor.run {
                    print(error.errorMessage)
                }
            }
        }
    }
    
    private func getHomeCharacters() {
        self.homeCharacters = getHomeCharactersUseCase.execute()
        if homeGameInfo != nil {
            setViewContents.accept(())
        }
    }
    
    func touchSearchButton() {
        showNextView.accept(.searchView)
    }
    
    //MARK: - Output
    enum NextViewCase {
        case searchView
    }
    
    let setViewContents = PublishRelay<Void>()
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
