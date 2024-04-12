//
//  GameEventDTO.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import Foundation

struct GameEventDTO: Decodable {
    let title: String?
    let thumbnail: String?
    let link: String?
    let startDate: String?
    let endDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case thumbnail = "Thumbnail"
        case link = "Link"
        case startDate = "StartDate"
        case endDate = "EndDate"
    }
    
    var toEntity: GameEventEntity {
        return GameEventEntity(title: self.title ?? "",
                               imageUrl: self.thumbnail ?? "",
                               eventUrl: self.link ?? "",
                               endDate: "~ " + (self.endDate ?? "").convetDateType)
    }
}
