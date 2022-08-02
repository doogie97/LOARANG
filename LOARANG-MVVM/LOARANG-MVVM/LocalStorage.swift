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
}
