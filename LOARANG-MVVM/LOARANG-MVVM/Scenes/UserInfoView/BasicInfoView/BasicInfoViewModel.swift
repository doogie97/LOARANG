//
//  BasicInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/01.
//

protocol BasicInfoViewModelable: BasicInfoViewModelInput, BasicInfoViewModelOutput {}

protocol BasicInfoViewModelInput {}

protocol BasicInfoViewModelOutput {
    var userInfo: UserInfo { get }
}

final class BasicInfoViewModel: BasicInfoViewModelable {
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    //out
    let userInfo: UserInfo
}
