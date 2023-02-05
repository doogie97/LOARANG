//
//  MarketOptions.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/30.
//

import Foundation

struct MarketOptions: Decodable {
    let categories: [Category]?
    
    struct Category: Decodable {
        let subs: [Sub]?
        let code: Int?
        let codeName: String?
        
        struct Sub: Decodable {
            let code: Int?
            let codeName: String?
        }
    }
    
    let itemGrades: [String]?
    let itemTiers: [Int]?
    let classes: [String]?
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
