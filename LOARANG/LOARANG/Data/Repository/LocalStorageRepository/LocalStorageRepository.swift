//
//  LocalStorageRepository.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import RealmSwift

protocol LocalStorageRepositoryable {
    func mainUser() -> MainUserDTO?
    func bookmarkUsers() -> [BookmarkUserDTO]
    func changeMainUser(_ user: MainUserDTO) throws
    func deleteMainUser() throws
    func addBookmarkUser(_ user: BookmarkUserDTO) throws
    func deleteBookmarkUser(_ name: String) throws
    func updateBookmarkUser(_ user: BookmarkUserDTO) throws
    func recentUsers() -> [RecentUserDTO]
    func addRecentUser(_ user: RecentUserDTO) throws
    func deleteRecentUser(_ name: String) throws
    func clearRecentUsers() throws
}

final class LocalStorageRepository: LocalStorageRepositoryable {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func mainUser() -> MainUserDTO? {
        guard let mainUserDTO = realm.objects(MainUserDTO.self).first else {
            return nil
        }
        
        return mainUserDTO
    }
    
    func deleteMainUser() throws {
        guard let mainUserDTO = realm.objects(MainUserDTO.self).first else {
            throw LocalStorageError.noMainUser
        }
        
        do {
            try realm.write {
                realm.delete(mainUserDTO)
            }
        } catch let error {
            throw error
        }
    }
    
    func bookmarkUsers() -> [BookmarkUserDTO] {
        let bookmarkList = realm.objects(BookmarkUserDTO.self)
        
        return Array(bookmarkList)
    }
    
    func addBookmarkUser(_ user: BookmarkUserDTO) throws {
        let bookmarkUsers = realm.objects(BookmarkUserDTO.self)
        
        guard bookmarkUsers.count < 20 else {
            throw LocalStorageError.overBookmakr
        }
        
        do {
            try realm.write {
                realm.add(user)
            }
        } catch {
            throw LocalStorageError.addBookmarkError
        }
    }
    
    func updateBookmarkUser(_ user: BookmarkUserDTO) throws {
        do {
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch {
            throw LocalStorageError.updateBookmarkError
        }
    }
    
    func deleteBookmarkUser(_ name: String) throws {
        let bookmarkList = realm.objects(BookmarkUserDTO.self)
        
        guard let bookmarkUserDTO = bookmarkList.filter({ $0.name == name }).first else {
            throw LocalStorageError.deleteBookmarkError
        }
        
        do {
            try realm.write {
                realm.delete(bookmarkUserDTO)
            }
        } catch {
            throw LocalStorageError.deleteBookmarkError
        }
    }
    
    func changeMainUser(_ user: MainUserDTO) throws {
        do {
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch {
            throw LocalStorageError.changeMainUserError
        }
    }
    
    func recentUsers() -> [RecentUserDTO] {
        let recentUserList = realm.objects(RecentUserDTO.self)
        
        return Array(recentUserList).reversed()
    }
    
    func addRecentUser(_ user: RecentUserDTO) throws {
        let recentUserList = realm.objects(RecentUserDTO.self)
        
        if recentUserList.count > 14 {
            guard let lastUser = recentUserList.first else {
                return
            }
            do {
                try realm.write {
                    realm.delete(lastUser)
                }
            }
        }
        
        do {
            try deleteRecentUser(user.name)
        } catch {}
        
        do {
            try realm.write {
                realm.add(user)
            }
        } catch {
            throw LocalStorageError.addRecentUserError
        }
    }
    
    func deleteRecentUser(_ name: String) throws {
        let recentUserList = realm.objects(RecentUserDTO.self)
        
        guard let recentUserDTO = recentUserList.filter({ $0.name == name }).first else {
            throw LocalStorageError.deleteRecentUserError
        }
        
        do {
            try realm.write {
                realm.delete(recentUserDTO)
            }
        } catch {
            throw LocalStorageError.deleteRecentUserError
        }
    }
    
    func clearRecentUsers() throws {
        let recentUserList = realm.objects(RecentUserDTO.self)
        
        do {
            try realm.write {
                realm.delete(recentUserList)
            }
        } catch {
            throw LocalStorageError.deleteRecentUserError
        }
    }
}
