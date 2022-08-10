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
        let bookmarkList = realm.objects(BookmarkUserDTO.self)
        
        let bookmarkUsers: [BookmarkUser] = bookmarkList.map {
            return $0.convertedInfo
        }
        
        return bookmarkUsers
    }
    
    func addUser(_ user: BookmarkUser) throws {
        do {
            try realm.write {
                realm.add(user.convertedInfo)
            }
        } catch {
            throw LocalStorageError.addError
        }
    }
    
    func updateUser(_ user: BookmarkUser) throws {
        do {
            try realm.write {
                realm.add(user.convertedInfo, update: .modified)
            }
        } catch {
            throw LocalStorageError.updateError
        }
    }
    
    func deleteUser(_ name: String) throws {
        let bookmarkList = realm.objects(BookmarkUserDTO.self)
        
        guard let bookmarkUserDTO = bookmarkList.filter({ $0.name == name }).first else {
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
