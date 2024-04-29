//
//  RecentUserDTO.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import UIKit
import RealmSwift

final class RecentUserDTO: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var imageUrl: String
    @Persisted var characterClass: String
    
    var toEntity: RecentUserEntity {
        return RecentUserEntity(name: self.name,
                                imageUrl: self.imageUrl,
                                characterClass: CharacterClass(rawValue: self.characterClass) ?? .unknown)
    }
}
