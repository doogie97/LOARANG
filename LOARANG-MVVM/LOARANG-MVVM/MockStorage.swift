//
//  MockStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RxRelay

protocol Storageable {
    var mainUser: String? { get }
    var bookMark: BehaviorRelay<[BookmarkUser]> { get }
    func addUser(_ user: BookmarkUser)
    func deleteUser(_ name: String)
    func changeMainUser(_ name: String)
}

final class MockStorage: Storageable {
    lazy var mainUser: String? = "최지근"
    lazy var bookMark = BehaviorRelay<[BookmarkUser]>(value: [
        BookmarkUser(name: "최지근",
                     image: UIImage(named: "최지근") ?? UIImage(),
                     class: "블레이드"),
        BookmarkUser(name: "권두기",
                     image: UIImage(named: "최두기") ?? UIImage(),
                     class: "배틀마스터"),
        BookmarkUser(name: "JJODAENG",
                     image: UIImage(named: "나는두기") ?? UIImage(),
                     class: "기상술사")
    ])
    
    func addUser(_ user: BookmarkUser) {
        bookMark.accept(bookMark.value + [user])
    }
    
    func deleteUser(_ name: String) {
        bookMark.accept(bookMark.value.filter { name != $0.name })
    }
    
    func changeMainUser(_ name: String) {
        mainUser = name
    }    
}
