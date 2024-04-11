//
//  GameEventDTO.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

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
                               thumbnailImgUrl: self.thumbnail ?? "",
                               url: self.link ?? "",
                               startDate: self.startDate ?? "",
                               endDate: self.endDate ?? "")
    }
}

extension GameEventDTO {

}
