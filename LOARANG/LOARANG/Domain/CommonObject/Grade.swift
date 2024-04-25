//
//  Grade.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit

enum Grade: String {
    case nomal = "노말"
    case advanced = "고급"
    case rare = "희귀"
    case hero = "영웅"
    case legendary = "전설"
    case artifact = "유물"
    case ancient = "고대"
    case esther = "에스더"
    case unknown = "알 수 없음"
    
    var backgroundColor: UIColor {
        switch self {
        case .nomal:
            return #colorLiteral(red: 0.593928329, green: 0.580765655, blue: 0.5510483948, alpha: 1)
        case .advanced:
            return #colorLiteral(red: 0.1626245975, green: 0.2453864515, blue: 0.06184400618, alpha: 1)
        case .rare:
            return #colorLiteral(red: 0.06879425794, green: 0.2269216776, blue: 0.347065717, alpha: 1)
        case .hero:
            return #colorLiteral(red: 0.2530562878, green: 0.06049384922, blue: 0.3300251961, alpha: 1)
        case .legendary:
            return #colorLiteral(red: 0.5246120691, green: 0.3031592071, blue: 0.003560988232, alpha: 1)
        case .artifact:
            return #colorLiteral(red: 0.5784874356, green: 0.1879552667, blue: 0.0295805793, alpha: 1)
        case .ancient:
            return #colorLiteral(red: 0.7324138284, green: 0.6683282852, blue: 0.5068081021, alpha: 1)
        case .esther:
            return #colorLiteral(red: 0.1580955684, green: 0.5807852149, blue: 0.567861557, alpha: 1)
        case .unknown:
            return .clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .nomal:
            return .label
        case .advanced:
            return #colorLiteral(red: 0.5529411765, green: 0.9764705882, blue: 0.003921568627, alpha: 1)
        case .rare:
            return #colorLiteral(red: 0, green: 0.6901960784, blue: 0.9803921569, alpha: 1)
        case .hero:
            return #colorLiteral(red: 0.8078431373, green: 0.262745098, blue: 0.9882352941, alpha: 1)
        case .legendary:
            return #colorLiteral(red: 0.9764705882, green: 0.5725490196, blue: 0, alpha: 1)
        case .artifact:
            return #colorLiteral(red: 0.9803921569, green: 0.3647058824, blue: 0, alpha: 1)
        case .ancient:
            return #colorLiteral(red: 0.8901960784, green: 0.7803921569, blue: 0.631372549, alpha: 1)
        case .esther:
            return #colorLiteral(red: 0.2352941176, green: 0.9490196078, blue: 0.9019607843, alpha: 1)
        case .unknown:
            return .clear
        }
    }
}
