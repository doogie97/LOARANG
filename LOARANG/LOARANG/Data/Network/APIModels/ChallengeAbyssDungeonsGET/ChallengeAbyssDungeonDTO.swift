//
//  ChallengeAbyssDungeonDTO.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

struct ChallengeAbyssDungeonDTO: Decodable {
    let name: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case imageUrl = "Image"
    }
    
    var toEntity: ChallengeAbyssDungeonEntity {
        return ChallengeAbyssDungeonEntity(name: self.name ?? "",
                                           imageUrl: self.imageUrl ?? "")
    }
}
