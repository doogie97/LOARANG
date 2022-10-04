//
//  RecentUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/10/04.
//

import RealmSwift

struct RecentUser {
    let name: String
    let `class`: String
    let itemLV: String
    
    var convertedInfo: RecentUserDTO {
        let recentUser = RecentUserDTO()
        recentUser.name = self.name
        recentUser.class = self.`class`
        recentUser.itemLV = self.itemLV
        
        return recentUser
    }
}

final class RecentUserDTO: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var `class`: String
    @Persisted var itemLV: String
    
    var convertedInfo: RecentUser {
        return RecentUser(name: self.name,
                          class: self.`class`,
                          itemLV: self.itemLV)
    }
}
