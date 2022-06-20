//
//  CardInfo.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/20.
//

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
