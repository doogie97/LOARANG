//
//  MarketOptionsAPI.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/13.
//

import Foundation
import Alamofire

struct MarketOptionsAPI: Requestable {
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/markets/options"
    let headers: [String : String] = [
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    let params: [String : Any] = [:]
    let httpMethod = HTTPMethod.get
    let encodingType = EncodingType.urlEncoding
}
