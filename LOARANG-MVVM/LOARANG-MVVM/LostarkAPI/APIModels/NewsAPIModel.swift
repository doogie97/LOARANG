//
//  NewsAPIModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Alamofire

struct NewsAPIModel: Requestable {
    var baseURL = Host.lostarkAPI.baseURL
    var path = "/news/events"
    var header: [String : String] = [:]
    var params: [String : Any] = [:]
    var httpMethod = HTTPMethod.get
}

struct News: Decodable {
    struct contents: Decodable {
        let title: String?
        let thumbnail: String?
        let link: String?
        let startDate: String?
        let endDate: String?
        let rewardDate: String?
        
        enum codingKeys: String, CodingKey {
            case title = "Title"
            case thumbnail = "Thumbnail"
            case link = "Link"
            case startDate = "StartDate"
            case endDate = "EndDate"
            case rewardDate = "RewardDate"
        }
    }
}
