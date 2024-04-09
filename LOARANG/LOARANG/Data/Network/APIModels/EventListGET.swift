//
//  EventListGET.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

struct EventListGET: Requestable {
    private let apiKey: String?
    init(apiKey: String? = Bundle.main.lostarkApiKeyArray.randomElement()) {
        self.apiKey = apiKey
    }
    
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/news/events"
    var header: [String : String] {
        guard let apiKey = apiKey else {
            return [:]
        }
        return ["authorization" : "Bearer \(apiKey)"]
    }
    let params: [String : Any] = [:]
    let httpMethod = HTTPMethod.get
    let encodingType = EncodingType.urlEncoding
}

struct EventDTO: Decodable {
    let title: String?
    let thumbnail: String?
    let link: String?
    let startDate: String?
    let endDate: String?
    let rewardDate: String?
}

extension EventDTO {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case thumbnail = "Thumbnail"
        case link = "Link"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case rewardDate = "RewardDate"
    }
}
