//
//  CharacterDetailEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import UIKit

struct CharacterDetailEntity { //일단 지금 당장 필요한 정보만 전달, 추후 추가할 예정
    let profile: Profile
    let skillInfo: SkillInfo
    let battleEquipments: [Equipment]
    let jewelrys: [Equipment]
    let etcEquipments: [Equipment]
}

//MARK: - Profile
extension CharacterDetailEntity {
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

//MARK: - Equipment
extension CharacterDetailEntity {
    struct Equipment {
        let equipmentType: EquipmentType
        let name: String
        let imageUrl: String
        let grade: Grade
        //여기부터 tooltip info
        let qualityValue: Int
        let itemLevel: String
        let itemTypeTitle: String
        let setOptionName: String
        let setOptionLevelStr: String
        let elixirs: [Elixir]?
        let transcendence: Transcendence?
        let highReforgingLevel: Int?
        let engraving: [(name: String, value: Int)]
    }
    
    struct Elixir {
        let name: String
        let level: String
        let effect: String
    }
    
    struct Transcendence {
        let grade: Int
        let count: Int
    }
}
