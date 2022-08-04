//
//  LocalStorage.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import RealmSwift

final class LocalStorage {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func mainUser() -> MainUser? {
        guard let mainUserDTO = realm.objects(LocalStorageModel.self).first?.mainUser else {
            return nil
        }
        
        return mainUserDTO.convertedInfo
    }
    
    func bookmarkUsers() -> [BookmarkUser] {
        guard let bookmarkList = realm.objects(LocalStorageModel.self).first?.bookmarkUsers else {
            return []
        }
        
        let bookmarkUsers: [BookmarkUser] = bookmarkList.map {
            return $0.convertedInfo
        }
        
        return bookmarkUsers
    }
    
    func addUser(_ user: BookmarkUser) throws {
        do {
            if realm.objects(LocalStorageModel.self).isEmpty {
                let localStorageModel = LocalStorageModel()
                localStorageModel.bookmarkUsers.append(user.convertedInfo)
                
                try realm.write {
                    realm.add(localStorageModel)
                }
            } else {
                try realm.write {
                    guard let localStorageModel = realm.objects(LocalStorageModel.self).first else {
                        throw LocalStorageError.addError
                    }
                    localStorageModel.bookmarkUsers.append(user.convertedInfo)
                }
            }
        } catch {
            throw LocalStorageError.addError
        }
    }
    
    func deleteUser(_ name: String) throws {
        guard let bookmarkList = realm.objects(LocalStorageModel.self).first?.bookmarkUsers,
              let bookmarkUserDTO: BookmarkUserDTO = bookmarkList
            .filter({ $0.name == name }).first else {
                throw LocalStorageError.deleteError
            }
        do {
            try realm.write {
                realm.delete(bookmarkUserDTO)
            }
        } catch {
            throw LocalStorageError.deleteError
        }
    }
    
    func changeMainUser(_ user: MainUser) {
        
    }
}
