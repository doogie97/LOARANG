//
//  MockStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

protocol Storageable {
    var mainUser: UserInfo { get }
    var bookMark: BehaviorRelay<[UserInfo]> { get }
    func addUser(_ user: UserInfo)
    func deleteUser(_ user: UserInfo)
    func changeMainUser(_ user: UserInfo)
}

final class MockStorage: Storageable {
    lazy var mainUser = fakeUser().user
    lazy var bookMark = BehaviorRelay<[UserInfo]>(value: [])
    
    func addUser(_ user: UserInfo) {
        bookMark.accept(bookMark.value + [user])
    }
    
    func deleteUser(_ user: UserInfo) {
        bookMark.accept(bookMark.value.filter { user.basicInfo.name != $0.basicInfo.name })
    }
    
    func changeMainUser(_ user: UserInfo) {
        mainUser = user
    }
    
    
}
