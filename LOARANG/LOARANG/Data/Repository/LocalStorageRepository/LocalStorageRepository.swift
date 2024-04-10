//
//  LocalStorageRepository.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import RealmSwift

protocol LocalStorageRepositoryable {
    func mainUser() -> MainUserEntity?
    func bookmarkUsers() -> [BookmarkUserEntity]
    func changeMainUser(_ user: MainUserEntity) throws
    func addBookmarkUser(_ user: BookmarkUserEntity) throws
    func deleteBookmarkUser(_ name: String) throws
    func updateBookmarkUser(_ user: BookmarkUserEntity) throws
    func recentUsers() -> [RecentUserEntity]
    func addRecentUser(_ user: RecentUserEntity) throws
    func deleteRecentUser(_ name: String) throws
    func clearRecentUsers() throws
}

final class LocalStorageRepository: LocalStorageRepositoryable {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func mainUser() -> MainUserEntity? {
        guard let mainUserDTO = realm.objects(MainUserDTO.self).first else {
            return nil
        }
        
        return mainUserDTO.convertedInfo
    }
    
    func bookmarkUsers() -> [BookmarkUserEntity] {
        let bookmarkList = realm.objects(BookmarkUserDTO.self)
        
        let bookmarkUsers: [BookmarkUserEntity] = bookmarkList.map {
            return $0.convertedInfo
        }
        
        return bookmarkUsers
    }
    
    func addBookmarkUser(_ user: BookmarkUserEntity) throws {
        let bookmarkUsers = realm.objects(BookmarkUserDTO.self)
        
        guard bookmarkUsers.count < 20 else {
            throw LocalStorageError.overBookmakr
        }
        
        do {
            try realm.write {
                realm.add(user.convertedInfo)
            }
        } catch {
            throw LocalStorageError.addBookmarkError
        }
    }
    
    func updateBookmarkUser(_ user: BookmarkUserEntity) throws {
        do {
            try realm.write {
                realm.add(user.convertedInfo, update: .modified)
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
    
    func changeMainUser(_ user: MainUserEntity) throws {                
        do {
            try realm.write {
                realm.add(user.convertedInfo, update: .modified)
            }
        } catch {
            throw LocalStorageError.changeMainUserError
        }
    }
    
    func recentUsers() -> [RecentUserEntity] {
        let recentUserList = realm.objects(RecentUserDTO.self)
        
        let recentUsers: [RecentUserEntity] = recentUserList.map {
            return $0.convertedInfo
        }
        
        return recentUsers.reversed()
    }
    
    func addRecentUser(_ user: RecentUserEntity) throws {
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
                realm.add(user.convertedInfo)
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
