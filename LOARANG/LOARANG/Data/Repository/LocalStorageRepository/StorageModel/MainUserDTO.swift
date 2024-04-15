//
//  MainUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import UIKit
import RealmSwift

final class MainUserDTO: Object {
    @Persisted var imageData: Data
    @Persisted var imageUrl: String
    @Persisted var battleLV: Int
    @Persisted var name: String
    @Persisted var `class`: String
    @Persisted var itemLV: String
    @Persisted var expeditionLV: String
    @Persisted var server: String
    @Persisted(primaryKey: true) var type = "main"
    
    var toEntity: MainUserEntity {
        return MainUserEntity(imageUrl: self.imageUrl, 
                              image: UIImage(data: self.imageData) ?? UIImage(),
                              battleLV: self.battleLV,
                              name: self.name,
                              class: self.`class`,
                              itemLV: self.itemLV, 
                              expeditionLV: self.expeditionLV,
                              server: self.server)
    }
}
