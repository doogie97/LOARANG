//
//  Equipment.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/25.
//
struct UserEquipmentInfo {
    let equipments: Equipment
}

struct Equipment {
    let haed: EquipmentPart
    let shoulder: EquipmentPart
    let top: EquipmentPart
    let bottom: EquipmentPart
    let weapon: EquipmentPart
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
