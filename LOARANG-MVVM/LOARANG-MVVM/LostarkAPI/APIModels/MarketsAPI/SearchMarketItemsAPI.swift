//
//  SearchMarketItemsAPI.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/12/15.
//

import Foundation
import Alamofire

struct SearchMarketItemsAPI: Requestable { //responseType: MarketItems
    let searchOption: SearchOption
    
    let baseURL = Host.lostarkAPI.baseURL
    let path = "/markets/items"
    let headers: [String : String] = [
        "authorization" : "Bearer \(Bundle.main.lostarkAPIKey)"
    ]
    var params: [String : Any] {
        return [
            "Sort" : searchOption.sort,
            "CategoryCode" : searchOption.categoryCode,
            "CharacterClass" : searchOption.characterClass,
            "ItemTier" : searchOption.itemTier,
            "ItemGrade" : searchOption.itemGrade,
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
        let itemGrade: String
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
