//
//  ChallengeGuardianRaidsGET.swift
//  LOARANG
//
//  Created by Doogie on 4/12/24.
//

import Foundation
import Alamofire

struct ChallengeGuardianRaidsGET: Requestable {
    private let apiKey: String?
    init(apiKey: String? = Bundle.main.lostarkApiKeyArray.randomElement()) {
        self.apiKey = apiKey
    }
    
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/gamecontents/challenge-guardian-raids"
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
