//
//  NewsAPIModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

struct NewsAPIModel: Requestable {
    var baseURL = Host.lostarkAPI.baseURL
    var path = "/news/events"
    var header: [String : String] = [
        "accept" : "application/json",
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    var params: [String : Any] = [:]
    var httpMethod = HTTPMethod.get
}

struct News: Decodable {
    let title: String?
    let thumbnail: String?
    let link: String?
    let startDate: String?
    let endDate: String?
    let rewardDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case thumbnail = "Thumbnail"
        case link = "Link"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case rewardDate = "RewardDate"
    }
}
