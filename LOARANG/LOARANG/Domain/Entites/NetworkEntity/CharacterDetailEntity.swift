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
    let elixirInfo: ElixirInfo?
    let transcendenceInfo: TranscendenceInfo?
    let engravigs: [Engravig]
    let cardInfo: CardInfo
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
        let title: String
        let pvpGradeName: String
        let townName: String
        let guildName: String
        let stats: [Stat]
        let tendencies: [Tendency]
    }
    
    struct Stat {
        let statType: StatType
        let value: Int
    }
    
    struct Tendency {
        let tendencyType: TendencyType
        let value: Int
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
        let itemLevel: Int
        let itemTypeTitle: String
        let basicEffect: [String]
        let additionalEffect: [String]
        let setOptionName: String
        let setOptionLevelStr: String
        let elixirs: [Elixir]?
        let specialElixirEffect: SpecialElixirEffectInfo?
        let transcendence: Transcendence?
        let highReforgingLevel: Int?
        let engraving: [(name: String, value: Int)]
    }
    
    struct Elixir {
        let name: String
        let level: Int
        let effects: [(effect: String, value: String)]
    }
    
    struct SpecialElixirEffectInfo {
        let name: String
        let grade: Int
        let effects: [SpecialElixirEffect]
    }
    
    struct SpecialElixirEffect {
        let title: String
        let activeLevel: Int
        let effect: String
    }
    
    struct Transcendence {
        let grade: Int
        let count: Int
    }
    
    struct ElixirInfo {
        let totlaLevel: Int
        let activeSpecialEffect: SpecialElixirEffectInfo?
    }
    
    struct TranscendenceInfo {
        let averageGrade: Double
        let totalCount: Int
    }
}

//MARK: - Engravig
extension CharacterDetailEntity {
    struct Engravig {
        let imageUrl: String
        let name: String
        let level: Int
        let description: String
    }
}

//MARK: - Card
extension CharacterDetailEntity {
    struct CardInfo {
        let cards: [Card]
        let effects: [CardEffect]
    }
    
    struct Card {
        let name: String
        let imageUrl: String
        let awakeCount: Int
        let awakeTotal: Int
        let grade: Grade
    }
    
    struct CardEffect {
        let name: String?
        let description: String?
    }
}
