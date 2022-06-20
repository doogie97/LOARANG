//
//  CardInfo.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

struct CardInfo {
    let cards: [Card]
    let effect: [CardSetEffect]
}

struct Card {
    let name: String
    let awakeCount: Int
    let awakeTotal: Int
}

struct CardSetEffect {
    let desc: String
    let title: String
}
