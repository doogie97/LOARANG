//
//  Stat.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

struct Stat {
    let basicEffect: BasicEffect
    let propensities: Propensities? //임시 옵셔널
    let engravigs: [Engraving]? //임시 옵셔널
}

struct BasicEffect {
    let attack: String
    let vitality: String
    let crit: String
    let specialization: String
    let domination: String
    let swiftness: String
    let endurance: String
    let expertise: String
}

struct Propensities {
    let intellect: String
    let courage: String
    let charm: String
    let kindness: String
}

struct Engraving {
    let title: String
    let describtion: String
}
