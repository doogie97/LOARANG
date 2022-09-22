//
//  MainUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import UIKit

struct MainUser {
    let image: UIImage
    let battleLV: String
    let name: String
    let `class`: String
    let itemLV: String
    let server: String
    
    var convertedInfo: MainUserDTO {
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
