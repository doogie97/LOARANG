//
//  BattleEquipmentPart.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit

protocol EquipmentPartable {
    var name: String? { get }
    var quality: Int? { get }
    var grade: Int? { get }
    var imageURL: String? { get }
}
struct BattleEquipmentPart: EquipmentPartable {
    let name: String?
    let part: String?
    let lv: String?
    let quality: Int?
    let grade: Int?
    let imageURL: String?
    let battleEffects: String?
    
    enum Grade: Int {
        case nomal
        case advanced
        case rare
        case hero
        case legendary
        case artifact
        case ancient
        case esther
        
        var color: UIColor {
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
                return #colorLiteral(red: 0.5773422718, green: 0.3460586369, blue: 0.01250262465, alpha: 1)
            case .artifact:
                return #colorLiteral(red: 0.4901602268, green: 0.2024044096, blue: 0.03712747619, alpha: 1)
            case .ancient:
                return #colorLiteral(red: 0.7324138284, green: 0.6683282852, blue: 0.5068081021, alpha: 1)
            case .esther:
                return #colorLiteral(red: 0.1580955684, green: 0.5807852149, blue: 0.567861557, alpha: 1)
            }
        }
    }
}
