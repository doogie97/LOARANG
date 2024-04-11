//
//  RecentUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct RecentUserEntity {
    let name: String
    let image: UIImage
    let `class`: String
    
    var toDTO: RecentUserDTO {
        let recentUser = RecentUserDTO()
        recentUser.name = self.name
        recentUser.imageData = self.image.pngData() ?? Data()
        recentUser.class = self.`class`
        
        return recentUser
    }
}
