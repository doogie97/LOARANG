//
//  UserInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

protocol UserInfoViewModelable: UserInfoViewModelInput, UserInfoViewModelOutput {}

protocol UserInfoViewModelInput {}

protocol UserInfoViewModelOutput {
    var userInfo: UserInfo { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: Storageable
    let userInfo: UserInfo
    
    init(storage: Storageable, userInfo: UserInfo) {
        self.storage = storage
        self.userInfo = userInfo
    }
}
