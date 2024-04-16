//
//  CharactersDetailDTO.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

struct CharactersDetailDTO: Decodable {
    let ArmoryProfile: ArmoryProfile?
    let ArmorySkills: [ArmorySkill]?
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
        let Value: Int?
        let MaxPoint: Int?
        enum CodingKeys: String, CodingKey {
            case tendencyType = "Type"
            case Value
            case MaxPoint
        }
    }
}

//MARK: - ArmorySkills
extension CharactersDetailDTO {
    struct ArmorySkill: Decodable {
        let Name: String?
        let Icon: String?
        let Level: Int?
        let Tripods: [Tripod]?
        let Rune: Rune?
        let Tooltip: String?
    }
    
    struct Tripod: Decodable {
        let Name: String?
        let Icon: String?
        let Level: Int?
        let IsSelected: Bool?
        let Tooltip: String?
    }
    
    struct Rune: Decodable {
        let Name: String?
        let Icon: String?
        let Grade: String?
        let Tooltip: String?
    }
}

