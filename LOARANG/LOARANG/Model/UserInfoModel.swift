//
//  UserInfoModel.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

struct UserInfo {
    let basicInfo: BasicInfo
    let basicAbility: BasicAbility
}

struct BasicInfo {
    let name: String
    let server: String
    let `class`: String
    let expeditionLevel: String
    let title: String
    let itemLevel: String
    let guild: String
    let pvp: String
    let wisdom: String
    let battleLevel: String
}

struct BasicAbility {
    let att: String
    let vitality: String
    let crit: String
    let specialization: String
    let domination: String
    let swiftness: String
    let endurance: String
    let expertise: String
}

struct CardInfo {
    var first: Card?
    let second: Card?
    let third: Card?
    let fourth: Card?
    var fifth: Card?
    let sixth: Card?
}

struct Card {
    let name: String
    let awakeCount: Int
    let awakeTotal: Int
}
