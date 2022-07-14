//
//  Equipment.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

struct Equipment {
    let titlt: String
    let part: String
    let lv: String
    let quality: Int?
    let grade: Int
    let basicEffects: BasicEffects
    let estherEffect: EstherEffect?
    let triPods: Tripods?
    let setEffects: SetEffects?
    let imageURL: String
}

struct BasicEffects {
    let basicEffect: String?
    let aditionalEffect: String?
}

struct EstherEffect {
    let firstEffect: String
    let secondEffect: String
}

struct Tripods {
    let firstTripod: String?
    let secondTripod: String?
    let thirdTripod: String?
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
