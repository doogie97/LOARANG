//
//  BattleEquipmentPart.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

struct EquipmentPart {
    let basicInfo: EquipmentBasicInfo
    let battleEffects: String?
}

struct EquipmentBasicInfo {
    let name: String?
    let part: String?
    let lv: String?
    let quality: Int?
    let grade: Int?
    let imageURL: String?
}
