//
//  GameEventListGET.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

struct GameEventListGET: Requestable {
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
