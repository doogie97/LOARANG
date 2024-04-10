//
//  AppStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//
import RxRelay

protocol AppStorageable {
    func addRecentUser(_ user: RecentUserEntity) throws
    func deleteRecentUser(_ name: String) throws
    func clearRecentUsers() throws
}

final class AppStorage: AppStorageable {
    private let localStorage: LocalStorage
    
    init(_ localStorage: LocalStorage) {
        self.localStorage = localStorage
    }
    
    func addRecentUser(_ user: RecentUserEntity) throws {
        do {
            try localStorage.addRecentUser(user)
            ViewChangeManager.shared.recentUsers.accept(localStorage.recentUsers())
        } catch {
            throw error
        }
    }
    
    func deleteRecentUser(_ name: String) throws {
        do {
            try localStorage.deleteRecentUser(name)
            ViewChangeManager.shared.recentUsers.accept(localStorage.recentUsers())
        } catch {
            throw error
        }
    }
    
    func clearRecentUsers() throws {
        do {
            try localStorage.clearRecentUsers()
            ViewChangeManager.shared.recentUsers.accept([])
        } catch {
            throw error
        }
    }
}
