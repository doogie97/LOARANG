//
//  Skill.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

struct Skill {
    let name: String
    let coolTime: String
    let actionType: String
    let skillType: String
    let imageURL: String
    let battleType: String
    let skillLv: String
    let cost: String
    let skillDescription: String
    let tripods: [Tripod]
    let runeEffect: String
    let gemEffect: String
}

struct Tripod {
    let name: String
    let description: String
    let lv: String
    let imageURL: String
}
