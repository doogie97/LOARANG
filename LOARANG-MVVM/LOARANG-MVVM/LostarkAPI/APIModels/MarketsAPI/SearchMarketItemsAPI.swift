//
//  SearchMarketItemsAPI.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/15.
//

import Foundation
import Alamofire

struct SearchMarketItemsAPI: Requestable {
    let searchOption: SearchOption
    
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/markets/items"
    let headers: [String : String] = [
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    var params: [String : Any] {
        [
        "Sort" : searchOption.sort,
        "CategoryCode" : searchOption.categoryCode,
        "CharacterClass" : searchOption.characterClass,
        "ItemTier" : searchOption.itemTier,
        "ItemName" : searchOption.itemName,
        "PageNo" : searchOption.pageNo,
        "SortCondition" : searchOption.sortCondition.rawValue
        ]
    }
    let httpMethod = HTTPMethod.post
    let encodingType = EncodingType.urlEncoding
}

extension SearchMarketItemsAPI { // 일단 여기 담아두고 나중에 경매장에서도 쓰면 외부로 빼기
    struct SearchOption {
        let sort: SortOption
        let categoryCode: Int
        let characterClass: String
        let itemTier: Int
        let itemName: String
        let pageNo: Int
        let sortCondition: SortCondition
    }

    enum SortOption: String {
        case grade = "GRADE"
        case yesterDayAVGPrice = "YDAY_AVG_PRICE"
        case recentPrice = "RECENT_PRICE"
        case minimumPrice = "CURRENT_MIN_PRICE"
    }
    
    enum SortCondition: String {
        case asc = "ASC"
        case desc = "DESC"
    }
}

struct MarketSearchResponse: Decodable {
    let pageNo: Int
    let itemPerPage: Int
    let totalCount: Int
    let items: [Item]

    struct Item: Decodable {
        let id: Int
        let name: String
        let grade: String
        let imageURL: String
        let bundleCount: Int
        let tradeRemainCount: Int
        let yesterDayAVGPrice: Int
        let recentPrice: Int
        let minimumPrice: Int
    }
}

extension MarketSearchResponse {
    enum CodingKeys: String, CodingKey {
        case pageNo = "PageNo"
        case itemPerPage = "PageSize"
        case totalCount = "TotalCount"
        case items = "Items"
    }
}

extension MarketSearchResponse.Item {
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
