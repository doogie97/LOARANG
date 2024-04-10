//
//  AppStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//
import RxRelay

protocol AppStorageable {
    var recentUsers: BehaviorRelay<[RecentUser]> { get }
    func isBookmarkUser(_ name: String) -> Bool
    func addRecentUser(_ user: RecentUser) throws
    func deleteRecentUser(_ name: String) throws
    func clearRecentUsers() throws
}

final class AppStorage: AppStorageable {
    private let localStorage: LocalStorage
    
    var recentUsers: BehaviorRelay<[RecentUser]>
    
    init(_ localStorage: LocalStorage) {
        self.localStorage = localStorage
        self.recentUsers = BehaviorRelay<[RecentUser]>(value: localStorage.recentUsers())
    }
    
    func isBookmarkUser(_ name: String) -> Bool {
        let user = ViewChangeManager.shared.bookmarkUsers.value.filter { name == $0.name }
        
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
    
    func deleteRecentUser(_ name: String) throws {
        do {
            try localStorage.deleteRecentUser(name)
            self.recentUsers.accept(localStorage.recentUsers())
        } catch {
            throw error
        }
    }
    
    func clearRecentUsers() throws {
        do {
            try localStorage.clearRecentUsers()
            self.recentUsers.accept([])
        } catch {
            throw error
        }
    }
}
