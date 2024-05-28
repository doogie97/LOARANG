//
//  RecentUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct RecentUserEntity: Hashable {
    var name: String
    var imageUrl: String
    var characterClass: CharacterClass
    var isBookmark: Bool
    
    var toDTO: RecentUserDTO {
        let recentUser = RecentUserDTO()
        recentUser.name = self.name
        recentUser.imageUrl = self.imageUrl
        recentUser.characterClass = self.characterClass.rawValue
        recentUser.isBookmark = self.isBookmark
        
        return recentUser
    }
    
    static var forPreview: RecentUserEntity {
        return RecentUserEntity(
            name: "테스ssf트",
            imageUrl: "https://img.lostark.co.kr/armory/5/972ed959a6ffef17575734cf933824800fd22debd0b82777ceccd567e927bd3a.png?v=20240517173702",
            characterClass: .aeromancer,
            isBookmark: true)
    }
}
