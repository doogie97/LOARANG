//
//  BookmarkUserEntity.swift
//  LOARANG
//
//  Created by Doogie on 4/10/24.
//

import UIKit

struct BookmarkUserEntity {
    let name: String
    let image: UIImage
    let `class`: String
    
    var toDTO: BookmarkUserDTO {
        let bookmarkUser = BookmarkUserDTO()
        bookmarkUser.name = self.name
        bookmarkUser.imageData = self.image.pngData() ?? Data()
        bookmarkUser.class = self.`class`
        
        return bookmarkUser
    }
}
