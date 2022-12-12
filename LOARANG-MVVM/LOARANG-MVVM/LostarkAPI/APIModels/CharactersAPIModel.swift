//
//  CharactersAPIModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/11.
//

import Foundation
import Alamofire

struct CharactersAPIModel: Requestable {
    let baseURL = Host.lostarkAPI.baseURL
    let name: String
    var path: String {
        return "/characters/\(name.changeToPercent())/siblings"
    }
    let header: [String : String] = [
        "accept" : "application/json",
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    let params: [String : Any] = [:]
    let httpMethod = HTTPMethod.get
}

struct CharacterInfo: Decodable { //이 객체는 ARMORIES를 가져올때 내부에서 사용가능
    let serverName: String?
    let characterName: String?
    let characterLevel: Int?
    let characterClassName: String?
    let itemAvgLevel: String?
    let itemMaxLevel: String?
}

extension CharacterInfo {
    private enum CodingKeys: String, CodingKey {
        case serverName = "ServerName"
        case characterName = "CharacterName"
        case characterLevel = "CharacterLevel"
        case characterClassName = "CharacterClassName"
        case itemAvgLevel = "ItemAvgLevel"
        case itemMaxLevel = "ItemMaxLevel"
    }
}
