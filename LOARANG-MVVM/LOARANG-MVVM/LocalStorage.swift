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
        
        return MainUser(image: UIImage(data: mainUserDTO.imageData) ?? UIImage(),
                        battleLV: mainUserDTO.battleLV,
                        name: mainUserDTO.name,
                        class: mainUserDTO.`class`,
                        itemLV: mainUserDTO.itemLV,
                        server: mainUserDTO.server)
    }
    
    func bookmarkUsers() -> [BookmarkUser] {
        guard let bookmarkList = realm.objects(LocalStorageModel.self).first?.bookmarkUsers else {
            return []
        }
        
        let bookmarkUsers: [BookmarkUser] = bookmarkList.map {
            return BookmarkUser(name: $0.name,
                                image: UIImage(data: $0.imageData) ?? UIImage(),
                                class: $0.`class`)
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
    
    func deleteUser(_ name: String) {
        
    }
    
    func changeMainUser(_ user: MainUser) {
        
    }
    
    func isBookmarkUser(_ name: String) -> Bool {
        return true
    }
}
