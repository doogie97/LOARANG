//
//  MarketItemIdResponse.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/02/05.
//

struct MarketItem: Decodable {
    let name: String?
    let tradeRemainCount: Int?
    let bundleCount: Int?
    let toolTip: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case tradeRemainCount = "TradeRemainCount"
        case bundleCount = "BundleCount"
        case toolTip = "ToolTip"
    }
}

