//
//  CardInfo.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

struct CardInfo {
    let cards: [Card]
    let effects: [CardSetEffect]
}

struct Card {
    let name: String
    let tierGrade: Int
    let awakeCount: Int
    let awakeTotal: Int
    let imageURL: String
}

struct CardSetEffect {
    let desc: String
    let title: String
}
