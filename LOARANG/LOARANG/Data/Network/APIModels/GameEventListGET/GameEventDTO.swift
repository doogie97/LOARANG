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
    let rewardDate: String?
}

extension GameEventDTO {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case thumbnail = "Thumbnail"
        case link = "Link"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case rewardDate = "RewardDate"
    }
}
