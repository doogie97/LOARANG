//
//  CharacterBasicInfoEntity.swift
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
        let characterLevel: Int
        let characterClass: CharacterClass
        let itemAvgLevel: String
        ///주 사용 레벨
        let itemMaxLevel: String
    }
}

