//
//  CharacterDetailGET.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import Foundation
import Alamofire

struct CharacterDetailGET: Requestable {
    private let name: String
    private let apiKey: String?
    init(name: String,
         apiKey: String? = Bundle.main.lostarkApiKeyArray.randomElement()) {
        self.name = name.changeToPercent()
        self.apiKey = apiKey
    }
    
    let baseURL = Host.lostarkAPI.baseURL
    var path: String {
        "/armories/characters/\(name)"
    }
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
