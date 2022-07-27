//
//  UserInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxRelay

protocol UserInfoViewModelable: UserInfoViewModelInput, UserInfoViewModelOutput {}

protocol UserInfoViewModelInput {
    func touchBackButton()
}

protocol UserInfoViewModelOutput {
    var userInfo: UserInfo { get }
    var popView: PublishRelay<Void> { get }
}

final class UserInfoViewModel: UserInfoViewModelable {
    private let storage: Storageable
    let userInfo: UserInfo
    
    init(storage: Storageable, userInfo: UserInfo) {
        self.storage = storage
        self.userInfo = userInfo
    }
    
    //in
    func touchBackButton() {
        popView.accept(())
    }
    //out
    let popView = PublishRelay<Void>()
}
