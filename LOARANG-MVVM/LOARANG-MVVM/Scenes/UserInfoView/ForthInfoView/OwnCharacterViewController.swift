//
//  OwnCharacterViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit

final class OwnCharacterViewController: UIViewController {
    private let viewModel: OwnCharacterViewModelable
    
    init(viewModel: OwnCharacterViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let ownCharacterView = OwnCharacterView()
    
    override func loadView() {
        self.view = ownCharacterView
    }
}
