//
//  CharacterImageViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class CharacterImageViewController: UIViewController {
    private let characterImageView = CharacterImageView()
    
    override func loadView() {
        super.loadView()
        self.view = characterImageView
    }
}
