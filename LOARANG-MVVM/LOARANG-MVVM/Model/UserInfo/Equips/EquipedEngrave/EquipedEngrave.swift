//
//  EquipedEngrave.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import UIKit

struct EquipedEngrave {
    let name: String
    let activation: Int
    
    var titleColor: UIColor {
        switch activation {
        case 3..<6:
            return #colorLiteral(red: 0.5529411765, green: 0.9764705882, blue: 0.003921568627, alpha: 1)
        case 6..<9:
            return #colorLiteral(red: 0, green: 0.6901960784, blue: 0.9803921569, alpha: 1)
        case 9..<12:
            return #colorLiteral(red: 0.8078431373, green: 0.262745098, blue: 0.9882352941, alpha: 1)
        case 12:
            return #colorLiteral(red: 0.9764705882, green: 0.5725490196, blue: 0, alpha: 1)
        default:
            return .label
        }
    }
}
