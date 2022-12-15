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
    let header: [String : String] = [
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    let params: [String : Any] = [:]
    let httpMethod = HTTPMethod.get
}

struct MarketOptions: Decodable {
    let categories: [Category]
    
    struct Category: Decodable {
        let subs: [Sub]
        let code: Int?
        let codeName: String?
        
        struct Sub: Decodable {
            let code: Int?
            let codeName: String?
        }
    }
    
    let itemGrades: [String]
    let itemTiers: [Int]
    let classes: [String]
}

extension MarketOptions {
    enum CodingKeys: String, CodingKey {
        case categories = "Categories"
        case itemGrades = "ItemGrades"
        case itemTiers = "ItemTiers"
        case classes = "Classes"
    }
}

extension MarketOptions.Category {
    enum CodingKeys: String, CodingKey {
        case subs = "Subs"
        case code = "Code"
        case codeName = "CodeName"
    }
}

extension MarketOptions.Category.Sub {
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case codeName = "CodeName"
    }
}
