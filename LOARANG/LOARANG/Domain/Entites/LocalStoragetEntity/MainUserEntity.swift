//
//  MainUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct MainUserEntity {
    let imageUrl: String
    let image: UIImage
    let battleLV: Int
    let name: String
    let `class`: String
    let itemLV: String
    let expeditionLV: String
    let server: String
    
    var toDTO: MainUserDTO {
        let mainUser = MainUserDTO()
        mainUser.imageUrl = self.imageUrl
        mainUser.imageData = self.image.pngData() ?? Data()
        mainUser.battleLV = self.battleLV
        mainUser.name = self.name
        mainUser.class = self.`class`
        mainUser.itemLV = self.itemLV
        mainUser.expeditionLV = self.expeditionLV
        mainUser.server = self.server
        
        return mainUser
    }
}
