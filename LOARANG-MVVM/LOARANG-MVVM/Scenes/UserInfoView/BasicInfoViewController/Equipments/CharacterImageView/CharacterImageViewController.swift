//
//  CharacterImageViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class CharacterImageViewController: UIViewController {
    private let viewModel: CharacterImageViewModelable
    
    init(viewModel: CharacterImageViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let characterImageView = CharacterImageView()
    
    override func loadView() {
        super.loadView()
        self.view = characterImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserImage()
    }
    
    private func setUserImage() {
        characterImageView.setUserImageView(viewModel.userImage)
    }
}
