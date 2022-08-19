//
//  BattleEquipmentPart.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

struct BattleEquipmentPart {
    let name: String?
    let part: String?
    let lv: String?
    let quality: Int?
    let grade: Int?
    let imageURL: String?
    let basicEffects: BasicEffects?
    let estherEffect: EstherEffect?
    let setEffects: SetEffects?
}

struct BasicEffects {
    let basicEffect: String?
    let aditionalEffect: String?
}

struct EstherEffect {
    let firstEffect: String
    let secondEffect: String
}

struct SetEffects {
    struct Effects {
        let firstSetEffect: String?
        let secondSetEffect: String?
        let thirdSetEffect: String?
    }
    let setEffectLv: String?
    let effects: Effects?
}
