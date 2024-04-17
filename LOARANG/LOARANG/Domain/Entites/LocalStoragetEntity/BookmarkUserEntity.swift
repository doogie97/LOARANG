//
//  BookmarkUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct BookmarkUserEntity {
    let name: String
    let imageUrl: String
    let characterClass: CharacterClass
    
    var toDTO: BookmarkUserDTO {
        let bookmarkUser = BookmarkUserDTO()
        bookmarkUser.name = self.name
        bookmarkUser.characterClass = self.characterClass.rawValue
        bookmarkUser.imageUrl = self.imageUrl
        
        return bookmarkUser
    }
}
