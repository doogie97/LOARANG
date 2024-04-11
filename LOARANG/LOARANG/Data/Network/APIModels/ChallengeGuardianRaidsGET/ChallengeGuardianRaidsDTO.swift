//
//  ChallengeGuardianRaidsDTO.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

struct ChallengeGuardianRaidsDTO: Decodable {
    let raids: [Raid]?
    
    enum CodingKeys: String, CodingKey {
        case raids = "Raid"
    }
    
    struct Raid: Decodable {
        let name: String?
        let imageUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case imageUrl = "Image"
        }
        
        var toEntity: ChallengeGuardianRaidEntity {
            return ChallengeGuardianRaidEntity(name: self.name ?? "", imageUrl: self.imageUrl ?? "")
        }
    }
}
