//
//  HomeVM.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

import RxRelay

protocol HomeVMable: HomeVMInput, HomeVMOutput, AnyObject {}

protocol HomeVMInput {
    func touchSearchButton()
}

protocol HomeVMOutput {
    var showNextView: PublishRelay<HomeVM.NextViewCase> { get }
}

final class HomeVM: HomeVMable {
    //MARK: - Input
    func touchSearchButton() {
        showNextView.accept(.searchView)
    }
    
    //MARK: - Output
    enum NextViewCase {
        case searchView
    }
    
    let showNextView = PublishRelay<HomeVM.NextViewCase>()
}
