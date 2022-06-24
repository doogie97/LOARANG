//
//  UserInfoModel.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/26.
//

struct UserInfo {
    let basicInfo: BasicInfo
    let basicAbility: BasicAbility
    let userJsonInfo: UserJsonInfo
}

struct UserJsonInfo {
    let cardInfo: CardInfo
//    let gemInfo: [Gem]
}
