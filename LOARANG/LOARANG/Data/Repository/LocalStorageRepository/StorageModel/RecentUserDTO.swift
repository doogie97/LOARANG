//
//  RecentUserDTO.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import RealmSwift

final class RecentUserDTO: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var imageData: Data
    @Persisted var `class`: String
    
    var convertedInfo: RecentUserEntity {
        return RecentUserEntity(name: self.name,
                                image: UIImage(data: imageData) ?? UIImage(),
                                class: self.`class`)
    }
}
