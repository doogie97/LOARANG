//
//  CharactersDetailDTO.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

struct CharactersDetailDTO: Decodable {
    let ArmoryProfile: ArmoryProfile?
    let ArmoryEquipment: [Equipment]?
    let ArmoryAvatars: [Avatar]?
    let ArmoryEngraving: ArmoryEngraving?
    let ArmoryGem: ArmoryGem?
    let ArmoryCard: ArmoryCard?
}

//MARK: - ArmoryProfile
extension CharactersDetailDTO {
    struct ArmoryProfile: Decodable {
        let CharacterImage: String?
        let ExpeditionLevel: Int?
        let PvpGradeName: String?
        let TownLevel: Int?
        let TownName: String?
        let Title: String?
        let GuildMemberGrade: String?
        let GuildName: String?
        let UsingSkillPoint: Int?
        let TotalSkillPoint: Int?
        let Stats: [Stats]?
        let Tendencies: [Tendencies]?
        let ServerName: String?
        let CharacterName: String?
        let CharacterLevel: Int?
        let CharacterClassName: String?
        let ItemMaxLevel: String?
    }
    
    struct Stats: Decodable {
        let statType: String?
        let Value: String?
        let Tooltip: [String]?
        enum CodingKeys: String, CodingKey {
            case statType = "Type"
            case Value
            case Tooltip
        }
    }
    
    struct Tendencies: Decodable {
        let tendencyType: String?
        let Point: Int?
        let MaxPoint: Int?
        enum CodingKeys: String, CodingKey {
            case tendencyType = "Type"
            case Point
            case MaxPoint
        }
    }
}

//MARK: - Equipment
extension CharactersDetailDTO {
    struct Equipment: Decodable {
        let equipmentType: String?
        let Name: String?
        let Icon: String?
        let Grade: String?
        let Tooltip: String?
        enum CodingKeys: String, CodingKey {
            case equipmentType = "Type"
            case Name
            case Icon
            case Grade
            case Tooltip
        }
    }
}

//MARK: - Avatar
extension CharactersDetailDTO {
    struct Avatar: Decodable {
        let avatarType: String?
        let Name: String?
        let Icon: String?
        let Grade: String?
        let Tooltip: String?
        enum CodingKeys: String, CodingKey {
            case avatarType = "Type"
            case Name
            case Icon
            case Grade
            case Tooltip
        }
    }
}

//MARK: - Engraving
extension CharactersDetailDTO {
    struct ArmoryEngraving: Decodable {
        let Effects: [Engravig]?
    }
    
    struct Engravig: Decodable {
        let Icon: String?
        ///이름 + 레벨
        let Name: String?
        let Description: String?
    }
}

//MARK: - Gems
extension CharactersDetailDTO {
    struct ArmoryGem: Decodable {
        let Gems: [Gem]?
        
    }
    
    struct Gem: Decodable {
        let Name: String?
        let Icon: String?
        let Level: Int?
        let Grade: String?
        let Tooltip: String?
    }
}
//MARK: - Cards
extension CharactersDetailDTO {
    struct ArmoryCard: Decodable {
        let Cards: [Card]?
        let Effects: [CardEffect]?
    }
    
    struct Card: Decodable {
        let Name: String?
        let Icon: String?
        let AwakeCount: Int?
        let AwakeTotal: Int?
        let Grade: String?
    }
    
    struct CardEffect: Decodable {
        let Items: [CardEffectItem]?
    }
    
    struct CardEffectItem: Decodable {
        let Name: String?
        let Description: String?
    }
}

