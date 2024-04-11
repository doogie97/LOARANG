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
    
//    private var homeInfo
    init(getHomeGameInfoUseCase: GetHomeGameInfoUseCase) {
        self.getHomeGameInfoUseCase = getHomeGameInfoUseCase
    }
    
    //MARK: - Input
    func viewDidLoad() {
        setViewContents.accept(())
    }
    
    private func getHomeGameInfo() {
        
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
