//
//  BookmarkUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit
import RealmSwift

final class BookmarkUserDTO: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var imageUrl: String
    @Persisted var characterClass: String
    
    var toEntity: BookmarkUserEntity {
        return BookmarkUserEntity(name: self.name, 
                                  imageUrl: self.imageUrl,
                                  characterClass: CharacterClass(rawValue: self.characterClass) ?? .unknown)
    }
}
