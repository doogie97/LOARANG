//
//  MainUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct MainUserEntity {
    let imageUrl: String
    let battleLV: Int
    let name: String
    let characterClass: CharacterClass
    let itemLV: String
    let expeditionLV: Int
    let gameServer: GameServer
    
    var toDTO: MainUserDTO {
        let mainUser = MainUserDTO()
        mainUser.imageUrl = self.imageUrl
        mainUser.battleLV = self.battleLV
        mainUser.name = self.name
        mainUser.characterClass = self.characterClass.rawValue
        mainUser.itemLV = self.itemLV
        mainUser.expeditionLV = self.expeditionLV
        mainUser.gameServer = self.gameServer.rawValue
        
        return mainUser
    }
}
