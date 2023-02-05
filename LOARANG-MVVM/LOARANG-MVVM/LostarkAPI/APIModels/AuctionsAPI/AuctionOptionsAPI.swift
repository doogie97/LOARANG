//
//  AuctionOptionsAPI.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/02/05.
//

import Alamofire
import Foundation

struct AuctionOptionsAPI: Requestable {
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/auctions/options"
    let headers: [String : String] = [
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    let params: [String : Any] = [:]
    let httpMethod = HTTPMethod.get
    let encodingType = EncodingType.urlEncoding
}
