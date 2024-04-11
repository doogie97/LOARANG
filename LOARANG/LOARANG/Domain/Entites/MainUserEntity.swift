//
//  MainUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct MainUserEntity {
    let image: UIImage
    let battleLV: String
    let name: String
    let `class`: String
    let itemLV: String
    let server: String
    
    var toDTO: MainUserDTO {
        let mainUser = MainUserDTO()
        mainUser.imageData = self.image.pngData() ?? Data()
        mainUser.battleLV = self.battleLV
        mainUser.name = self.name
        mainUser.class = self.`class`
        mainUser.itemLV = self.itemLV
        mainUser.server = self.server
        
        return mainUser
    }
}
