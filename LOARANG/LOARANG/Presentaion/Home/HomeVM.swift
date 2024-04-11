//
//  HomeVM.swift
//  LOARANG
//
//  Created by Doogie on 4/11/24.
//

protocol HomeVMable: HomeVMInput, HomeVMOutput, AnyObject {}

protocol HomeVMInput {
    func touchSearchButton()
}

protocol HomeVMOutput {}

final class HomeVM: HomeVMable {
    //MARK: - Input
    func touchSearchButton() {
        print("검색 버튼")
    }
}
