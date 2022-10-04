//
//  AppStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//
import RxRelay

protocol AppStorageable {
    var mainUser: BehaviorRelay<MainUser?> { get }
    var bookMark: BehaviorRelay<[BookmarkUser]> { get }
    var recentUsers: BehaviorRelay<[RecentUser]> { get }
    func addUser(_ user: BookmarkUser) throws
    func deleteUser(_ name: String) throws
    func updateUser(_ user: BookmarkUser) throws
    func changeMainUser(_ user: MainUser) throws
    func isBookmarkUser(_ name: String) -> Bool
    func addRecentUser(_ user: RecentUser) throws
}

final class AppStorage: AppStorageable {
    private let localStorage: LocalStorage
    
    var mainUser: BehaviorRelay<MainUser?>
    var bookMark: BehaviorRelay<[BookmarkUser]>
    var recentUsers: BehaviorRelay<[RecentUser]>
    
    init(_ localStorage: LocalStorage) {
        self.localStorage = localStorage
        self.bookMark = BehaviorRelay<[BookmarkUser]>(value: localStorage.bookmarkUsers())
        self.mainUser = BehaviorRelay<MainUser?>(value: localStorage.mainUser())
        self.recentUsers = BehaviorRelay<[RecentUser]>(value: localStorage.recentUsers())
    }
    
    func addUser(_ user: BookmarkUser) throws {
        do {
            try localStorage.addUser(user)
            self.bookMark.accept(localStorage.bookmarkUsers())
        } catch {
            throw error
        }
    }
    
    func deleteUser(_ name: String) throws {
        do {
            try localStorage.deleteUser(name)
            self.bookMark.accept(localStorage.bookmarkUsers())
        } catch {
            throw error
        }
    }
    
    func updateUser(_ user: BookmarkUser) throws {
        do {
            try localStorage.updateUser(user)
            self.bookMark.accept(localStorage.bookmarkUsers())
        } catch {
            throw error
        }
    }
    
    func changeMainUser(_ user: MainUser) throws {
        do {
            try localStorage.changeMainUser(user)
            mainUser.accept(user)
        } catch {
            throw LocalStorageError.changeMainUserError
        }
    }
    
    func isBookmarkUser(_ name: String) -> Bool {
        let user = bookMark.value.filter { name == $0.name }
        
        if user.isEmpty {
            return false
        }
        
        return true
    }
    
    func addRecentUser(_ user: RecentUser) throws {
        do {
            try localStorage.addRecentUser(user)
            self.recentUsers.accept(localStorage.recentUsers())
        } catch {
            throw error
        }
    }
    
}
