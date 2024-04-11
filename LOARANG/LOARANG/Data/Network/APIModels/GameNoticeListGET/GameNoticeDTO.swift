//
//  GameNoticeDTO.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

struct GameNoticeDTO: Decodable {
    let title: String?
    let link: String?
    let type: String?
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case link = "Link"
        case type = "Type"
    }
    
    var toEntity: GameNoticeEntity {
        return GameNoticeEntity(title: self.title ?? "",
                                url: self.link ?? "",
                                type: GameNoticeEntity.NoticeType(rawValue: self.type ?? "") ?? .unknown)
    }
}
