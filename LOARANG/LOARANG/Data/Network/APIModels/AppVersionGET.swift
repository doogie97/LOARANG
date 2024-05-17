//
//  AppVersionGET.swift
//  LOARANG
//
//  Created by Doogie on 5/16/24.
//

import Alamofire

struct AppVersionGET: Requestable {
    let baseURL = "https://itunes.apple.com"
    let path = "/lookup?bundleId=Doogie.LOARANG&country=kr"
    let header = [String : String]()
    let params = [String : Any]()
    let httpMethod = HTTPMethod.get
    let encodingType = EncodingType.urlEncoding
}

struct AppVersionDTO: Decodable {
    let results: [Result]?
    
    struct Result: Decodable {
        let version: String?
    }
}
