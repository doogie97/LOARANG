//
//  MockStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

protocol Storageable {
    var mainUser: String { get }
    var bookMark: BehaviorRelay<[String]> { get }
    func addUser(_ user: String)
    func deleteUser(_ user: String)
    func changeMainUser(_ user: String)
}

final class MockStorage: Storageable {
    lazy var mainUser = "최지근"
    lazy var bookMark = BehaviorRelay<[String]>(value: ["최지근", "권두기", "JJODAENG"])
    
    func addUser(_ user: String) {
        bookMark.accept(bookMark.value + [user])
    }
    
    func deleteUser(_ user: String) {
        bookMark.accept(bookMark.value.filter { user != $0 })
    }
    
    func changeMainUser(_ user: String) {
        mainUser = user
    }    
}
