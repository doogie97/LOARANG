//
//  Equips.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/18.
//

import UIKit

struct Equips {
    let battleEquipments: BattleEquipments
    let accessories: Accessories
    let engrave: (EquipedEngrave?, EquipedEngrave?)
    let avatar: Avatar
    let specialEquipment: SpecialEquipments
    let gems: [Gem]
    let card: [CardInfo]? //임시 옵셔널
    
    enum Grade: Int {
        case nomal
        case advanced
        case rare
        case hero
        case legendary
        case artifact
        case ancient
        case esther
        
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
                return #colorLiteral(red: 0.5773422718, green: 0.3460586369, blue: 0.01250262465, alpha: 1)
            case .artifact:
                return #colorLiteral(red: 0.4901602268, green: 0.2024044096, blue: 0.03712747619, alpha: 1)
            case .ancient:
                return #colorLiteral(red: 0.7324138284, green: 0.6683282852, blue: 0.5068081021, alpha: 1)
            case .esther:
                return #colorLiteral(red: 0.1580955684, green: 0.5807852149, blue: 0.567861557, alpha: 1)
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
            }
        }
    }
}

enum EquipmentType { //나중에 JsonInfoManager안에 넣을지 고민 필요
    case battleEquipment
    case accessory
    case avatar
    case subAvatar
}

enum EquimentIndex: String { //나중에 JsonInfoManager안에 넣을지 고민 필요
    //장비
    case weapon = "000"
    case head = "001"
    case top = "002"
    case bottom = "003"
    case glove = "004"
    case shoulder = "005"
    //악세
    case necklace = "006"
    case firstEarring = "007"
    case secondEarring = "008"
    case firstRing = "009"
    case secondRing = "010"
    //어빌리티스톤
    case abilityStone = "011"
    //팔찌
    case bracelet = "026"
    //아바타
    case mainWeaponAvatar = "012"
    case mainHeadAvatar = "013"
    case mainTopAvatar = "014"
    case mainBottomAvatar = "015"
    case instrumentAvarat = "016"
    case fisrtFaceAvarat = "017"
    case secondFaceAvarat = "018"
    case subWeaponAvatar = "019"
    case subHeadAvatar = "020"
    case subTopAvatar = "021"
    case subBottomAvatar = "022"
    //특수장비
    case compass = "027"
    case amulet = "028"
    case emblem = "029"
}
