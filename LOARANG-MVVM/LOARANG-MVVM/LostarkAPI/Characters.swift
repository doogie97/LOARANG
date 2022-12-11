//
//  Characters.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/07.
//

struct Characters: Decodable {
    let serverName: String?
    let characterName: String?
    let characterLevel: Int?
    let characterClassName: String?
    let itemAvgLevel: String?
    let itemMaxLevel: String?
    
    private enum CodingKeys: String, CodingKey {
        case serverName = "ServerName"
        case characterName = "CharacterName"
        case characterLevel = "CharacterLevel"
        case characterClassName = "CharacterClassName"
        case itemAvgLevel = "ItemAvgLevel"
        case itemMaxLevel = "ItemMaxLevel"
    }
}
