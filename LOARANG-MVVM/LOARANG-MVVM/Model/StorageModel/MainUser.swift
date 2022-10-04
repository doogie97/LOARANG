//
//  MainUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/02.
//

import RealmSwift

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

final class MainUserDTO: Object {
    @Persisted var imageData: Data
    @Persisted var battleLV: String
    @Persisted var name: String
    @Persisted var `class`: String
    @Persisted var itemLV: String
    @Persisted var server: String
    @Persisted(primaryKey: true) var type = "main"
    
    var convertedInfo: MainUser {
        return MainUser(image: UIImage(data: self.imageData) ?? UIImage(),
                        battleLV: self.battleLV,
                        name: self.name,
                        class: self.`class`,
                        itemLV: self.itemLV,
                        server: self.server)
    }
}
