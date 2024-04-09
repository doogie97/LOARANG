//
//  RecentUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import RealmSwift

struct RecentUser {
    let name: String
    let image: UIImage
    let `class`: String
    
    var convertedInfo: RecentUserDTO {
        let recentUser = RecentUserDTO()
        recentUser.name = self.name
        recentUser.imageData = self.image.pngData() ?? Data()
        recentUser.class = self.`class`
        
        return recentUser
    }
}

final class RecentUserDTO: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var imageData: Data
    @Persisted var `class`: String
    
    var convertedInfo: RecentUser {
        return RecentUser(name: self.name,
                          image: UIImage(data: imageData) ?? UIImage(),
                          class: self.`class`)
    }
}
