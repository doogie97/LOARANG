//
//  Equipment.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/25.
//
struct EquipmentInfo {
    let equipments: Equipments
    let gems: [Gem]
}

struct Equipments {
    let haed: EquipmentPart?
    let shoulder: EquipmentPart?
    let top: EquipmentPart?
    let bottom: EquipmentPart?
    let weapon: EquipmentPart?
    //let necklace: Accessory? 이런식으로 추가 필요
}

struct EquipmentPart {
    let titlt: String
    let part: String
    let lv: String
    let quality: Int
    let grade: Int
    let basicEffects: String
    let additionalEffects: String
    let firstTripod: String
    let secondTripod: String
    let thirdTripod: String
    let setEffectLv: String
    let firstSetEffect: String
    let secondSetEffect: String
    let thirdSetEffect: String
    let imageURL: String
}

enum EquimentIndex: String {
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
}
