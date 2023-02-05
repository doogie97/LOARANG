//
//  MarketItems.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/28.
//

import Foundation

struct MarketItems: Decodable {
    let pageNo: Int?
    let itemPerPage: Int?
    let totalCount: Int?
    let items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case pageNo = "PageNo"
        case itemPerPage = "PageSize"
        case totalCount = "TotalCount"
        case items = "Items"
    }
}

extension MarketItems {
    struct Item: Decodable {
        let id: Int?
        let name: String?
        let grade: String?
        let imageURL: String?
        let bundleCount: Int?
        let tradeRemainCount: Int?
        let yesterDayAVGPrice: Double?
        let recentPrice: Double?
        let minimumPrice: Double?
        
        enum CodingKeys: String, CodingKey {
            case id = "Id"
            case name = "Name"
            case grade = "Grade"
            case imageURL = "Icon"
            case bundleCount = "BundleCount"
            case tradeRemainCount = "TradeRemainCount"
            case yesterDayAVGPrice = "YDayAvgPrice"
            case recentPrice = "RecentPrice"
            case minimumPrice = "CurrentMinPrice"
        }
    }
}
