//
//  GameNoticeListGET.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import Foundation
import Alamofire

struct GameNoticeListGET: Requestable {
    private let apiKey: String?
    init(apiKey: String? = Bundle.main.lostarkApiKeyArray.randomElement()) {
        self.apiKey = apiKey
    }
    
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/news/notices"
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
