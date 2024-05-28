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
    
    static var forPreview: LocalStorageRepository {
        let realm = try! Realm()
        let repository = LocalStorageRepository(realm: realm)
        let testUser = RecentUserDTO()
        testUser.name = "테스트유저"
        testUser.characterClass = "블레이드"
        testUser.imageUrl = "https://img.lostark.co.kr/armory/7/c099600e3be48afc300f44101a83e9a093202f6720a3a4025db35cf09fa18afe.png?v=20240324044337"
        try! repository.addRecentUser(testUser)
        let testUser2 = RecentUserDTO()
        testUser2.name = "테스트유저2"
        testUser2.characterClass = "도화가"
        testUser2.imageUrl = "https://img.lostark.co.kr/armory/5/972ed959a6ffef17575734cf933824800fd22debd0b82777ceccd567e927bd3a.png?v=20240517173702"
        try! repository.addRecentUser(testUser2)
        return repository
    }
}
