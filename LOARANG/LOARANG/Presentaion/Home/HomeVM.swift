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
    
    private var homeGameInfo: HomeGameInfoEntity?
    private var homeCharacterInfo: HomeCharactersEntity?
    
    init(getHomeGameInfoUseCase: GetHomeGameInfoUseCase) {
        self.getHomeGameInfoUseCase = getHomeGameInfoUseCase
    }
    
    //MARK: - Input
    func viewDidLoad() {
        getHomeGameInfo()
    }
    
    private func getHomeGameInfo() {
        Task {
            do {
                self.homeGameInfo = try await getHomeGameInfoUseCase.execute()
                await MainActor.run {
                    if homeCharacterInfo != nil {
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
