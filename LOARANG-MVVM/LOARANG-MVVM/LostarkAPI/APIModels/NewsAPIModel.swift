//
//  NewsAPIModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

struct NewsAPIModel: Requestable {
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/news/events"
    let header: [String : String] = [
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    let params: [String : Any] = [:]
    let httpMethod = HTTPMethod.get
}

struct News: Decodable {
    let title: String?
    let thumbnail: String?
    let link: String?
    let startDate: String?
    let endDate: String?
    let rewardDate: String?
}

extension News {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case thumbnail = "Thumbnail"
        case link = "Link"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case rewardDate = "RewardDate"
    }
}
