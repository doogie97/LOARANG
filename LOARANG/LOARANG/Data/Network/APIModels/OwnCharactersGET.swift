//
//  OwnCharactersGET.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

struct OwnCharactersGET: Requestable {
    private let name: String
    private let apiKey: String?
    init(name: String,
         apiKey: String? = Bundle.main.lostarkApiKeyArray.randomElement()) {
        self.name = name
        self.apiKey = apiKey
    }
    
    let baseURL = Host.lostarkAPI.baseURL
    var path: String {
        return "/characters/\(name.changeToPercent())/siblings"
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

struct CharacterBasicInfoDTO: Decodable {
    let serverName: String?
    let characterName: String?
    let characterLevel: Int?
    let characterClassName: String?
    let itemAvgLevel: String?
    let itemMaxLevel: String?
}

extension CharacterBasicInfoDTO {
    private enum CodingKeys: String, CodingKey {
        case serverName = "ServerName"
        case characterName = "CharacterName"
        case characterLevel = "CharacterLevel"
        case characterClassName = "CharacterClassName"
        case itemAvgLevel = "ItemAvgLevel"
        case itemMaxLevel = "ItemMaxLevel"
    }
}
