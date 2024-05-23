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
            name: "테스트",
            imageUrl: "https://akaikaze00.cafe24.com/web/product/big/202208/3a16878b23ad06a987ff7e5c85106598.jpg",
            characterClass: .blade,
            isBookmark: true)
    }
}
