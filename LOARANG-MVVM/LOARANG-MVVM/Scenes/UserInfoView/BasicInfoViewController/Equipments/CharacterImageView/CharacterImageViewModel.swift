//
//  CharacterImageViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/15.
//

import UIKit

protocol CharacterImageViewModelable: CharacterImageViewModelInput, CharacterImageViewModelOutput {}

protocol CharacterImageViewModelInput {}

protocol CharacterImageViewModelOutput {
    var userImage: UIImage { get }
}

final class CharacterImageViewModel: CharacterImageViewModelable {
    init(userImage: UIImage) {
        self.userImage = userImage
    }
    
    // out
    let userImage: UIImage
}
