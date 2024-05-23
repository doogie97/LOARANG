//
//  RecentUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct RecentUserEntity {
    let name: String
    let imageUrl: String
    let characterClass: CharacterClass
    let isBookmark: Bool
    
    var toDTO: RecentUserDTO {
        let recentUser = RecentUserDTO()
        recentUser.name = self.name
        recentUser.imageUrl = self.imageUrl
        recentUser.characterClass = self.characterClass.rawValue
        recentUser.isBookmark = self.isBookmark
        
        return recentUser
    }
}
