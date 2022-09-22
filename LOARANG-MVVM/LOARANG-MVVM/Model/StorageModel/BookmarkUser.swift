//
//  BookmarkUser.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

import UIKit

struct BookmarkUser {
    let name: String
    let image: UIImage
    let `class`: String
    
    var convertedInfo: BookmarkUserDTO {
        let bookmarkUser = BookmarkUserDTO()
        bookmarkUser.name = self.name
        bookmarkUser.imageData = self.image.pngData() ?? Data()
        bookmarkUser.class = self.`class`
        
        return bookmarkUser
    }
}
