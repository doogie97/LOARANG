//
//  Equipments.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/18.
//

struct Equipments {
    let battleEquipments: BattleEquipments
    let avatar: Avatar? // 임시 nil
}

enum EquipmentType { //나중에 JsonInfoManager안에 넣을지 고민 필요
    case battleEquipment
    case accessory
    case avatar
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
    
//    var partName: EquipmentPartName {
//        switch self {
//        case .weapon, .head, .top, .bottom, .glove, .shoulder:
//            return .battleEquipment
//        case .necklace, .firstEarring, .secondEarring, .firstRing, .secondRing, .abilityStone:
//            return .accessory
//        case .bracelet:
//            return .bracelet
//        case .mainWeaponAvatar, .mainHeadAvatar, .mainTopAvatar, .mainBottomAvatar, .instrumentAvarat, .fisrtFaceAvarat, .secondFaceAvarat, .subWeaponAvatar, .subHeadAvatar, .subTopAvatar, .subBottomAvatar:
//            return .avatar
//        }
//    }
}
