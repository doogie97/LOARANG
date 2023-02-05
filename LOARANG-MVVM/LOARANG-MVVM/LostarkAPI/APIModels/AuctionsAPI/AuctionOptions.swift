//
//  AuctionOptions.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/02/05.
//

struct AuctionOptions: Decodable {
    let maxItemLevel: Int?
    let itemGradeQualities : [Int]?
    let skillOptions: [SkillOption]?
    let etcOptions: [EtcOption]?
    let itemGrades: [String]?
    let itemTiers: [Int]?
    let classes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case maxItemLevel = "MaxItemLevel"
        case itemGradeQualities = "ItemGradeQualities"
        case skillOptions = "SkillOptions"
        case etcOptions = "EtcOptions"
        case itemGrades = "ItemGrades"
        case itemTiers = "ItemTiers"
        case classes = "Classes"
    }
}

//MARK: - SkillOption
extension AuctionOptions {
    struct SkillOption: Decodable {
        let value: Int?
        let `class`: String?
        let skillName: String?
        let isSkillGroup: Bool? //아덴 스킬인지 여부인 것 같음 ex 버스트, 악마화 등등
        let tripods: [Tripod]?
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case `class` = "Class"
            case skillName = "Text"
            case isSkillGroup = "IsSkillGroup"
            case tripods = "Tripods"
        }
    }
    
    struct Tripod: Decodable {
        let value: Int?
        let tripodName: String?
        let isGem: Bool?
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case tripodName = "Text"
            case isGem = "IsGem"
        }
    }
}

//MARK: - EtcOptions
extension AuctionOptions {
    struct EtcOption: Decodable {
        let value: Int?
        let type: String?
        let etcSubs: [EtcSub]?
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case type = "Text"
            case etcSubs = "EtcSubs"
        }
    }
    
    struct EtcSub: Decodable {
        let value: Int?
        let type: String?
        let `class`: String?
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case type = "Text"
            case `class` = "Class"
        }
    }
}

//MARK: - Categories
extension AuctionOptions {
    struct Category: Decodable {
        let subs: [Sub]?
        let code: Int?
        let codeName: String?
        
        enum CodingKeys: String, CodingKey {
            case subs = "Subs"
            case code = "Code"
            case codeName = "CodeName"
        }
    }
    
    struct Sub: Decodable {
        let code: Int?
        let codeName: String?
        
        enum CodingKeys: String, CodingKey {
            case code = "Code"
            case codeName = "CodeName"
        }
    }
}
