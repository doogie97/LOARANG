//
//  BookmarkUserDTO.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import RealmSwift

final class MainUserDTO: Object {
    @Persisted var imageData: Data
    @Persisted var battleLV: String
    @Persisted(primaryKey: true) var name: String
    @Persisted var `class`: String
    @Persisted var itemLV: String
    @Persisted var server: String
    
    var convertedInfo: MainUser {
        return MainUser(image: UIImage(data: self.imageData) ?? UIImage(),
                        battleLV: self.battleLV,
                        name: self.name,
                        class: self.`class`,
                        itemLV: self.itemLV,
                        server: self.server)
    }
}

final class BookmarkUserDTO: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var imageData: Data
    @Persisted var `class`: String
    
    var convertedInfo: BookmarkUser {
        return BookmarkUser(name: self.name,
                            image: UIImage(data: imageData) ?? UIImage(),
                            class: self.`class`)
    }
}
