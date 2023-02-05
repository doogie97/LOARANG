//
//  SearchMarketItemIdAPI.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/02/05.
//

import Alamofire
import Foundation

struct SearchMarketItemIdAPI: Requestable {
    let id: Int
    
    let baseURL = Host.lostarkAPI.baseURL
    var path: String {
        "/markets/items/\(id)"
    }
    let headers: [String : String] = [
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    let params: [String : Any] = [:]
    let httpMethod = HTTPMethod.get
    let encodingType = EncodingType.urlEncoding
}
