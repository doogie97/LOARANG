//
//  MainUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import UIKit
import RealmSwift

final class MainUserDTO: Object {
    @Persisted var imageUrl: String
    @Persisted var battleLV: Int
    @Persisted var name: String
    @Persisted var characterClass: String
    @Persisted var itemLV: String
    @Persisted var expeditionLV: Int
    @Persisted var gameServer: String
    @Persisted(primaryKey: true) var type = "main"
    
    var toEntity: MainUserEntity {
        return MainUserEntity(imageUrl: self.imageUrl, 
                              battleLV: self.battleLV,
                              name: self.name,
                              characterClass: CharacterClass(rawValue: self.characterClass) ?? .unknown,
                              itemLV: self.itemLV,
                              expeditionLV: self.expeditionLV,
                              gameServer: GameServer(rawValue: self.gameServer) ?? .unknown)
    }
}
