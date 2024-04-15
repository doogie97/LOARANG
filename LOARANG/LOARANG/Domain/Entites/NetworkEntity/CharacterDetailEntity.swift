//
//  CharacterDetailEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

struct CharacterDetailEntity { //일단 지금 당장 필요한 정보만 전달, 추후 추가할 예정
    let profile: Profile
    
    struct Profile {
        let gameServer: GameServer
        let battleLevel: Int
        let itemLevel: String
        let expeditionLevel: Int
        let characterName: String
        let characterClass: CharacterClass
        let imageUrl: String
    }
}
