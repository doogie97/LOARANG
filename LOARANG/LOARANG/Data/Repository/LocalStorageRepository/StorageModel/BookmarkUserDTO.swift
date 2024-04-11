//
//  BookmarkUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import RealmSwift

final class BookmarkUserDTO: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var imageData: Data
    @Persisted var `class`: String
    
    var toEntity: BookmarkUserEntity {
        return BookmarkUserEntity(name: self.name,
                                  image: UIImage(data: imageData) ?? UIImage(),
                                  class: self.`class`)
    }
}
