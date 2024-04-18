//
//  OwnCharactersEntity.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

struct OwnCharactersEntity {
    let serverList: [ServerInfo]
    
    struct ServerInfo {
        let gameServer: GameServer
        var characters: [Character]
    }
    
    struct Character {
        let gameServer: GameServer
        let characterName: String
        let battelLevel: Int
        let characterClass: CharacterClass
        ///주 사용 레벨
        let itemLevel: String
    }
}

