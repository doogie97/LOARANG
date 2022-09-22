//
//  OwnCharacterInfo.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/16.
//

struct OwnCharacterInfo {
    let title: String
    let ownCharacters: [OwnCharacter]
}

struct OwnCharacter {
    let server: String
    let name: String
    let battleLV: String
    let itemLV: String
    let guild: String
    let `class`: String
}
