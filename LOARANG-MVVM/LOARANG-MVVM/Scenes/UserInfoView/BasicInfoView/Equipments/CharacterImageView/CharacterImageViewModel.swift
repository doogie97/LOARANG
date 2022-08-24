//
//  CharacterImageViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/15.
//

import RxRelay

protocol CharacterImageViewModelable: CharacterImageViewModelInput, CharacterImageViewModelOutput {}

protocol CharacterImageViewModelInput {
    func touchShareButton()
}

protocol CharacterImageViewModelOutput {
    var userImage: UIImage { get }
    var showActivityVC: PublishRelay<UIImage> { get }
}

final class CharacterImageViewModel: CharacterImageViewModelable {
    init(userImage: UIImage) {
        self.userImage = userImage
    }
    
    //in
    func touchShareButton() {
        showActivityVC.accept(userImage)
    }
    
    // out
    let userImage: UIImage
    let showActivityVC = PublishRelay<UIImage>()
}
