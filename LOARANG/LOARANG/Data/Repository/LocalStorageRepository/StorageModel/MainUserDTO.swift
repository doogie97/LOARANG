//
//  MainUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import RealmSwift

final class MainUserDTO: Object {
    @Persisted var imageData: Data
    @Persisted var battleLV: String
    @Persisted var name: String
    @Persisted var `class`: String
    @Persisted var itemLV: String
    @Persisted var server: String
    @Persisted(primaryKey: true) var type = "main"
    
    var convertedInfo: MainUserEntity {
        return MainUserEntity(image: UIImage(data: self.imageData) ?? UIImage(),
                              battleLV: self.battleLV,
                              name: self.name,
                              class: self.`class`,
                              itemLV: self.itemLV,
                              server: self.server)
    }
}
